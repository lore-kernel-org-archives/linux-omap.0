From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc7
Date: Mon, 28 Jul 2014 00:34:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407280033050.24161@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51461 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaG1AeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jul 2014 20:34:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.16-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc7/20140727174803/


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
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.16-rc6 (9a3c4145af32125c5ee39c0272662b47307a8323)):
   text     data      bss    total  kernel
   +380      +24        0     +404  omap1_defconfig
   +380        0        0     +380  omap1_defconfig_1510innovator_only
   +348       -8        0     +340  omap1_defconfig_5912osk_only
   +412      +16        0     +428  multi_v7_defconfig
    +96      -16        0      +80  omap2plus_defconfig
   +704      -16      +32     +720  omap2plus_defconfig_2430sdp_only
    +96      -16        0      +80  omap2plus_defconfig_am33xx_only
    +96      +16        0     +112  omap2plus_defconfig_am43xx_only
    +96      +16        0     +112  omap2plus_defconfig_cpupm
    +96      +16        0     +112  omap2plus_defconfig_dra7xx_only
   +232       -8        0     +224  omap2plus_defconfig_n800_multi_omap2xxx
   +232        0        0     +232  omap2plus_defconfig_n800_only_a
    +96      +48        0     +144  omap2plus_defconfig_no_pm
   +160      +16        0     +176  omap2plus_defconfig_omap2_4_only
    +96      -16        0      +80  omap2plus_defconfig_omap3_4_only
   +160      -16        0     +144  omap2plus_defconfig_omap5_only
    +40        0      +12      +52  rmk_omap3430_ldp_allnoconfig
   +256        0        0     +256  rmk_omap3430_ldp_oldconfig
    +24        0      +28      +52  rmk_omap4430_sdp_allnoconfig
   +288        0      +64     +352  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc6 (9a3c4145af32125c5ee39c0272662b47307a8323))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

