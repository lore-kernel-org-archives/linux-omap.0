From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc3
Date: Mon, 28 Apr 2014 04:49:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404280445100.9132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaD1Et2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 00:49:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.15-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc3/20140427213739/


Test summary
------------

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
(delta in bytes from test_v3.15-rc2 (a798c10faf62a505d24e5f6213fbaf904a39623f)):
   text     data      bss    total  kernel
     +8        0        0       +8  omap1_defconfig
    -56        0        0      -56  omap1_defconfig_1510innovator_only
    -24        0        0      -24  omap1_defconfig_5912osk_only
  +1292       -8        0    +1284  multi_v7_defconfig
   +776        0      +64     +840  omap2plus_defconfig
    +51     +136        0     +187  omap2plus_defconfig_2430sdp_only
   +740        0      +64     +804  omap2plus_defconfig_am33xx_only
  +4952        0        0    +4952  omap2plus_defconfig_am43xx_only
   +776      +64      +64     +904  omap2plus_defconfig_cpupm
   +740      +64        0     +804  omap2plus_defconfig_dra7xx_only
   +340     +232      +32     +604  omap2plus_defconfig_n800_multi_omap2xxx
   +340     +240      +32     +612  omap2plus_defconfig_n800_only_a
  +4808      +56      +64    +4928  omap2plus_defconfig_no_pm
   +804      +72      +64     +940  omap2plus_defconfig_omap2_4_only
   +648        0      +64     +712  omap2plus_defconfig_omap3_4_only
   +740      +72        0     +812  omap2plus_defconfig_omap5_only
  +1036     +216     -568     +684  rmk_omap3430_ldp_allnoconfig
   +300     +200        0     +500  rmk_omap3430_ldp_oldconfig
  +1180     +244     -584     +840  rmk_omap4430_sdp_allnoconfig
   +112      +16        0     +128  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc2 (a798c10faf62a505d24e5f6213fbaf904a39623f))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
     4k    -4k      .      .  am335xbone     omap2plus_defconfig_am33xx_only


