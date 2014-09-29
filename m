From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc7
Date: Mon, 29 Sep 2014 17:13:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49195 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaI2RNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 13:13:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc7/20140928222901/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (17/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 3/17): 5912osk, 4430es2panda, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4460pandaes, 4460varsomom,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

PM: chip retention via suspend:
    skip ( 1/12): 4430es2panda
    FAIL ( 5/12): am335xbonelt, 4460varsomom, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    skip ( 1/12): 4430es2panda
    FAIL ( 6/12): am335xbonelt, 4460pandaes, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 5/12): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

PM: chip off via dynamic idle:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.17-rc6 (0f33be009b89d2268e94194dc4fd01a7851b6d51)):
   text     data      bss    total  kernel
    -53        0        0      -53  omap1_defconfig
    +11      +32        0      +43  omap1_defconfig_1510innovator_only
    -21        0        0      -21  omap1_defconfig_5912osk_only
   +775       -8        0     +767  multi_v7_defconfig
   +551        0        0     +551  omap2plus_defconfig
     -5        0        0       -5  omap2plus_defconfig_2430sdp_only
   +391        0        0     +391  omap2plus_defconfig_am33xx_only
    +79        0        0      +79  omap2plus_defconfig_am43xx_only
   +551        0        0     +551  omap2plus_defconfig_cpupm
   +151        0        0     +151  omap2plus_defconfig_dra7xx_only
   -159        0        0     -159  omap2plus_defconfig_n800_multi_omap2xxx
   -159       +8        0     -151  omap2plus_defconfig_n800_only_a
   +547        0        0     +547  omap2plus_defconfig_no_pm
    +79        0        0      +79  omap2plus_defconfig_omap2_4_only
   +227        0        0     +227  omap2plus_defconfig_omap3_4_only
    +79        0        0      +79  omap2plus_defconfig_omap5_only
   +260        0      -60     +200  rmk_omap3430_ldp_allnoconfig
    +99       -8        0      +91  rmk_omap3430_ldp_oldconfig
    +48        0       +4      +52  rmk_omap4430_sdp_allnoconfig
    -23       -8        0      -31  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc6 (0f33be009b89d2268e94194dc4fd01a7851b6d51))
  avail  rsrvd   high  freed  board          kconfig
 -224768k -36352k      .  -404k  3517evm        omap2plus_defconfig
 -484604k -38660k      .  -404k  4430es2panda   omap2plus_defconfig
    -4k     4k      .      .  am335xbonelt   omap2plus_defconfig


The 4430 Pandaboard and the 3517EVM have gone offline.  These boards will 
require some additional investigation which probably won't happen until 
November.  In the meantime, they've been moved to the "skip" column in the 
test results.

