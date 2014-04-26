From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc2
Date: Sat, 26 Apr 2014 22:44:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404262243480.24168@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49933 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaDZWo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Apr 2014 18:44:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.15-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc2/20140421120722/


Test summary
------------

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
    FAIL ( 1/12): 2430sdp
    skip ( 2/12): 5912osk, cmt3517
    Pass ( 9/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.15-rc1 (c9eaa447e77efe77b7fa4c953bd62de8297fd6c5)):
   text     data      bss    total  kernel
   +233        0      -32     +201  omap1_defconfig
   +233      -32      -32     +169  omap1_defconfig_1510innovator_only
   +265        0      -32     +233  omap1_defconfig_5912osk_only
   +685      +64        0     +749  multi_v7_defconfig
    +29       -8        0      +21  omap2plus_defconfig
   -111       -8      -32     -151  omap2plus_defconfig_2430sdp_only
    +21       -8        0      +13  omap2plus_defconfig_am33xx_only
    +25       -8        0      +17  omap2plus_defconfig_am43xx_only
    +29      -72        0      -43  omap2plus_defconfig_cpupm
    +25       -8        0      +17  omap2plus_defconfig_dra7xx_only
   -323        0      -32     -355  omap2plus_defconfig_n800_multi_omap2xxx
   -355        0      -32     -387  omap2plus_defconfig_n800_only_a
     +1      +24        0      +25  omap2plus_defconfig_no_pm
    +97      -16        0      +81  omap2plus_defconfig_omap2_4_only
    +97      +24        0     +121  omap2plus_defconfig_omap3_4_only
    +25      -16        0       +9  omap2plus_defconfig_omap5_only
   -512        0     +136     -376  rmk_omap3430_ldp_allnoconfig
    +81      -16      -64       +1  rmk_omap3430_ldp_oldconfig
   -656        0     +248     -408  rmk_omap4430_sdp_allnoconfig
   +369      -80        0     +289  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc1 (c9eaa447e77efe77b7fa4c953bd62de8297fd6c5))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig


