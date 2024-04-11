#include <iostream>
#include <openfhe.h>
#include <vector>

using namespace lbcrypto;
using namespace std;

// ** Entry point of the application that orchestrates the flow. **

int main() {

  std::cout << "Test.." << std::endl;

  CCParams<CryptoContextCKKSRNS> parameters;

  uint32_t multDepth = 15;

  // ScalingTechnique rescaleTech = FIXEDAUTO;

  // parameters.SetSecurityLevel(HEStd_128_classic);
  parameters.SetMultiplicativeDepth(multDepth);
  parameters.SetScalingModSize(45);
  parameters.SetBatchSize(32768);
  // parameters.SetScalingTechnique(rescaleTech);

  CryptoContext<DCRTPoly> cc = GenCryptoContext(parameters);
  cc->Enable(PKE);
  cc->Enable(KEYSWITCH);
  cc->Enable(LEVELEDSHE);
  cc->Enable(ADVANCEDSHE);

  auto keyPair = cc->KeyGen();
  cc->EvalMultKeyGen(keyPair.secretKey);
  auto pk = keyPair.publicKey;

  unsigned int batchSize = cc->GetEncodingParams()->GetBatchSize();
  std::cout << "batchSize: " << batchSize << std::endl;

  std::cout << "CKKS default parameters: " << parameters << std::endl;
  std::cout << std::endl;
  std::cout << std::endl;

  std::cout << "scaling mod size: " << parameters.GetScalingModSize()
            << std::endl;
  std::cout << "ring dimension: " << cc->GetRingDimension() << std::endl;
  std::cout << "noise estimate: " << parameters.GetNoiseEstimate() << std::endl;
  std::cout << "multiplicative depth: " << parameters.GetMultiplicativeDepth()
            << std::endl;
  std::cout << "Noise level: " << parameters.GetNoiseEstimate() << std::endl;

  std::vector<double> x = {0.25, 0.5, 0.75, 1.0};

  Plaintext ptxt = cc->MakeCKKSPackedPlaintext(x);

  auto c = cc->Encrypt(pk, ptxt);
  auto cMULT = cc->EvalMult(c, c);

  Plaintext result;

  std::cout.precision(8);
  cc->Decrypt(keyPair.secretKey, cMULT, &result);

  result->SetLength(4);
  std::cout << "Results " << result << std::endl;

  std::vector<double> res = result->GetRealPackedValue();

  std::cout << "Res: " << res << std::endl;

  return 0;
}
