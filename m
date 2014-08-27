From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc1
Date: Wed, 27 Aug 2014 16:43:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408271640340.21249@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46354 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934674AbaH0QnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2014 12:43:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc1/20140821122707/


Test summary
------------

Build: zImage:
    Pass (16/16): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_dra7xx_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (10/10): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap5-uevm

Boot to userspace:
    FAIL ( 1/14): 2430sdp
    skip ( 1/14): 5912osk
    Pass (12/14): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip retention via dynamic idle:
    FAIL ( 5/ 7): 2430sdp, 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm


vmlinux object size
(delta in bytes from test_v3.16 (19583ca584d6f574384e17fe7613dfaeadcdc4a6)):
   text     data      bss    total  kernel
 +32887     -316    +2432   +35003  omap1_defconfig
 +32855     -276    +2464   +35043  omap1_defconfig_1510innovator_only
 +32887     -284    +2432   +35035  omap1_defconfig_5912osk_only
+481763   +66520    +1216  +549499  multi_v7_defconfig
 +54469   -34424    +1728   +21773  omap2plus_defconfig
 +64694    +3072    +1896   +69662  omap2plus_defconfig_2430sdp_only
 +62773    +3248    +1856   +67877  omap2plus_defconfig_am33xx_only
 +67285    +3960    +1792   +73037  omap2plus_defconfig_am43xx_only
 +54745   -34392    +1728   +22081  omap2plus_defconfig_cpupm
 +68357    +7408    +1856   +77621  omap2plus_defconfig_dra7xx_only
 +31837   -38048    +1508    -4703  omap2plus_defconfig_n800_multi_omap2xxx
 +34917   -16112    +1508   +20313  omap2plus_defconfig_n800_only_a
 +49829   -34536    +1792   +17085  omap2plus_defconfig_no_pm
 +50337   -39096    +1856   +13097  omap2plus_defconfig_omap2_4_only
 +63013    +3184    +1728   +67925  omap2plus_defconfig_omap3_4_only
 +67805    +3312    +1792   +72909  omap2plus_defconfig_omap5_only
 +13572     +184     -804   +12952  rmk_omap3430_ldp_allnoconfig
 +30262    +1140     +992   +32394  rmk_omap3430_ldp_oldconfig
 +13964     +376    +3372   +17712  rmk_omap4430_sdp_allnoconfig
 +37282     +952     +788   +39022  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16 
(19583ca584d6f574384e17fe7613dfaeadcdc4a6))
  avail  rsrvd   high  freed  board          kconfig
  -160k   160k      .      .  2420n800       omap2plus_defconfig_n800_only_a
  -160k   160k      .      .  2430sdp        omap2plus_defconfig
   -16k    16k      .      .  3517evm        omap2plus_defconfig
   -16k    16k      .      .  3530es3beagle  omap2plus_defconfig
   -16k    16k      .      .  3730beaglexm   omap2plus_defconfig
   -16k    16k      .      .  37xxevm        omap2plus_defconfig
   -16k    16k      .      .  4430es2panda   omap2plus_defconfig
   -16k    16k      .      .  4460pandaes    omap2plus_defconfig
   -16k    16k      .      .  4460varsomom   omap2plus_defconfig
   -24k    24k      .      .  5430es2uevm    omap2plus_defconfig
   -68k    68k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   -16k    16k      .      .  am335xbonelt   omap2plus_defconfig


Pretty big runtime memory increase on the ARM6 platforms.  
omap2plus_defconfig binary size increase is smaller than usual.
