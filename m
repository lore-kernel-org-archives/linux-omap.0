From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc7
Date: Tue, 3 Feb 2015 19:50:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502031943480.10430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55162 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbbBCTuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2015 14:50:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Here are some basic OMAP test results for Linux v3.19-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc7/20150201224202/


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

Build warnings from toolchain: uImage:
    FAIL ( 1/ 3): omap1_defconfig_1510innovator_only

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL ( 1/17): multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 2/17): 5912osk, 3517evm
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 4/17): 4430es2panda, 4460varsomom, cmt3517, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

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

Kernel warnings during PM test:
    FAIL ( 2/17): 4430es2panda, 4460varsomom


vmlinux object size
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce)):
   text     data      bss    total  kernel
   +364      +80        0     +444  omap1_defconfig
   +396      +80        0     +476  omap1_defconfig_1510innovator_only
   +364      +48        0     +412  omap1_defconfig_5912osk_only
 +99570    +5096     +320  +104986  multi_v7_defconfig
-522133   -33016    -2880  -558029  omap2plus_defconfig
-504092   -26904    -2816  -533812  omap2plus_defconfig_2430sdp_only
-534205   -28088    -2816  -565109  omap2plus_defconfig_am33xx_only
-521309   -27768    -2816  -551893  omap2plus_defconfig_am43xx_only
-522133   -33008    -2880  -558021  omap2plus_defconfig_cpupm
-521309   -30328    -2816  -554453  omap2plus_defconfig_dra7xx_only
 -46578     -912     -180   -47670  omap2plus_defconfig_n800_multi_omap2xxx
 -46610     -944     -180   -47734  omap2plus_defconfig_n800_only_a
-518949   -32936    -2816  -554701  omap2plus_defconfig_no_pm
-525661   -28024    -2816  -556501  omap2plus_defconfig_omap2_4_only
-504945   -27888    -2880  -535713  omap2plus_defconfig_omap3_4_only
-525405   -29936    -2816  -558157  omap2plus_defconfig_omap5_only
   -320      +32      +56     -232  rmk_omap3430_ldp_allnoconfig
   +736        0        0     +736  rmk_omap3430_ldp_oldconfig
   -280        0      +48     -232  rmk_omap4430_sdp_allnoconfig
   +728      -24        0     +704  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce))
  avail  rsrvd   high  freed  board          kconfig
    52k   -52k      .      .  2420n800       omap2plus_defconfig_n800_only_a
   536k  -536k      .      .  2430sdp        omap2plus_defconfig
   540k  -540k      .      .  3530es31beagle omap2plus_defconfig
   540k  -540k      .      .  3530es3beagle  omap2plus_defconfig
   536k  -536k      .      .  3730beaglexm   omap2plus_defconfig
   536k  -536k      .      .  3730es12beaglexmomap2plus_defconfig
   540k  -540k      .      .  37xxevm        omap2plus_defconfig
   540k  -540k      .      .  4430es2panda   omap2plus_defconfig
   540k  -540k      .      .  4460pandaes    omap2plus_defconfig
   540k  -540k      .      .  4460varsomom   omap2plus_defconfig
   540k  -540k      .      .  5430es2sbct54  omap2plus_defconfig
   536k  -536k      .      .  5430es2uevm    omap2plus_defconfig
   548k  -548k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
   536k  -536k      .      .  am335xbonelt   omap2plus_defconfig


While in general it's nice to see kernel memory consumption decrease, it's 
disturbing to see it happen between an -rc6 and -rc7 release.


- Paul
