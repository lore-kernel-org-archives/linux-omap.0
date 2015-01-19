From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc4
Date: Mon, 19 Jan 2015 04:23:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501190422070.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42703 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbASEXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 23:23:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc4/20150118192109/


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
    FAIL ( 2/17): omap2plus_defconfig_no_pm, multi_v7_defconfig

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

Kernel warnings during PM test:
    FAIL ( 7/17): 4430es2panda, 4460varsomom, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.19-rc3 (b1940cd21c0f4abdce101253e860feff547291b0)):
   text     data      bss    total  kernel
   +216        0        0     +216  omap1_defconfig
   +216        0        0     +216  omap1_defconfig_1510innovator_only
   +216        0        0     +216  omap1_defconfig_5912osk_only
   +888     +144        0    +1032  multi_v7_defconfig
    -64        0        0      -64  omap2plus_defconfig
   -200        0        0     -200  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_am33xx_only
      0        0        0        0  omap2plus_defconfig_am43xx_only
    -64        0        0      -64  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_dra7xx_only
    -12        0        0      -12  omap2plus_defconfig_n800_multi_omap2xxx
   +180       -8        0     +172  omap2plus_defconfig_n800_only_a
      0        0        0        0  omap2plus_defconfig_no_pm
    -64        0        0      -64  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
    -64        0        0      -64  omap2plus_defconfig_omap5_only
   +220        0      -28     +192  rmk_omap3430_ldp_allnoconfig
   +160        0        0     +160  rmk_omap3430_ldp_oldconfig
   +236        0      -44     +192  rmk_omap4430_sdp_allnoconfig
 +37686    +1008        0   +38694  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc3 (b1940cd21c0f4abdce101253e860feff547291b0))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

