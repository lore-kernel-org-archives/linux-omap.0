From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1-rc6
Date: Mon, 1 Jun 2015 09:27:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506010924340.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50045 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbFAJ1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 05:27:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.1-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-stk-om44,
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
    FAIL (14/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
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
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 2/17): 2430sdp, 5430es2sbct54
    skip ( 2/17): 5912osk, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 2/17): 4430es2panda, cmt3517

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
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.1-rc5 (ba155e2d21f6bf05de86a78dbe5bfd8757604a65)):
   text     data      bss    total  kernel
    +56        0        0      +56  omap1_defconfig
    +48        0        0      +48  omap1_defconfig_1510innovator_only
    +48        0        0      +48  omap1_defconfig_5912osk_only
 +26779     +264        0   +27043  multi_v7_defconfig
  +1071        0        0    +1071  omap2plus_defconfig
   +584      +64        0     +648  omap2plus_defconfig_2430sdp_only
  +1071        0        0    +1071  omap2plus_defconfig_am33xx_only
  +1075        0        0    +1075  omap2plus_defconfig_am43xx_only
  +1071        0        0    +1071  omap2plus_defconfig_cpupm
  +1075        0        0    +1075  omap2plus_defconfig_dra7xx_only
    +72        0        0      +72  omap2plus_defconfig_n800_multi_omap2xxx
    +72        0        0      +72  omap2plus_defconfig_n800_only_a
  +1135        0        0    +1135  omap2plus_defconfig_no_pm
  +1139        0        0    +1139  omap2plus_defconfig_omap2_4_only
  +1071        0        0    +1071  omap2plus_defconfig_omap3_4_only
  -3021        0        0    -3021  omap2plus_defconfig_omap5_only
    -32        0        0      -32  rmk_omap3430_ldp_allnoconfig
    +56        0        0      +56  rmk_omap3430_ldp_oldconfig
    -32        0        0      -32  rmk_omap4430_sdp_allnoconfig
   +699        0        0     +699  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc5 (ba155e2d21f6bf05de86a78dbe5bfd8757604a65))
  avail  rsrvd   high  freed  board          kconfig
 -117644k -13428k      .      .  2420n800       omap2plus_defconfig_n800_only_a

