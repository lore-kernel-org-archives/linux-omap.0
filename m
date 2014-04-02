From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc5
Date: Wed, 2 Apr 2014 15:51:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404021549530.15928@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41531 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbaDBPvQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 11:51:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc5/20140401152404/


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
(delta in bytes from test_v3.14-rc4 (cfbf8d4857c26a8a307fb7cd258074c9dcd8c691)):
   text     data      bss    total  kernel
   +415      -32        0     +383  omap1_defconfig
   +415        0        0     +415  omap1_defconfig_1510innovator_only
   +447        0        0     +447  omap1_defconfig_5912osk_only
   +347      +16        0     +363  multi_v7_defconfig
   +320        0        0     +320  omap2plus_defconfig
   +296        0        0     +296  omap2plus_defconfig_2430sdp_only
   +256        0        0     +256  omap2plus_defconfig_am33xx_only
   +264        0        0     +264  omap2plus_defconfig_am43xx_only
   +320        0        0     +320  omap2plus_defconfig_cpupm
   +320        0        0     +320  omap2plus_defconfig_dra7xx_only
    +48        0        0      +48  omap2plus_defconfig_n800_multi_omap2xxx
    +48        0        0      +48  omap2plus_defconfig_n800_only_a
   +320        0        0     +320  omap2plus_defconfig_no_pm
   +320        0        0     +320  omap2plus_defconfig_omap2_4_only
   +320        0        0     +320  omap2plus_defconfig_omap3_4_only
   +320        0        0     +320  omap2plus_defconfig_omap5_only
    +56        0        0      +56  rmk_omap3430_ldp_allnoconfig
  +4447        0        0    +4447  rmk_omap3430_ldp_oldconfig
    +24        0        0      +24  rmk_omap4430_sdp_allnoconfig
   +319        0        0     +319  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc4 (cfbf8d4857c26a8a307fb7cd258074c9dcd8c691))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only


