From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.0-rc1
Date: Wed, 25 Feb 2015 20:38:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502252033290.5187@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38621 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbbBYUi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 15:38:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.0-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.0-rc1/20150222222439/


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
    FAIL ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL (15/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
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
		  rmk_omap4430_sdp_oldconfig, multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 2/17): 5912osk, 3517evm
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 3/17): 4430es2panda, 4460varsomom, cmt3517

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

Obsolete Kconfig symbols:
    FAIL ( 2/20): omap1_defconfig, multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v3.19 (bfa76d49576599a4b9f9b7a71f23d73d6dcff735)):
   text     data      bss    total  kernel
 +40745   -29616     +760   +11889  omap1_defconfig
 +40745   -29592     +760   +11913  omap1_defconfig_1510innovator_only
 +40753   -29528     +760   +11985  omap1_defconfig_5912osk_only
+252200   -28128    +1408  +225480  multi_v7_defconfig
-425693   -87568    -2624  -515885  omap2plus_defconfig
-421694   -58912    -2624  -483230  omap2plus_defconfig_2430sdp_only
-441053   -61872    -2432  -505357  omap2plus_defconfig_am33xx_only
-428201   -62840    -2432  -493473  omap2plus_defconfig_am43xx_only
-425693   -87568    -2624  -515885  omap2plus_defconfig_cpupm
-428361   -65328    -2432  -496121  omap2plus_defconfig_dra7xx_only
   +756   -31792     +140   -30896  omap2plus_defconfig_n800_multi_omap2xxx
  -1741   -32688     +396   -34033  omap2plus_defconfig_n800_only_a
-417909   -87232    -2496  -507637  omap2plus_defconfig_no_pm
-432125   -63224    -2432  -497781  omap2plus_defconfig_omap2_4_only
-415009   -91880    -2560  -509449  omap2plus_defconfig_omap3_4_only
-432393   -65072    -2432  -499897  omap2plus_defconfig_omap5_only
 +38072   -47972    +2016    -7884  rmk_omap3430_ldp_allnoconfig
 +69858   -42328     +964   +28494  rmk_omap3430_ldp_oldconfig
 +34288   -32956     -664     +668  rmk_omap4430_sdp_allnoconfig
 +96893   -34688     +792   +62997  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19 (bfa76d49576599a4b9f9b7a71f23d73d6dcff735))
  avail  rsrvd   high  freed  board          kconfig
    36k   -36k      .    -4k  2420n800       omap2plus_defconfig_n800_only_a
   492k  -492k      .      .  2430sdp        omap2plus_defconfig
   492k  -492k      .      .  3530es31beagle omap2plus_defconfig
   492k  -492k      .      .  3530es3beagle  omap2plus_defconfig
   492k  -492k      .      .  3730beaglexm   omap2plus_defconfig
   492k  -492k      .      .  3730es12beaglexmomap2plus_defconfig
   496k  -496k      .      .  37xxevm        omap2plus_defconfig
   492k  -492k      .      .  4430es2panda   omap2plus_defconfig
   492k  -492k      .      .  4460pandaes    omap2plus_defconfig
   500k  -500k      .      .  4460varsomom   omap2plus_defconfig
   492k  -492k      .      .  5430es2sbct54  omap2plus_defconfig
   488k  -488k      .      .  5430es2uevm    omap2plus_defconfig
   484k  -484k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   492k  -492k      .      .  am335xbonelt   omap2plus_defconfig


Usually I'm always whining about the latest per-release bloat.  Well this 
time the memory footprint of anything based on an omap2plus_defconfig 
shrunk by about 500KB which is pretty great.  Would suspect a chunk of 
this is the disappearance of the OMAP3 static clock data; but there must 
be other causes, because even OMAP24xx-only builds shrank.


