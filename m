From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc3
Date: Wed, 5 Nov 2014 22:43:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411052239570.25985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47666 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaKEWnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 17:43:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.18-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc3/20141105113246/


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
    FAIL ( 3/17): 4430es2panda, 2430sdp, 3517evm
    skip ( 1/17): 5912osk
    Pass (13/17): am335xbonelt, am335xbone, 4460pandaes, 4460varsomom,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm,
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
(delta in bytes from test_v3.18-rc2 (cac7f2429872d3733dc3f9915857b1691da2eb2f)):
   text     data      bss    total  kernel
 -14014       -8        0   -14022  omap1_defconfig
 -13982      -40        0   -14022  omap1_defconfig_1510innovator_only
  -9918       -8      -32    -9958  omap1_defconfig_5912osk_only
  -8275      +72      -64    -8267  multi_v7_defconfig
 -14286       +8        0   -14278  omap2plus_defconfig
 -14418      -56      -32   -14506  omap2plus_defconfig_2430sdp_only
 -14198      -16        0   -14214  omap2plus_defconfig_am33xx_only
 -14450      +16        0   -14434  omap2plus_defconfig_am43xx_only
 -14286       +8        0   -14278  omap2plus_defconfig_cpupm
 -14386      -16        0   -14402  omap2plus_defconfig_dra7xx_only
   +754      +16        0     +770  omap2plus_defconfig_n800_multi_omap2xxx
   +754      +16        0     +770  omap2plus_defconfig_n800_only_a
 -14226      -88        0   -14314  omap2plus_defconfig_no_pm
 -10302      -16        0   -10318  omap2plus_defconfig_omap2_4_only
 -14402       +8        0   -14394  omap2plus_defconfig_omap3_4_only
 -14386       -8        0   -14394  omap2plus_defconfig_omap5_only
  +1748      +32      +52    +1832  rmk_omap3430_ldp_allnoconfig
 +65072    +3896    +8516   +77484  rmk_omap3430_ldp_oldconfig
  +1832      +44      +20    +1896  rmk_omap4430_sdp_allnoconfig
 -13714      -80      -60   -13854  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc2 (cac7f2429872d3733dc3f9915857b1691da2eb2f))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  2430sdp        omap2plus_defconfig
     8k    -8k      .     4k  3530es31beagle omap2plus_defconfig
     8k    -8k      .     4k  3530es3beagle  omap2plus_defconfig
     8k    -8k      .     4k  3730beaglexm   omap2plus_defconfig
     8k    -8k      .     4k  3730es12beaglexmomap2plus_defconfig
     8k    -8k      .     4k  37xxevm        omap2plus_defconfig
     8k    -8k      .     4k  4460pandaes    omap2plus_defconfig
     8k    -8k      .     4k  4460varsomom   omap2plus_defconfig
     8k    -8k      .     4k  5430es2sbct54  omap2plus_defconfig
     8k    -8k      .     4k  5430es2uevm    omap2plus_defconfig
     8k    -8k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
     8k    -8k      .     4k  cmt3517        omap2plus_defconfig

The N800 has been added back to the testbed.

The size difference in rmk's rmk_omap3430_ldp_oldconfig is due to the 
following delta from v3.18-rc2:

> # 31 Oct 2014: Add CONFIG_BACKLIGHT_GPIO=y, CONFIG_CMA=y, CONFIG_DMA_CMA=y
> #	CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=y, CONFIG_FRAMEBUFFER_CONSOLE=y
> #	CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y

