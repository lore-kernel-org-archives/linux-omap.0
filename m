From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc7
Date: Tue, 29 Oct 2013 02:17:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310290215030.30631@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3J2CRj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Oct 2013 22:17:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.12-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc7/20131027214535/


Test summary
------------

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage:
    Pass (14/14): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm


vmlinux object size
(delta in bytes from test_v3.12-rc6 
(31d141e3a666269a3b6fcccddb0351caf7454240)):
   text     data      bss    total  kernel
   +664      +32        0     +696  omap1_defconfig
   +696      +32        0     +728  omap1_defconfig_1510innovator_only
   +696      +32        0     +728  omap1_defconfig_5912osk_only
   +984      +64        0    +1048  omap2plus_defconfig
   +808      +96        0     +904  omap2plus_defconfig_2430sdp_only
   +984      +64        0    +1048  omap2plus_defconfig_cpupm
   +176      +96        0     +272  omap2plus_defconfig_n800_multi_omap2xxx
   +176      +64        0     +240  omap2plus_defconfig_n800_only_a
   +984      +64        0    +1048  omap2plus_defconfig_no_pm
   +984      +64        0    +1048  omap2plus_defconfig_omap2_4_only
  +5080      +64        0    +5144  omap2plus_defconfig_omap3_4_only
   +208      +32      -32     +208  rmk_omap3430_ldp_allnoconfig
   +800      +64        0     +864  rmk_omap3430_ldp_oldconfig
   +160      +64      -16     +208  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc6 
(31d141e3a666269a3b6fcccddb0351caf7454240))
  avail  rsrvd   high  freed  board          kconfig
   -12k    12k      .      .  2430sdp        omap2plus_defconfig
   -12k    12k      .      .  3517evm        omap2plus_defconfig
   -12k    12k      .      .  3530es3beagle  omap2plus_defconfig
   -12k    12k      .      .  3730beaglexm   omap2plus_defconfig
   -12k    12k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   -12k    12k      .      .  am335xbonelt   omap2plus_defconfig_am33xx_only

