From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.0-rc7
Date: Tue, 21 Apr 2015 17:20:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504211718590.8677@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51534 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbbDURUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2015 13:20:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v4.0-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.0-rc7/20150421071440/


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
    FAIL ( 2/17): 2430sdp, 2420n800
    skip ( 2/17): 5912osk, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54

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
(delta in bytes from test_v4.0-rc6 (e42391cd048809d903291d07f86ed3934ce138e9)):
   text     data      bss    total  kernel
  +1079     +120        0    +1199  omap1_defconfig
  +1079      +72        0    +1151  omap1_defconfig_1510innovator_only
  +1079      +80        0    +1159  omap1_defconfig_5912osk_only
   +915      +72        0     +987  multi_v7_defconfig
   +743     +176        0     +919  omap2plus_defconfig
  +4743     +168        0    +4911  omap2plus_defconfig_2430sdp_only
   +679     +136        0     +815  omap2plus_defconfig_am33xx_only
   +679     +200        0     +879  omap2plus_defconfig_am43xx_only
   +743     +168        0     +911  omap2plus_defconfig_cpupm
   +743     +208        0     +951  omap2plus_defconfig_dra7xx_only
   +629     +144        0     +773  omap2plus_defconfig_n800_multi_omap2xxx
   +629     +152        0     +781  omap2plus_defconfig_n800_only_a
  +4839     +200        0    +5039  omap2plus_defconfig_no_pm
   +743     +176        0     +919  omap2plus_defconfig_omap2_4_only
   +747     +208        0     +955  omap2plus_defconfig_omap3_4_only
   +679     +208        0     +887  omap2plus_defconfig_omap5_only
   +664     +112     -128     +648  rmk_omap3430_ldp_allnoconfig
 +33743    +4672     +512   +38927  rmk_omap3430_ldp_oldconfig
   +664     +112     -128     +648  rmk_omap4430_sdp_allnoconfig
   +831     +136        0     +967  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.0-rc6 (e42391cd048809d903291d07f86ed3934ce138e9))
  avail  rsrvd   high  freed  board          kconfig
      .      .      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only

