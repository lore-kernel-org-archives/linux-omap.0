From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc7
Date: Tue, 2 Dec 2014 18:39:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412021838410.16734@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33942 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaLBSjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2014 13:39:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.18-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc7/20141201203859/


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
    FAIL ( 1/16): 2430sdp
    skip ( 2/16): 5912osk, 3517evm
    Pass (13/16): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, 5430es2uevm,
		  5430es2sbct54, 2420n800

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 7/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 5/12): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

PM: chip off via dynamic idle:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.18-rc6 (5d01410fe4d92081f349b013a2e7a95429e4f2c9)):
   text     data      bss    total  kernel
   +100     +336        0     +436  omap1_defconfig
   -956     +336        0     -620  omap1_defconfig_1510innovator_only
   -892     +328        0     -564  omap1_defconfig_5912osk_only
   -303     +456        0     +153  multi_v7_defconfig
    -59     +744        0     +685  omap2plus_defconfig
   -863     +488        0     -375  omap2plus_defconfig_2430sdp_only
  -4095     +736        0    -3359  omap2plus_defconfig_am33xx_only
     +5     +744        0     +749  omap2plus_defconfig_am43xx_only
    -59     +776        0     +717  omap2plus_defconfig_cpupm
     +5     +736        0     +741  omap2plus_defconfig_dra7xx_only
   -255     +488        0     +233  omap2plus_defconfig_n800_multi_omap2xxx
   -287     +456        0     +169  omap2plus_defconfig_n800_only_a
   +145     +768        0     +913  omap2plus_defconfig_no_pm
     +5     +776        0     +781  omap2plus_defconfig_omap2_4_only
     +1     +744        0     +745  omap2plus_defconfig_omap3_4_only
    -59     +712        0     +653  omap2plus_defconfig_omap5_only
   -172     +264      +64     +156  rmk_omap3430_ldp_allnoconfig
    +21     +456        0     +477  rmk_omap3430_ldp_oldconfig
   -124     +292      +48     +216  rmk_omap4430_sdp_allnoconfig
  -4007     +648        0    -3359  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc6 (5d01410fe4d92081f349b013a2e7a95429e4f2c9))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2430sdp        omap2plus_defconfig
    -4k     4k      .      .  3730beaglexm   omap2plus_defconfig
    -4k     4k      .      .  3730es12beaglexmomap2plus_defconfig
     8k    -8k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only


