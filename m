From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.0-rc2
Date: Wed, 4 Mar 2015 22:55:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503042153400.5613@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56318 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbCDWza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2015 17:55:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Here are some basic OMAP test results for Linux v4.0-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.0-rc2/20150303123351/


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
(delta in bytes from test_v4.0-rc1 
(c517d838eb7d07bbe9507871fab3931deccff539)):
   text     data      bss    total  kernel
     +4       -8        0       -4  omap1_defconfig
    +68        0        0      +68  omap1_defconfig_1510innovator_only
    +36        0        0      +36  omap1_defconfig_5912osk_only
+490589  +100104    +7232  +597925  multi_v7_defconfig
 +15824     +528        0   +16352  omap2plus_defconfig
    +68        0        0      +68  omap2plus_defconfig_2430sdp_only
 +11728     +560        0   +12288  omap2plus_defconfig_am33xx_only
 +15824     +504        0   +16328  omap2plus_defconfig_am43xx_only
 +15824     +536        0   +16360  omap2plus_defconfig_cpupm
 +15824     +528        0   +16352  omap2plus_defconfig_dra7xx_only
 +10448     +536       +8   +10992  omap2plus_defconfig_n800_multi_omap2xxx
 +10480     +528       +8   +11016  omap2plus_defconfig_n800_only_a
 +10440     +504        0   +10944  omap2plus_defconfig_no_pm
 +15824     +528      +64   +16416  omap2plus_defconfig_omap2_4_only
 +15824     +528        0   +16352  omap2plus_defconfig_omap3_4_only
 +15824     +528        0   +16352  omap2plus_defconfig_omap5_only
    +96        0      -32      +64  rmk_omap3430_ldp_allnoconfig
    +64        0        0      +64  rmk_omap3430_ldp_oldconfig
    +96        0      -32      +64  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.0-rc1 
(c517d838eb7d07bbe9507871fab3931deccff539))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .    -4k  2420n800       omap2plus_defconfig_n800_only_a
   -16k    16k      .      .  2430sdp        omap2plus_defconfig
   -16k    16k      .     4k  3530es31beagle omap2plus_defconfig
   -16k    16k      .     4k  3530es3beagle  omap2plus_defconfig
   -16k    16k      .     4k  3730beaglexm   omap2plus_defconfig
   -16k    16k      .     4k  3730es12beaglexmomap2plus_defconfig
   -20k    20k      .     4k  37xxevm        omap2plus_defconfig
   -16k    16k      .     4k  4430es2panda   omap2plus_defconfig
   -20k    20k      .     4k  4460pandaes    omap2plus_defconfig
   -16k    16k      .     4k  4460varsomom   omap2plus_defconfig
   -20k    20k      .     4k  5430es2sbct54  omap2plus_defconfig
   -16k    16k      .     4k  5430es2uevm    omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   -16k    16k      .     4k  am335xbonelt   omap2plus_defconfig


multi_v7_defconfig builds just increased in size from -rc1 to -rc2 by 
600KB - quite unusual and the cause of that should be tracked down.

