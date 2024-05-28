from PIL import Image, ImageDraw
import time 
import random
import argparse
import os

def grayscale_image(img_file, output_file):
    with Image.open(img_file) as im:
        grayscale = im.convert("L")
        grayscale.save(f'{output_file}')
    return

def save_minutia(img_file, minutia_file, output_file):

    with Image.open(img_file) as im:
        # pixels = im.load()

        # rgbimg = Image.new("RGBA", im.size)
        # rgbimg.paste(im)

        if im.mode == 'L':
            im = im.convert('RGB')

        with open(minutia_file) as f:
            for line in f:
                # print(line.strip())
                x, y, t, _ = list(map(int,line.strip().split()))

                for i in range(-2, 3):
                    for j in range(-2, 3):
                        try:
                            im.putpixel((x+i, y+j), (255, 0, 0, 255))
                            # im.putpixel((x+i, y+j), (255))
                        except:
                            print('passed')
                # im.putpixel((x, y), (255))
        im.show()
        if output_file != None:
            im.save(output_file)
    return

def minutia_pairings(img_file, matching_file, output_file):

    coords = []

    with open(matching_file) as f:
        lines = f.readlines()# [:16]
        for line in lines:
            line = line.rstrip()
            _, _, co = line.split(';')
            a, b = co.split(') (')
            a = a.strip()
            a = a[1:].strip()
            b = b[:-1].strip()
            ax, ay = list(map(int, a.split(', ')))
            bx, by = list(map(int, b.split(', ')))
            coords.append( [ (ax, ay), (bx, by) ] )
    
    with Image.open(img_file) as im:
        draw_pairings(im, coords, output_file, save=(output_file!=None))

def draw_pairings(im, pairs, output_file, show=True, save=True, color=(255,165,0,255)):
    if im.mode == 'L':
        im = im.convert('RGB')

    for co in pairs:
        img1 = ImageDraw.Draw(im)
        img1.line(co, fill=color, width=2)

    if show:
        im.show()
    if save:
        im.save(output_file)
    return im

def similarity_pairings(img0_file, img1_file, sim_file, output, save_in_different=False):
    global_angles = {}

    with open(sim_file) as f:
        lines = f.readlines()
        for line in lines:
            ang, cx0, cy0, cx1, cy1, sx0, sy0, sx1, sy1 = list(map(int, line.strip().split(',')))
            if ang not in global_angles:
                global_angles[ang] = [[],[]]

            # client pairings
            global_angles[ang][0].append( [(cx0, cy0), (cx1, cy1)] )

            # server pairings
            global_angles[ang][1].append( [(sx0, sy0), (sx1, sy1)] )
    
    # handle output files
    if output == None:
        output = 'ang_'
    else:
        output += '_'

    cim = Image.open(img0_file)
    sim = Image.open(img1_file)
    combined_im = Image.new('RGB', (2*cim.size[0] + 20, cim.size[1]))

    for ang in global_angles.keys():
        client_pairs = global_angles[ang][0]
        server_pairs = global_angles[ang][1]

        color = (30, 247, 15, 255)
        # color = (6, 92, 0, 255)
        color = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255), 255)

        cim = draw_pairings(cim, client_pairs, '', show=False, save=False, color=color)
        sim = draw_pairings(sim, server_pairs, '', show=False, save=False, color=color)

        if save_in_different:
            cim = Image.open(img0_file)
            sim = Image.open(img1_file)
            combined_im = Image.new('RGB', (2*cim.size[0] + 20, cim.size[1]))
            color = (30, 247, 15, 255)

            cim = draw_pairings(cim, client_pairs, '', show=False, save=False, color=color)
            sim = draw_pairings(sim, server_pairs, '', show=False, save=False, color=color)

            combined_im.paste(cim, (0,0))
            combined_im.paste(sim, (cim.size[0]+20,0))
            # combined_im.show()
            combined_im.save(f'./sim_output/{output}{ang}.JPEG')

    if save_in_different:
        return

    combined_im.paste(cim, (0,0))
    combined_im.paste(sim, (cim.size[0]+20,0))
    combined_im.show()
    # combined_im.save(f'./sim_output/{output}_{ang}.JPEG')
    return

def main():

    parser = argparse.ArgumentParser(prog="minutia.py", description="this program will help create images to describe how bozorth3 algorithm works")
    parser.add_argument('mode', action='store', help='g=grayscale, m=minutia, p=pairing, s=similarity, sm=similarity multiple pics')
    parser.add_argument('-f', '--file', action='append', dest='files')
    parser.add_argument('-o', '--output', action='store', dest='output')
    parser.add_argument('-x', '--xyt', action='store', dest='xyt')
    parser.add_argument('-s', '--sim', action='store', dest='sim')
    parser.add_argument('-p', '--pairs', action='store', dest='pairs')

    args = parser.parse_args()
    mode = args.mode
    files = args.files
    output = args.output
    xyt = args.xyt
    sim = args.sim
    pairs = args.pairs

    # perform actions in each given mode
    if mode == 'g' or mode == 'grayscale':
        if not files:
            print('ERROR: expected 1 file for input')
            exit(1)
        if not output:
            print('ERROR: expected 1 file for output')
            exit(1)

        grayscale_image(files[0], output)

    elif mode == 'm' or mode == 'minutia':
        if not files:
            print('ERROR: expected 1 file for input')
            exit(1)
        if not xyt:
            print('ERROR: expected an .xyt file')
            exit(1)

        save_minutia(files[0], xyt, output)

    elif mode == 'p' or mode == 'pairing':
        if not files:
            print('ERROR: expected 1 file for input')
            exit(1)
        if not pairs:
            print('ERROR: expected a pairs txt file')
            exit(1)

        minutia_pairings(files[0], pairs, output)

    elif mode == 's' or mode == 'similarity':
        if not files or len(files) < 2:
            print('ERROR: expected 2 files for input')
            exit(1)
        if not sim:
            print('ERROR: expected a similarity txt file')
            exit(1)
        similarity_pairings(files[0], files[1], sim, output)

    elif mode == 'sm':
        if not files or len(files) < 2:
            print('ERROR: expected 2 files for input')
            exit(1)
        if not sim:
            print('ERROR: expected a similarity txt file')
            exit(1)

        try:
            os.mkdir('sim_output')
        except OSError as error:
            pass # sim_output already exists

        similarity_pairings(files[0], files[1], sim, output, save_in_different=True)

    else:
        print('Invalid mode given')
        print('\tmode = [g=grayscale, m=minutia, p=pairing, s=similarity, sm=similarity multiple pics]')
        exit(1)

    return

    # grayscale_image('6.JPEG')
    # grayscale_image('9.JPEG')
    # print()
    # update_image('1_1.jpg')
    # return 
    # save_minutia('6.JPEG', '6.xyt', '6_minutia.JPEG')
    # save_minutia('9.JPEG', '9.xyt', '9_minutia.JPEG')
    # save_minutia('1_1.jpg', '1_1.jpg.xyt', '1_1_minutia.jpg')
    # minutia_pairings('test_minutia.JPEG', '32_matches.txt', 'test_pairings.JPEG')
    # similarity_pairings('test_minutia.JPEG', 'test_minutia.JPEG','similarity_pairs.txt', 'test_similarity.JPEG')
    # similarity_pairings('test_minutia.JPEG', 'test_minutia.JPEG','sim_pairs.txt', 'test')
    similarity_pairings('6_minutia.JPEG', '9_minutia.JPEG','6_9_sim.txt', '6_9')
    return

if __name__ == '__main__':
    main()
