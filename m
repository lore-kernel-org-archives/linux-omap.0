From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1-rc4
Date: Wed, 20 May 2015 00:20:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505200019310.32204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34476 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbETAUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 20:20:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.1-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1-rc4/20150518120932/


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
    FAIL ( 9/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 3530es3beagle, 3530es31beagle, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 3/12): 37xxevm, 3730beaglexm, 3730es12beaglexm

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
(delta in bytes from test_v4.1-rc3 (030bbdbf4c833bc69f502eae58498bc5572db736)):
   text     data      bss    total  kernel
  +1196      +32        0    +1228  omap1_defconfig
  +1196      +32        0    +1228  omap1_defconfig_1510innovator_only
  +1196      +64        0    +1260  omap1_defconfig_5912osk_only
  +1783     +704        0    +2487  multi_v7_defconfig
  +1195     +512        0    +1707  omap2plus_defconfig
  +1299        0        0    +1299  omap2plus_defconfig_2430sdp_only
  +1399        0        0    +1399  omap2plus_defconfig_am33xx_only
  +1331     +512        0    +1843  omap2plus_defconfig_am43xx_only
  +1195     +512        0    +1707  omap2plus_defconfig_cpupm
  +1331        0        0    +1331  omap2plus_defconfig_dra7xx_only
   +539        0        0     +539  omap2plus_defconfig_n800_multi_omap2xxx
   +288        0        0     +288  omap2plus_defconfig_n800_only_a
  +1191     +480        0    +1671  omap2plus_defconfig_no_pm
  +1395        0        0    +1395  omap2plus_defconfig_omap2_4_only
  +1251        0        0    +1251  omap2plus_defconfig_omap3_4_only
  +5427        0        0    +5427  omap2plus_defconfig_omap5_only
   +208      +20      +16     +244  rmk_omap3430_ldp_allnoconfig
   +740        0        0     +740  rmk_omap3430_ldp_oldconfig
   +144      +20      +16     +180  rmk_omap4430_sdp_allnoconfig
   +764        0        0     +764  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc3 (030bbdbf4c833bc69f502eae58498bc5572db736))
  avail  rsrvd   high  freed  board          kconfig
      .      .      .    -4k  3730beaglexm   omap2plus_defconfig
      .      .      .    -4k  3730es12beaglexmomap2plus_defconfig
      .      .      .    -4k  37xxevm        omap2plus_defconfig
      .      .      .    -4k  4430es2panda   omap2plus_defconfig
      .      .      .    -4k  4460pandaes    omap2plus_defconfig
      .      .      .    -4k  5430es2uevm    omap2plus_defconfig
      .      .      .    -4k  am335xbonelt   omap2plus_defconfig

