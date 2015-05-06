From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1-rc2
Date: Wed, 6 May 2015 16:28:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505061617300.3509@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44539 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEFQ20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 12:28:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.1-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1-rc2/20150505232833/


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
    FAIL ( 6/17): 4460varsomom, 2430sdp, 3530es3beagle, 3530es31beagle,
		  cmt3517, 5430es2sbct54
    skip ( 2/17): 5912osk, 3517evm
    Pass ( 9/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  37xxevm, 3730beaglexm, 3730es12beaglexm, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 1/17): 4430es2panda

PM: chip retention via suspend:
    FAIL ( 8/12): am335xbonelt, 4430es2panda, 4460varsomom,
		  3530es3beagle, 3530es31beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 4/12): 4460pandaes, 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 8/12): am335xbonelt, 4430es2panda, 4460varsomom,
		  3530es3beagle, 3530es31beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 4/12): 4460pandaes, 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)):
   text     data      bss    total  kernel
   -650        0        0     -650  omap1_defconfig
   -674      +32        0     -642  omap1_defconfig_1510innovator_only
   -642      +32        0     -610  omap1_defconfig_5912osk_only
   -586      +64        0     -522  multi_v7_defconfig
   -678      -32        0     -710  omap2plus_defconfig
   -350      -32        0     -382  omap2plus_defconfig_2430sdp_only
   -750        0        0     -750  omap2plus_defconfig_am33xx_only
   -682      -32        0     -714  omap2plus_defconfig_am43xx_only
   -678      -32        0     -710  omap2plus_defconfig_cpupm
   -682      -64        0     -746  omap2plus_defconfig_dra7xx_only
   +204      -32        0     +172  omap2plus_defconfig_n800_multi_omap2xxx
   +204      -32        0     +172  omap2plus_defconfig_n800_only_a
   -678      -64        0     -742  omap2plus_defconfig_no_pm
  +3422      -32        0    +3390  omap2plus_defconfig_omap2_4_only
   -746      -32        0     -778  omap2plus_defconfig_omap3_4_only
   -746      -32        0     -778  omap2plus_defconfig_omap5_only
      0        0      +32      +32  rmk_omap3430_ldp_allnoconfig
   -618        0        0     -618  rmk_omap3430_ldp_oldconfig
    -16        0      +32      +16  rmk_omap4430_sdp_allnoconfig
   -846      -64        0     -910  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  5430es2sbct54  omap2plus_defconfig

