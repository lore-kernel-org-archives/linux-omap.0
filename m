From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc7 (corrected)
Date: Thu, 5 Feb 2015 06:05:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502050603230.10430@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502031943480.10430@utopia.booyaka.com> <alpine.DEB.2.02.1502050601040.10430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41885 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbbBEGFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 01:05:52 -0500
In-Reply-To: <alpine.DEB.2.02.1502050601040.10430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc7/20150204213018/


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
    FAIL ( 2/17): 4460varsomom, 2430sdp
    skip ( 2/17): 5912osk, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm,
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
    FAIL ( 2/17): 4430es2panda, 4460varsomom

Obsolete Kconfig symbols:
    FAIL ( 3/20): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce)):
   text     data      bss    total  kernel
    +24      +56        0      +80  omap1_defconfig
    +56      +32        0      +88  omap1_defconfig_1510innovator_only
    +24      +32        0      +56  omap1_defconfig_5912osk_only
  -1224       -8        0    -1232  multi_v7_defconfig
   +908      +64        0     +972  omap2plus_defconfig
   +716      +64        0     +780  omap2plus_defconfig_2430sdp_only
   +908       -8        0     +900  omap2plus_defconfig_am33xx_only
   +972      +88        0    +1060  omap2plus_defconfig_am43xx_only
   +908      +56        0     +964  omap2plus_defconfig_cpupm
   +908      +56        0     +964  omap2plus_defconfig_dra7xx_only
   -228        0        0     -228  omap2plus_defconfig_n800_multi_omap2xxx
   -228        0        0     -228  omap2plus_defconfig_n800_only_a
   +908      +88        0     +996  omap2plus_defconfig_no_pm
   +972      +88        0    +1060  omap2plus_defconfig_omap2_4_only
   +908      +64        0     +972  omap2plus_defconfig_omap3_4_only
  -3188      +64        0    -3124  omap2plus_defconfig_omap5_only
   -320      +32      +56     -232  rmk_omap3430_ldp_allnoconfig
   +736        0        0     +736  rmk_omap3430_ldp_oldconfig
   -288        0      +56     -232  rmk_omap4430_sdp_allnoconfig
   +728      -24        0     +704  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

This test run corrects a set of bogus Kconfigs used in the previous 
v3.19-rc7 test.

A test for bogus Kconfig symbols has been added ("Obsolete Kconfig 
symbols" above).  Failures here indicate that the named defconfigs 
reference Kconfig symbols that are no longer present in the various 
Kconfig files.
