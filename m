From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc1
Date: Sat, 3 Jan 2015 07:21:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38617 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbACHVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2015 02:21:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc1/20150102151849/


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

Boot to userspace:
    FAIL ( 2/17): 2430sdp, 2420n800
    skip ( 2/17): 5912osk, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54

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

Kernel warnings during boot to userspace:
    FAIL ( 3/17): 4430es2panda, 4460varsomom, cmt3517
    skip ( 2/17): 5912osk, 3517evm
    Pass (12/17): am335xbonelt, am335xbone, 4460pandaes, 37xxevm,
		  2430sdp, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, 5430es2uevm, 5430es2sbct54,
		  2420n800

Kernel warnings during PM test:
    FAIL ( 7/17): 4430es2panda, 4460varsomom, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm
    skip ( 6/17): 5912osk, 3517evm, am335xbonelt/am335x-boneblack,
		  am335xbone, cmt3517, 2420n800
    Pass ( 4/17): 4460pandaes, 2430sdp, 5430es2uevm, 5430es2sbct54


vmlinux object size
(delta in bytes from test_v3.18 (b2776bf7149bddd1f4161f14f79520f17fc1d71d)):
   text     data      bss    total  kernel
+100107    +3648    -6248   +97507  omap1_defconfig
+101103    +2800    -6248   +97655  omap1_defconfig_1510innovator_only
+101099    +2816    -6184   +97731  omap1_defconfig_5912osk_only
+883783   +15784    -2432  +897135  multi_v7_defconfig
+297698    +9648    -4528  +302818  omap2plus_defconfig
+280493   +10720    -1824  +289389  omap2plus_defconfig_2430sdp_only
+297806   +10696    -4592  +303910  omap2plus_defconfig_am33xx_only
+327814   +11784    -4400  +335198  omap2plus_defconfig_am43xx_only
+293602    +9664    -4528  +298738  omap2plus_defconfig_cpupm
+324078   +12384    -4400  +332062  omap2plus_defconfig_dra7xx_only
+216837    +8480    -4600  +220717  omap2plus_defconfig_n800_multi_omap2xxx
+213429    +8432    -4632  +217229  omap2plus_defconfig_n800_only_a
+291026    +9864    -4656  +296234  omap2plus_defconfig_no_pm
+330978   +11696    -4464  +338210  omap2plus_defconfig_omap2_4_only
+315374    +7280    -4528  +318126  omap2plus_defconfig_omap3_4_only
+327978   +11464    -4400  +335042  omap2plus_defconfig_omap5_only
 +31708    -1336    -6644   +23728  rmk_omap3430_ldp_allnoconfig
 +59907    -2672    -6520   +50715  rmk_omap3430_ldp_oldconfig
 +35652    +1548    -7308   +29892  rmk_omap4430_sdp_allnoconfig
 +83106    +1824    -6272   +78658  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18 (b2776bf7149bddd1f4161f14f79520f17fc1d71d))
  avail  rsrvd   high  freed  board          kconfig
 -117380k -13692k      .  -164k  2420n800       omap2plus_defconfig_n800_only_a
  -160k   160k      .      .  2430sdp        omap2plus_defconfig
   -32k    32k      .    12k  3530es31beagle omap2plus_defconfig
   -32k    32k      .    12k  3530es3beagle  omap2plus_defconfig
   224k  -224k      .    12k  3730beaglexm   omap2plus_defconfig
   224k  -224k      .    12k  3730es12beaglexmomap2plus_defconfig
   -32k    32k      .    12k  37xxevm        omap2plus_defconfig
   224k  -224k      .    12k  4430es2panda   omap2plus_defconfig
   740k  -740k      .    12k  4460pandaes    omap2plus_defconfig
   740k  -740k      .    12k  4460varsomom   omap2plus_defconfig
  1760k -1760k      .    12k  5430es2sbct54  omap2plus_defconfig
  1748k -1748k      .    12k  5430es2uevm    omap2plus_defconfig
  -172k   172k      .    20k  am335xbone     omap2plus_defconfig_am33xx_only
   144k  -144k      .    12k  am335xbonelt   omap2plus_defconfig


The N800 didn't boot because the kernel has once again gotten too big for 
NOLO's size limits.  Looking into it.

Another ~300KB kernel object size increase for omap2plus_defconfig 
kernels.

The test report system is now searching through the boot & PM transcripts 
for formal kernel warnings ("WARNING: CPU: \d+ PID: \d+") in the "Kernel 
warnings" sections, and indicating failure when warnings are found.

The memory reporting line logged during kernel boot has changed again, to 
split out CMA reserved memory from other reserved memory.  It's all lumped 
back together in these test reports.

