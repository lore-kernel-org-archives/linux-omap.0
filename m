From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc2
Date: Mon, 9 Dec 2013 09:56:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312090955420.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33458 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab3LIJ4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 04:56:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc2/20131208173520/


Test summary
------------

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

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

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 4460pandaes

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
(delta in bytes from test_v3.13-rc1 (6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae)):
   text     data      bss    total  kernel
   +620      +16        0     +636  omap1_defconfig
   +652      +24        0     +676  omap1_defconfig_1510innovator_only
   +620       -8        0     +612  omap1_defconfig_5912osk_only
  +8904     +192      +64    +9160  omap2plus_defconfig
  +4624      -32        0    +4592  omap2plus_defconfig_2430sdp_only
  +4808     +128     +128    +5064  omap2plus_defconfig_cpupm
   +556      -32      +32     +556  omap2plus_defconfig_n800_multi_omap2xxx
  +4652       +8      +32    +4692  omap2plus_defconfig_n800_only_a
  +4808     +128      +64    +5000  omap2plus_defconfig_no_pm
  +4120      +64        0    +4184  omap2plus_defconfig_omap2_4_only
  +4808     +200      +64    +5072  omap2plus_defconfig_omap3_4_only
  +1648     +108     -788     +968  rmk_omap3430_ldp_allnoconfig
  +1184     +128      +64    +1376  rmk_omap3430_ldp_oldconfig
   +208      +52     -412     -152  rmk_omap4430_sdp_allnoconfig
  +2692       -4      +64    +2752  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc1 (6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae))
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

