From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc3
Date: Tue, 6 Jan 2015 07:00:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501060650390.28771@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56918 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbAFHAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 02:00:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc3/20150105224749/


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
(delta in bytes from test_v3.19-rc2 (b7392d2247cfe6771f95d256374f1a8e6a6f48d6)):
   text     data      bss    total  kernel
  +1820      -16        0    +1804  omap1_defconfig
   +796       -8        0     +788  omap1_defconfig_1510innovator_only
   +796      +24        0     +820  omap1_defconfig_5912osk_only
 +10827     +472        0   +11299  multi_v7_defconfig
   +532      +56        0     +588  omap2plus_defconfig
   +352      +72        0     +424  omap2plus_defconfig_2430sdp_only
   +468      +48        0     +516  omap2plus_defconfig_am33xx_only
   +468      +88      -64     +492  omap2plus_defconfig_am43xx_only
   +532      +48        0     +580  omap2plus_defconfig_cpupm
   +404      +48      -64     +388  omap2plus_defconfig_dra7xx_only
     -8        0        0       -8  omap2plus_defconfig_n800_multi_omap2xxx
    +24        0        0      +24  omap2plus_defconfig_n800_only_a
  +4556      +80        0    +4636  omap2plus_defconfig_no_pm
   +468      +80        0     +548  omap2plus_defconfig_omap2_4_only
   +532      +48        0     +580  omap2plus_defconfig_omap3_4_only
   +468      +80      -64     +484  omap2plus_defconfig_omap5_only
   -112      +32      -56     -136  rmk_omap3430_ldp_allnoconfig
   +668       +8        0     +676  rmk_omap3430_ldp_oldconfig
   -104      +64      -64     -104  rmk_omap4430_sdp_allnoconfig
   +808       -8        0     +800  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc2 (b7392d2247cfe6771f95d256374f1a8e6a6f48d6))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


The "pass" and "skip" lines have been removed for the warning test 
summaries; I thought they cluttered up the report too much.  If someone 
out there has strong opinions on whether they should be added back in, 
please let me know by private E-mail.

The validation scripts now scan the build transcripts for warnings 
generated from the toolchain (as opposed to warnings generated when the 
preprocessor encounters a #warning pragma in the source code, e.g., for 
missing syscalls).  If toolchain warnings are detected, the board will be 
marked as failing one of the "Build warnings" tests (above).  The warning 
text can be observed by looking at the build transcript - for example, 
http://www.pwsan.com/omap/testlogs/test_v3.19-rc3/20150105224749/build_z/omap2plus_defconfig_no_pm/build_z_20150105224749_log.txt


