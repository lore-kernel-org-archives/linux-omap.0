From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.0-rc4
Date: Mon, 16 Mar 2015 17:15:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503161713210.29420@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47803 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbbCPRPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 13:15:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.0-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.0-rc4/20150315232818/


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
(delta in bytes from test_v4.0-rc3 (9eccca0843205f87c00404b663188b88eb248051)):
   text     data      bss    total  kernel
   +377     +128        0     +505  omap1_defconfig
   +377     +104        0     +481  omap1_defconfig_1510innovator_only
   +377      +96        0     +473  omap1_defconfig_5912osk_only
  +1316     -104    +1472    +2684  multi_v7_defconfig
  -2948    +4088        0    +1140  omap2plus_defconfig
   +700      +32        0     +732  omap2plus_defconfig_2430sdp_only
  +1048     +680        0    +1728  omap2plus_defconfig_am33xx_only
  +1116     +744        0    +1860  omap2plus_defconfig_am43xx_only
  -2948    +4032        0    +1084  omap2plus_defconfig_cpupm
  +1180     +360        0    +1540  omap2plus_defconfig_dra7xx_only
   +552     +520        0    +1072  omap2plus_defconfig_n800_multi_omap2xxx
   +452     +424        0     +876  omap2plus_defconfig_n800_only_a
  -2948    +4016        0    +1068  omap2plus_defconfig_no_pm
  +1116    +1288        0    +2404  omap2plus_defconfig_omap2_4_only
  +1084    +1528        0    +2612  omap2plus_defconfig_omap3_4_only
  +1116     +648        0    +1764  omap2plus_defconfig_omap5_only
   +720        0      -88     +632  rmk_omap3430_ldp_allnoconfig
   +604    +1016      +64    +1684  rmk_omap3430_ldp_oldconfig
   +684        0     -104     +580  rmk_omap4430_sdp_allnoconfig
   +568     +904      +64    +1536  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.0-rc3 (9eccca0843205f87c00404b663188b88eb248051))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2430sdp        omap2plus_defconfig
    -4k     4k      .     4k  3530es31beagle omap2plus_defconfig
    -4k     4k      .     4k  3530es3beagle  omap2plus_defconfig
    -4k     4k      .     4k  3730beaglexm   omap2plus_defconfig
    -4k     4k      .     4k  3730es12beaglexmomap2plus_defconfig
    -4k     4k      .     4k  37xxevm        omap2plus_defconfig
    -4k     4k      .     4k  4430es2panda   omap2plus_defconfig
    -4k     4k      .     4k  4460pandaes    omap2plus_defconfig
    -4k     4k      .     4k  4460varsomom   omap2plus_defconfig
    -4k     4k      .     4k  5430es2sbct54  omap2plus_defconfig
    -8k     8k      .     4k  5430es2uevm    omap2plus_defconfig
    -4k     4k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
    -4k     4k      .     4k  am335xbonelt   omap2plus_defconfig

