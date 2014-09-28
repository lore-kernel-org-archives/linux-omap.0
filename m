From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc6
Date: Sun, 28 Sep 2014 14:44:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409281442190.10306@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38298 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaI1OoK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Sep 2014 10:44:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc6/20140921213558/


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
    FAIL ( 2/17): 2430sdp, 5430es2sbct54
    skip ( 1/17): 5912osk
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3517evm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 5430es2uevm, 2420n800

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 8/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 3530es3beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 4/12): 37xxevm, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 1/ 4): 3530es3beagle
    Pass ( 3/ 4): 37xxevm, 3530es31beagle, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 1/ 4): 3530es3beagle
    Pass ( 3/ 4): 37xxevm, 3530es31beagle, 3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.17-rc5 (9e82bf014195d6f0054982c463575cdce24292be)):
   text     data      bss    total  kernel
   +105     +192        0     +297  omap1_defconfig
   +105     +184        0     +289  omap1_defconfig_1510innovator_only
   +105     +192        0     +297  omap1_defconfig_5912osk_only
   +117     +192        0     +309  multi_v7_defconfig
    +61     +192        0     +253  omap2plus_defconfig
   -963     +224        0     -739  omap2plus_defconfig_2430sdp_only
     +1     +192        0     +193  omap2plus_defconfig_am33xx_only
     +1     +192        0     +193  omap2plus_defconfig_am43xx_only
    +61     +256        0     +317  omap2plus_defconfig_cpupm
     +1     +192        0     +193  omap2plus_defconfig_dra7xx_only
    -11        0        0      -11  omap2plus_defconfig_n800_multi_omap2xxx
    -11        0        0      -11  omap2plus_defconfig_n800_only_a
     +1     +192        0     +193  omap2plus_defconfig_no_pm
     +1     +192        0     +193  omap2plus_defconfig_omap2_4_only
     +1     +192        0     +193  omap2plus_defconfig_omap3_4_only
     +1     +192        0     +193  omap2plus_defconfig_omap5_only
    +32        0        0      +32  rmk_omap3430_ldp_allnoconfig
    +97        0        0      +97  rmk_omap3430_ldp_oldconfig
    +32        0        0      +32  rmk_omap4430_sdp_allnoconfig
    +61        0        0      +61  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc5 (9e82bf014195d6f0054982c463575cdce24292be))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  am335xbonelt   omap2plus_defconfig


