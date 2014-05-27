From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc6
Date: Tue, 27 May 2014 16:57:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405271655310.28436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57246 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaE0Q5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 12:57:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.15-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc6/20140526200257/


Test summary
------------

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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Boot to userspace:
    FAIL ( 1/12): 2430sdp
    skip ( 3/12): 5912osk, cmt3517, 4460varsomom
    Pass ( 8/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt

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
(delta in bytes from test_v3.15-rc5 (d6d211db37e75de2ddc3a4f979038c40df7cc79c)):
   text     data      bss    total  kernel
   +240        0        0     +240  omap1_defconfig
   +208        0        0     +208  omap1_defconfig_1510innovator_only
   +240        0        0     +240  omap1_defconfig_5912osk_only
  +1484     -392        0    +1092  multi_v7_defconfig
   +696        0        0     +696  omap2plus_defconfig
   +472        0        0     +472  omap2plus_defconfig_2430sdp_only
   +696        0        0     +696  omap2plus_defconfig_am33xx_only
   +760        0        0     +760  omap2plus_defconfig_am43xx_only
   +696        0        0     +696  omap2plus_defconfig_cpupm
   +696        0        0     +696  omap2plus_defconfig_dra7xx_only
   +488        0        0     +488  omap2plus_defconfig_n800_multi_omap2xxx
   +456        0        0     +456  omap2plus_defconfig_n800_only_a
   +760        0        0     +760  omap2plus_defconfig_no_pm
   +696        0        0     +696  omap2plus_defconfig_omap2_4_only
   +696        0        0     +696  omap2plus_defconfig_omap3_4_only
   +760        0        0     +760  omap2plus_defconfig_omap5_only
   +364        0        0     +364  rmk_omap3430_ldp_allnoconfig
  +4736        0        0    +4736  rmk_omap3430_ldp_oldconfig
   +348        0      +16     +364  rmk_omap4430_sdp_allnoconfig
   +608        0        0     +608  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc5 (d6d211db37e75de2ddc3a4f979038c40df7cc79c))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

