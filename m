From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc1
Date: Mon, 20 Oct 2014 18:09:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1410201804050.4472@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbaJWPUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2014 11:20:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.18-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc1/20141020095901/


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
    skip ( 4/17): 5912osk, 2420n800, 3517evm, 4430es2panda
    Pass (12/17): am335xbonelt, am335xbone, 4460pandaes, 4460varsomom,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm, 5430es2sbct54

PM: chip retention via suspend:
    FAIL ( 5/11): am335xbonelt, 4460varsomom, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 6/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/11): am335xbonelt, 4460pandaes, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 5/11): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
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
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb)):
   text     data      bss    total  kernel
 +48872     +832    +3456   +53160  omap1_defconfig
 +48820     +824    +3360   +53004  omap1_defconfig_1510innovator_only
 +45824     +848    +3360   +50032  omap1_defconfig_5912osk_only
+284919   +15336    +3472  +303727  multi_v7_defconfig
+677950   +32008   +54408  +764366  omap2plus_defconfig
+624576   +31472   +57320  +713368  omap2plus_defconfig_2430sdp_only
+668726   +28000   +57480  +754206  omap2plus_defconfig_am33xx_only
+670426   +29104   +57736  +757266  omap2plus_defconfig_am43xx_only
+647778   +30808   +54024  +732610  omap2plus_defconfig_cpupm
+672286   +29816   +54664  +756766  omap2plus_defconfig_dra7xx_only
+251096   +15208   +14456  +280760  omap2plus_defconfig_n800_multi_omap2xxx
+246996   +15192   +14456  +276644  omap2plus_defconfig_n800_only_a
+683634   +32064   +54408  +770106  omap2plus_defconfig_no_pm
+677814   +28664   +57736  +764214  omap2plus_defconfig_omap2_4_only
+669574   +32048   +57416  +759038  omap2plus_defconfig_omap3_4_only
+672154   +29880   +54728  +756762  omap2plus_defconfig_omap5_only
 +18244    -1432    +3380   +20192  rmk_omap3430_ldp_allnoconfig
 +51285     -848    +5460   +55897  rmk_omap3430_ldp_oldconfig
 +20620    -3516    +3396   +20500  rmk_omap4430_sdp_allnoconfig
 +54412    -2360    +5844   +57896  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb))
  avail  rsrvd   high  freed  board          kconfig
 -117908k -13164k      .  -148k  2420n800    omap2plus_defconfig_n800_only_a
 -1012k  1012k      .      .  2430sdp        omap2plus_defconfig
 -1268k  1268k      .    16k  3530es31beagle omap2plus_defconfig
 -1268k  1268k      .    16k  3530es3beagle  omap2plus_defconfig
 -1780k  1780k      .    16k  3730beaglexm   omap2plus_defconfig
 -1780k  1780k      .    16k  3730es12beaglexmomap2plus_defconfig
 -1268k  1268k      .    16k  37xxevm        omap2plus_defconfig
 -2780k  2780k -16384k    16k  4460pandaes    omap2plus_defconfig
 -2776k  2776k -16384k    16k  4460varsomom   omap2plus_defconfig
 -4848k  4848k -16384k    16k  5430es2sbct54  omap2plus_defconfig
 -4800k  4800k -16384k    16k  5430es2uevm    omap2plus_defconfig
  -996k   996k      .     8k  am335xbone     omap2plus_defconfig_am33xx_only
 -1268k  1268k      .    16k  am335xbonelt   omap2plus_defconfig


The size of an omap2plus_defconfig kernel has increased by 760K - a 
remarkable increase that fortunately does not appear to be matched by 
runtime memory consumption.  (Whatever caused this, it doesn't appear to 
have affected the N800 builds.)

The +16M runtime memory increase for the OMAP4/5 boards appears to be due 
to the CMA area now being accounted in highmem memory consumption.

As mentioned previously, 2420n800, 3517evm, and 4430es2panda are currently 
temporarily skipped.
