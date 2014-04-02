From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14
Date: Wed, 2 Apr 2014 16:03:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404021600320.15928@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41644 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702AbaDBQDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 12:03:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14/20140402004448/


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
(delta in bytes from test_v3.14-rc8 (b098d6726bbfb94c06d6e1097466187afddae61f)):
   text     data      bss    total  kernel
  +1160      +88       +8    +1256  omap1_defconfig
  +1160      +88       +8    +1256  omap1_defconfig_1510innovator_only
  +1128      +88       +8    +1224  omap1_defconfig_5912osk_only
   +520     +136        0     +656  multi_v7_defconfig
   +720      +64        0     +784  omap2plus_defconfig
   +592      +96      +32     +720  omap2plus_defconfig_2430sdp_only
   +676      +56        0     +732  omap2plus_defconfig_am33xx_only
   +648      +72        0     +720  omap2plus_defconfig_am43xx_only
   +720     +128        0     +848  omap2plus_defconfig_cpupm
   +720      +64        0     +784  omap2plus_defconfig_dra7xx_only
   +416      +88        0     +504  omap2plus_defconfig_n800_multi_omap2xxx
   +384      +24        0     +408  omap2plus_defconfig_n800_only_a
   +656      +72        0     +728  omap2plus_defconfig_no_pm
   +656      +72        0     +728  omap2plus_defconfig_omap2_4_only
   +720      +64        0     +784  omap2plus_defconfig_omap3_4_only
   +656      +64        0     +720  omap2plus_defconfig_omap5_only
   +424      +72     -100     +396  rmk_omap3430_ldp_allnoconfig
   +480      +88        0     +568  rmk_omap3430_ldp_oldconfig
   +464      +76     -108     +432  rmk_omap4430_sdp_allnoconfig
   +480      +56        0     +536  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc8 (b098d6726bbfb94c06d6e1097466187afddae61f))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


