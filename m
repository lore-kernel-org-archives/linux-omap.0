From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc2
Date: Wed, 27 Aug 2014 16:44:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408271643400.21249@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46405 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914AbaH0Qoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2014 12:44:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc2/20140825183438/


Test summary
------------

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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

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
(delta in bytes from test_v3.17-rc1 (7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9)):
   text     data      bss    total  kernel
   +980      +32        0    +1012  omap1_defconfig
  +1012       -8        0    +1004  omap1_defconfig_1510innovator_only
  +1012        0        0    +1012  omap1_defconfig_5912osk_only
  +1644      +16        0    +1660  multi_v7_defconfig
   +900      +16        0     +916  omap2plus_defconfig
   +836      -16        0     +820  omap2plus_defconfig_2430sdp_only
   +836       +8        0     +844  omap2plus_defconfig_am33xx_only
   +900       +8        0     +908  omap2plus_defconfig_am43xx_only
   +900      +48        0     +948  omap2plus_defconfig_cpupm
   +836       +8        0     +844  omap2plus_defconfig_dra7xx_only
   +316       +8        0     +324  omap2plus_defconfig_n800_multi_omap2xxx
   +316      -16        0     +300  omap2plus_defconfig_n800_only_a
   +900      -24        0     +876  omap2plus_defconfig_no_pm
   +900      -16        0     +884  omap2plus_defconfig_omap2_4_only
   +836       +8        0     +844  omap2plus_defconfig_omap3_4_only
   +836      -16        0     +820  omap2plus_defconfig_omap5_only
   +180      +16      -32     +164  rmk_omap3430_ldp_allnoconfig
   +852       +8        0     +860  rmk_omap3430_ldp_oldconfig
   +212      +12      -32     +192  rmk_omap4430_sdp_allnoconfig
   +852      -16        0     +836  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc1 (7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


