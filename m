From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: hwmod/clock: more fixes for v3.10-rc
Date: Thu, 6 Jun 2013 17:49:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306061746150.5152@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40243 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3FFRtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 13:49:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.10-rc

for you to fetch changes up to a93d8a1cea0899982993e9a93404c6f78b123697:

  ARM: omap3: clock: fix wrong container_of in clock36xx.c (2013-06-06 08:48:07 -0600)

- ----------------------------------------------------------------
More OMAP hwmod and clock fixes for v3.10-rc.  Fixes the AM33xx UART2.
Also fixes some CCF-related breakage on OMAP36xx/37xx, affecting DSS
at the very least.

Basic test logs for this branch are here:

http://www.pwsan.com/omap/testlogs/fixes_b_v3.10-rc/20130606093449/

- ----------------------------------------------------------------
Jean-Philippe Francois (1):
      ARM: omap3: clock: fix wrong container_of in clock36xx.c

Thomas Petazzoni (1):
      arm: omap2: fix AM33xx hwmod infos for UART2

 arch/arm/mach-omap2/clock36xx.c            |   18 +++++++++---------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    9 ++++++++-
 2 files changed, 17 insertions(+), 10 deletions(-)

vmlinux object size
(delta in bytes from test_v3.10-rc4 (d683b96b072dc4680fc74964eca77e6a23d1fa6e)):
   text     data      bss    total  kernel
      0      +64        0      +64  am33xx_only
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0      +64        0      +64  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0      +64        0      +64  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
    -64      +64        0        0  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_allnoconfig
      0      +64        0      +64  rmk_omap4430_sdp_oldconfig
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRsMs0AAoJEMePsQ0LvSpLSkEQAJDav8PjK8w1P604lTMlxS9l
CopkUktCtXKu+E/LRZ0H8Cd2h2hhPemqJPdTGLfd0QH2B5fF5HwBVDqJ7FYCyf6h
6wg4HFJ2LkplzRHydlL7hylESRefZM5SmDH7fuwAD3BGa7LcYsX4q3GBpnRQJyH4
0LXa1GuWNs5PqL1ZVKGjZE3ycMmB751yMsiTMkE2XocuXfyJnNFdf8mnfCGsjoPM
BIzkOJCQc9cHxBPS1zhDU8iiiKILdaKtniL0iQ/22HKR+KFo/XvOaRQi1VbkmJM/
amWbNnrgjyPoNUuGld54564vrmc7KvgXNRibX20R3dkJa2IsLTJNLUkJEKPIZKMi
lALYNpm1raL1Wnq6xf/3xTAiK3IBqK+Gztsdf3Ya61uDrsNeCPrS+LJ9NRAtfVNQ
G07FVoo2Il5CgJ94MLSS8DQVRAnG7Xofwfb7iN/J0tn0iFwPcrqV485F2TNitHKS
H7vh5DhX/zXhTqt0gB94R1nIHY7c4hNuhqK368K42aPBAbhwWxrwWS0SS0mNZW79
FEeoz/VwnxA+zviZbZOwSUbibpkp4XI6PdP6J7PYzsOdfdjsYyUbW7Nss1DCIyYz
vcCvh8+8xEpRkujwOTOePOmhmj9vqIUJirA+1DOcfGF9MYzKSB0XIpcbieAp7pUp
qG2KLm+gDfiJkxRH3IZX
=qUET
-----END PGP SIGNATURE-----
