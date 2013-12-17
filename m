From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc4
Date: Tue, 17 Dec 2013 06:54:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170653140.14039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53580 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab3LQGyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 01:54:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc4/20131215195251/


Test summary
------------

Build: uImage:
    Pass (14/14): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3530es3beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle

PM: chip off via dynamic idle:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle


vmlinux object size
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e)):
   text     data      bss    total  kernel
   -220        0        0     -220  omap1_defconfig
   -228        0        0     -228  omap1_defconfig_1510innovator_only
   -156        0        0     -156  omap1_defconfig_5912osk_only
  +2372      +80      +64    +2516  omap2plus_defconfig
  +1564      +32        0    +1596  omap2plus_defconfig_2430sdp_only
  +2300     +208      +64    +2572  omap2plus_defconfig_cpupm
   +908     +112      +32    +1052  omap2plus_defconfig_n800_multi_omap2xxx
   +876     +112      +32    +1020  omap2plus_defconfig_n800_only_a
  +2372     +112        0    +2484  omap2plus_defconfig_no_pm
  +2348     +104      +64    +2516  omap2plus_defconfig_omap2_4_only
  +2372      +80      +64    +2516  omap2plus_defconfig_omap3_4_only
  +2908     +240     -688    +2460  rmk_omap3430_ldp_allnoconfig
   +828      +64        0     +892  rmk_omap3430_ldp_oldconfig
  +2740     +168     -608    +2300  rmk_omap4430_sdp_allnoconfig
   -352        0        0     -352  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
    -8k     8k      .      .  am335xbonelt   omap2plus_defconfig

