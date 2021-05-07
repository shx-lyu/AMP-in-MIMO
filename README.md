# AMP-in-MIMO
Approximate Message Passing (AMP) for Massive MIMO Detection

# File Description
AMPG.m: the AMP algorithm using Gaussian distributions on the prior symbols.

AMPT.m: the AMP algorithm using {0,1,-1} on the prior symbols.

main_AMPG_LMMSE.m: the stand-alone main file that plots the symbol error rate (SER) performance of AMPG and linear MMSE (LMMSE).

main_massive_detection.m: the main file that compares the SER performance of hybrid decoding with LMMSE and AMPG, where hybrid decoding can be performed by either using LMMSE+AMPG or LMMSE+AMPT.

![main_AMPG_LMMSE](FIG1-SER.jpg)
![main_massive_detection](FIG2-SER.jpg)

# Copyright
If you use our codes in your research, please acknowledge our work by citing the following paper:

Shanxiang Lyu, Cong Ling: Hybrid Vector Perturbation Precoding: The Blessing of Approximate Message Passing. IEEE Trans. Signal Process. 67(1): 178-193 (2019).

# Maintainer
Shanxiang Lyu

Associate Professor, Jinan University, Guangzhou

Email: shanxianglyu@gmail.com

Homepage: https://sites.google.com/view/shanx

# History
These files were posted on my personal website (http://www.commsp.ee.ic.ac.uk/~slyu/approximate-message-passing-amp-for-massive-mimo-detection-matlab-codes-provided/index.html, edition-1) and MATHWORK (https://www.mathworks.com/matlabcentral/fileexchange/69206-approximate-message-passing-amp-for-massive-mimo-detection, edition-2). When I started my PhD in around 2014, one of my research projects is to apply the AMP algorithm to solve the closest vector problem (CVP) of lattices, and the popular MIMO detection problem is no more than a special case of CVP. The initial attempt was to understand the technical paper that I noted as BM11 ("The dynamics of message passing on dense graphs, with applications to compressed sensing", Mohsen Bayati AND Andrea Montanari, IEEE TIT, 2011). Later I tried to simplify Belief Propagation to derive the set of equations used in AMP (see Sec. IV in "Hybrid Vector Perturbation Precoding: The Blessing of Approximate Message Passing", S. Lyu and C. Ling, IEEE TSP, 2019). Regardless of the versions of AMP that we are using, a critical step in its MIMO detection application is to assign the a priori distribution to the "x" of "y=H*x+n". While in the transmission "x" is admitting a uniform distribution over QAM symbols, in detection we may temporarily assume that "x" admits a Gaussian distribution, and the estimated "x" can be further quantized to obtain discrete QAM symbols. I call the AMP algorithm using this Gaussian prior as AMPG, and this algorithm is surprisingly simple with only 3 lines of codes. While the AMPG algorithm is slightly different with those in BM11, the principles are the same. In addition, Jeon and Studer published their result of using the exact priori in AMP (AMP-exact) in the 2015 ISIT, which certainly outperforms AMPG in the SER performance, so I decided to post the codes (edition-1) on my personal website in 2015. When it comes to 2017, to address the issue that AMP-exact cannot perform well when the range of “x” is large (beyond +-1 and small QAM), I developed a scheme that aims to bypass this constraint. Specially, in a two-step procedure, we first adopt a low-complexity algorithm to temporarily estimate “x”. If this estimate is not too far from the actual “x”, we can employ AMP with a smaller range of prior symbols. The simplest case is to assign only “0,1,-1” to “x”, and this algorithm is noted as AMPT. While this hybrid decoding algorithm can perform well in MIMO detection, the MIMO precoding problem seems technically more general, so I decided to formulate the stuff in the precoding context and submitted it to IEEE TSP. Nevertheless, the application to MIMO detection is still formulated in Section VII of the IEEE TSP 2019 paper.
