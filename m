From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc5
Date: Mon, 19 Jan 2015 06:22:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501190621060.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43175 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbASGWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 01:22:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc5/20150118212155/


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
(delta in bytes from test_v3.19-rc4 (eaa27f34e91a14cdceed26ed6c6793ec1d186115)):
   text     data      bss    total  kernel
  +1272        0        0    +1272  omap1_defconfig
  +1272       -8        0    +1264  omap1_defconfig_1510innovator_only
  +1304        0        0    +1304  omap1_defconfig_5912osk_only
  +1748     +384        0    +2132  multi_v7_defconfig
  +5680      +16        0    +5696  omap2plus_defconfig
  +1324      +24        0    +1348  omap2plus_defconfig_2430sdp_only
  +1224      +16        0    +1240  omap2plus_defconfig_am33xx_only
  +1288      -24        0    +1264  omap2plus_defconfig_am43xx_only
  +5744      +24        0    +5768  omap2plus_defconfig_cpupm
  +5564      +32        0    +5596  omap2plus_defconfig_dra7xx_only
   +620        0        0     +620  omap2plus_defconfig_n800_multi_omap2xxx
   +580       +8        0     +588  omap2plus_defconfig_n800_only_a
  +1648       -8        0    +1640  omap2plus_defconfig_no_pm
  +1380       -8        0    +1372  omap2plus_defconfig_omap2_4_only
  +1420      +16        0    +1436  omap2plus_defconfig_omap3_4_only
  +5560       +8        0    +5568  omap2plus_defconfig_omap5_only
   +844       -8     -128     +708  rmk_omap3430_ldp_allnoconfig
  +5064      +24        0    +5088  rmk_omap3430_ldp_oldconfig
   +692        0     -112     +580  rmk_omap4430_sdp_allnoconfig
   +924        0        0     +924  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc4 (eaa27f34e91a14cdceed26ed6c6793ec1d186115))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .     4k  3530es31beagle omap2plus_defconfig
    -8k     8k      .     4k  3530es3beagle  omap2plus_defconfig
    -8k     8k      .     4k  3730beaglexm   omap2plus_defconfig
    -8k     8k      .     4k  3730es12beaglexmomap2plus_defconfig
    -8k     8k      .     4k  37xxevm        omap2plus_defconfig
    -8k     8k      .     4k  4430es2panda   omap2plus_defconfig
    -8k     8k      .     4k  4460pandaes    omap2plus_defconfig
    -8k     8k      .     4k  4460varsomom   omap2plus_defconfig
    -8k     8k      .     4k  5430es2sbct54  omap2plus_defconfig
    -8k     8k      .     4k  5430es2uevm    omap2plus_defconfig
      .      .      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
    -8k     8k      .     4k  am335xbonelt   omap2plus_defconfig

