From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17
Date: Mon, 13 Oct 2014 09:01:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1410130900130.20166@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39449 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbaJMJBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2014 05:01:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17/20141006085043/


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
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb)):
   text     data      bss    total  kernel
   +159       +8       +8     +175  omap1_defconfig
   +127      -24       +8     +111  omap1_defconfig_1510innovator_only
   +127       +8       +8     +143  omap1_defconfig_5912osk_only
    -85       -8       +8      -85  multi_v7_defconfig
    +63        0        0      +63  omap2plus_defconfig
    +95        0       +8     +103  omap2plus_defconfig_2430sdp_only
    +63        0        0      +63  omap2plus_defconfig_am33xx_only
    +67        0        0      +67  omap2plus_defconfig_am43xx_only
    +63        0        0      +63  omap2plus_defconfig_cpupm
    +67        0        0      +67  omap2plus_defconfig_dra7xx_only
    +32        0        0      +32  omap2plus_defconfig_n800_multi_omap2xxx
    +32        0        0      +32  omap2plus_defconfig_n800_only_a
   +127        0        0     +127  omap2plus_defconfig_no_pm
   +127        0        0     +127  omap2plus_defconfig_omap2_4_only
    +63        0        0      +63  omap2plus_defconfig_omap3_4_only
    +67        0        0      +67  omap2plus_defconfig_omap5_only
    -16        0      +16        0  rmk_omap3430_ldp_allnoconfig
     -1        0       +4       +3  rmk_omap3430_ldp_oldconfig
    +16        0      +16      +32  rmk_omap4430_sdp_allnoconfig
     -1        0       +4       +3  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb))
  avail  rsrvd   high  freed  board          kconfig
 -117908k -13164k      .  -148k  2420n800       omap2plus_defconfig_n800_only_a


Skipping the Nokia N800 for this test run since it requires some hands-on 
attention.

