From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM/hwmod/clock non-regression fixes and
 optimizations for v3.15
Date: Fri, 28 Feb 2014 20:41:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402282039400.453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60962 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaB1UlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 15:41:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.15/omap-hwmod-clk-prcm-a

for you to fetch changes up to 110e884d829448e24959f424b31be5bc75bcca6e:

  ARM: OMAP3+: DPLL: stop reparenting to same parent if already done (2014-02-28 12:43:47 -0700)

- ----------------------------------------------------------------
Some low-level optimizations and fixes that don't belong in an -rc
series for various OMAP-family chips, targeted for v3.15.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/prcm-a-for-v3.15/20140228124518/

- ----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP Support

Lokesh Vutla (1):
      ARM: OMAP2+: AM43xx: implement support for machine restart

Nishanth Menon (1):
      ARM: OMAP3+: DPLL: stop reparenting to same parent if already done

Suman Anna (1):
      ARM: AM43x: hwmod data: register spinlock OCP interface

Tomi Valkeinen (1):
      ARM: OMAP2+: clock: fix rate prints

 arch/arm/mach-omap2/Makefile               |  1 +
 arch/arm/mach-omap2/board-generic.c        |  1 +
 arch/arm/mach-omap2/clkt_dpll.c            |  6 +++---
 arch/arm/mach-omap2/cminst44xx.c           | 18 ++++++++++++++++--
 arch/arm/mach-omap2/dpll3xxx.c             |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  1 +
 arch/arm/mach-omap2/prminst44xx.c          |  3 +++
 7 files changed, 26 insertions(+), 6 deletions(-)


vmlinux object size
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72)):
   text     data      bss    total  kernel
      0       -8        0       -8  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only

vmlinux object size
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72)):
   text     data      bss    total  kernel
+8791542  +826036  +291072  +9908650  multi_v7_defconfig
   +116        0        0     +116  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_am33xx_only
   +148        0        0     +148  omap2plus_defconfig_am43xx_only
   +116        0        0     +116  omap2plus_defconfig_cpupm
   +116        0        0     +116  omap2plus_defconfig_dra7xx_only
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
    +52        0        0      +52  omap2plus_defconfig_no_pm
   +116        0        0     +116  omap2plus_defconfig_omap2_4_only
    +52        0        0      +52  omap2plus_defconfig_omap3_4_only
    +52        0        0      +52  omap2plus_defconfig_omap5_only
    +32        0        0      +32  rmk_omap3430_ldp_allnoconfig
    +32        0        0      +32  rmk_omap3430_ldp_oldconfig
   +100        0      -16      +84  rmk_omap4430_sdp_allnoconfig
    +96        0        0      +96  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72))
  avail  rsrvd   high  freed  board          kconfig
(no differences)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTEPPsAAoJEMePsQ0LvSpLoWQP+wTCBbfzVhY+yvNLZbYc59DY
duYOkXjzjZTofZ+UOCI8C4gl3vstSf0TxXK+moUKmJ9kJWIV3nRKAHEraxO6KYz6
ERWuocHYVA5xY3c9SSXxUjiGV055h3swlwkkvDDpDrqhO8kCILLPIcDPE6e+H/Y2
YSlA4cwDg3vsyP2afYbdtU1F3cNq+lclwCSSDZ80n/UOGirs2TQdlX2DE0Nd+vyd
N69Ebiw5lErn2vCSgy3RV2WgKZfryU020598DPr9lrUHtoS2K4uBLc6EhziBLs1K
gzti3cNqN/JFIU53M5G6HM04olO8AXPELDOifbGasxCGOk/dJ5xBkXEFUSE1lRFF
O+5lM7WNkoewrQqUrJwdvNVMC3a8BINmS0LJkig6Wzx1NGBEINUCpaVOLoYXuQMT
fsLMDv7mCIIGzPQmk/YJ8MgtgO70JyQvxndAhcXxsIgW4pN1OcMC/SBj/CELA8UX
dqudF9nJHmH2FeteKwJ14b5RXgXkeO0jpjyArdQ+JCwiUW4sUj9cn8yMDt06lYbe
A7VwivspiP+U4hvDIohaCXeiydAbqlX+CWwjfESu4au7whTiJW+Z9WlWLAVSN1Zx
rj/nCVC7OB/tfYgn5eNXl616/Qbxa5CoNl8h3+DKJPLf1Uegy2FUedjGZEbKHzlZ
uEdboLUyL12CD5t3Lgv8
=6PrI
-----END PGP SIGNATURE-----
