From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc6
Date: Fri, 25 Jul 2014 18:56:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407251855270.5875@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37634 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbaGYS4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 14:56:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc6/20140401161621/


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
(delta in bytes from test_v3.14-rc5 (0414855fdc4a40da05221fc6062cccbc0c30f169)):
   text     data      bss    total  kernel
   +614      -24        0     +590  omap1_defconfig
   +610      +16        0     +626  omap1_defconfig_1510innovator_only
   +582       +8        0     +590  omap1_defconfig_5912osk_only
  +1792     +248      -64    +1976  multi_v7_defconfig
  +1984      +32        0    +2016  omap2plus_defconfig
  +1068      +16        0    +1084  omap2plus_defconfig_2430sdp_only
  +1452      +16        0    +1468  omap2plus_defconfig_am33xx_only
  +5432      -16        0    +5416  omap2plus_defconfig_am43xx_only
  +5952        0        0    +5952  omap2plus_defconfig_cpupm
  +1800      +16        0    +1816  omap2plus_defconfig_dra7xx_only
   +218      +16        0     +234  omap2plus_defconfig_n800_multi_omap2xxx
   +218      +16        0     +234  omap2plus_defconfig_n800_only_a
  +1984        0        0    +1984  omap2plus_defconfig_no_pm
  +1852      -16        0    +1836  omap2plus_defconfig_omap2_4_only
  +1920      +32        0    +1952  omap2plus_defconfig_omap3_4_only
  +1800      -16        0    +1784  omap2plus_defconfig_omap5_only
  +1052        0     -324     +728  rmk_omap3430_ldp_allnoconfig
  +1512      +24     +256    +1792  rmk_omap3430_ldp_oldconfig
   +752      +16     -156     +612  rmk_omap4430_sdp_allnoconfig
  +2256      -16     +264    +2504  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc5 (0414855fdc4a40da05221fc6062cccbc0c30f169))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig


