From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc8
Date: Mon, 2 Jun 2014 07:50:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406020749100.21503@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52485 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaFBHuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2014 03:50:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.infradead.org


Here are some basic OMAP test results for Linux v3.15-rc8.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc8/20140602002222/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass ( 9/ 9): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som

Build: zImage:
    Pass (14/14): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 2/13): 2430sdp, cmt3517
    skip ( 2/13): 5912osk, 4460varsomom
    Pass ( 9/13): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt

PM: chip retention via suspend:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 2/ 7): 2430sdp, 4430es2panda
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 6/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes

PM: chip off via dynamic idle:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes


vmlinux object size
(delta in bytes from test_v3.15-rc7 (c7208164e66f63e3ec1759b98087849286410741)):
   text     data      bss    total  kernel
   +760        0        0     +760  omap1_defconfig
   +760        0        0     +760  omap1_defconfig_1510innovator_only
   +760        0        0     +760  omap1_defconfig_5912osk_only
  +1628      +80      -64    +1644  multi_v7_defconfig
  +1288      +64        0    +1352  omap2plus_defconfig
   +920      +32        0     +952  omap2plus_defconfig_2430sdp_only
  +1288      +64        0    +1352  omap2plus_defconfig_am33xx_only
  +1288      +64        0    +1352  omap2plus_defconfig_am43xx_only
  +1444      +48        0    +1492  omap2plus_defconfig_cpupm
  +1288      +64        0    +1352  omap2plus_defconfig_dra7xx_only
   +792       -8        0     +784  omap2plus_defconfig_n800_multi_omap2xxx
   +792        0        0     +792  omap2plus_defconfig_n800_only_a
  +1288        0        0    +1288  omap2plus_defconfig_no_pm
  +1288      +64        0    +1352  omap2plus_defconfig_omap2_4_only
  +1288      +64        0    +1352  omap2plus_defconfig_omap3_4_only
  +1288      +64        0    +1352  omap2plus_defconfig_omap5_only
   +576      +32     -116     +492  rmk_omap3430_ldp_allnoconfig
   +768        0        0     +768  rmk_omap3430_ldp_oldconfig
   +560      +32     -132     +460  rmk_omap4430_sdp_allnoconfig
  +1032       -8      +64    +1088  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc7 (c7208164e66f63e3ec1759b98087849286410741))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only

