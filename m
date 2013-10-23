From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc6
Date: Wed, 23 Oct 2013 01:19:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310230117250.10303@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36097 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab3JWBTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 21:19:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.12-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc6/20131021185919/


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

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm


vmlinux object size
(delta in bytes from test_v3.12-rc5 (61e6cfa80de5760bbe406f4e815b7739205754d2)):
   text     data      bss    total  kernel
   +287      +32        0     +319  omap1_defconfig
   +291      +32        0     +323  omap1_defconfig_1510innovator_only
   +287      +32        0     +319  omap1_defconfig_5912osk_only
  -4993      +48     -704    -5649  omap2plus_defconfig
   -817      +40     -704    -1481  omap2plus_defconfig_2430sdp_only
   -897      +48     -704    -1553  omap2plus_defconfig_cpupm
   -837       +8     -708    -1537  omap2plus_defconfig_n800_multi_omap2xxx
   -837        0     -708    -1545  omap2plus_defconfig_n800_only_a
   -929       +8     -704    -1625  omap2plus_defconfig_no_pm
   -897      +56     -704    -1545  omap2plus_defconfig_omap2_4_only
   -961      +80     -704    -1585  omap2plus_defconfig_omap3_4_only
  -1388       -4     -124    -1516  rmk_omap3430_ldp_allnoconfig
   -817      -24     -704    -1545  rmk_omap3430_ldp_oldconfig
  -1196       -4     -284    -1484  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc5 (61e6cfa80de5760bbe406f4e815b7739205754d2))
  avail  rsrvd   high  freed  board          kconfig
    12k   -12k      .      .  2430sdp        omap2plus_defconfig
    12k   -12k      .      .  3517evm        omap2plus_defconfig
    12k   -12k      .      .  3530es3beagle  omap2plus_defconfig
    12k   -12k      .      .  3730beaglexm   omap2plus_defconfig
    12k   -12k      .      .  37xxevm        omap2plus_defconfig
     8k    -8k      .      .  4430es2panda   omap2plus_defconfig
     8k    -8k      .      .  4460pandaes    omap2plus_defconfig
     8k    -8k      .      .  4460varsomom   omap2plus_defconfig
     8k    -8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
    12k   -12k      .      .  am335xbonelt   omap2plus_defconfig_am33xx_only

