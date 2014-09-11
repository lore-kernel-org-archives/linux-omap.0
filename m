From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc4
Date: Thu, 11 Sep 2014 16:31:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409111623470.5347@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbaIKQbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 12:31:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.17-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc4/20140910234406/


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
    FAIL ( 2/16): 2430sdp, 5430es2sbct54
    skip ( 1/16): 5912osk
    Pass (13/16): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3517evm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, cmt3517, 5430es2uevm,
		  2420n800

PM: chip retention via suspend:
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 5/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 8/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 3530es3beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 3/11): 37xxevm, 3530es31beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 1/ 3): 3530es3beagle
    Pass ( 2/ 3): 37xxevm, 3530es31beagle

PM: chip off via dynamic idle:
    FAIL ( 1/ 3): 3530es3beagle
    Pass ( 2/ 3): 37xxevm, 3530es31beagle


vmlinux object size
(delta in bytes from test_v3.17-rc3 (69e273c0b0a3c337a521d083374c918dc52c666f)):
   text     data      bss    total  kernel
   +831        0        0     +831  multi_v7_defconfig
   +259        0      -64     +195  omap2plus_defconfig
   +251        0        0     +251  omap2plus_defconfig_2430sdp_only
   +263      +64        0     +327  omap2plus_defconfig_am33xx_only
   +199      +64        0     +263  omap2plus_defconfig_am43xx_only
   +259        0      -64     +195  omap2plus_defconfig_cpupm
   +199        0        0     +199  omap2plus_defconfig_dra7xx_only
   +223      +64       -8     +279  omap2plus_defconfig_n800_multi_omap2xxx
   +223      +32       -8     +247  omap2plus_defconfig_n800_only_a
   +191        0        0     +191  omap2plus_defconfig_no_pm
   +191        0        0     +191  omap2plus_defconfig_omap2_4_only
   +199        0        0     +199  omap2plus_defconfig_omap3_4_only
   +199        0        0     +199  omap2plus_defconfig_omap5_only
    +80        0      +64     +144  rmk_omap3430_ldp_allnoconfig
   +351       +8        0     +359  rmk_omap3430_ldp_oldconfig
    +64        0      +80     +144  rmk_omap4430_sdp_allnoconfig
   +259        0        0     +259  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc3 (69e273c0b0a3c337a521d083374c918dc52c666f))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


A 3530 Beagle C5 has been added as "3530es31beagle".  

PM tests have been enabled for the am335xbonelt and OMAP5-based platforms.

Also, several of the board PM test evaluations that are failing off-mode 
testing have been restricted to testing for chip retention, for the time 
being.
