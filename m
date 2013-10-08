From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc4
Date: Tue, 8 Oct 2013 21:41:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310082140250.24955@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37465 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab3JHVlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:41:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.12-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc4/20131007013715/


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
(delta in bytes from test_v3.12-rc3 (15c03dd4859ab16f9212238f29dd315654aa94f6)):
   text     data      bss    total  kernel
  +2349      +40        0    +2389  omap1_defconfig
  +2313      +40        0    +2353  omap1_defconfig_1510innovator_only
  +2317      +16        0    +2333  omap1_defconfig_5912osk_only
  +5734      +24        0    +5758  omap2plus_defconfig
  +1414      +24        0    +1438  omap2plus_defconfig_2430sdp_only
  +1638        0        0    +1638  omap2plus_defconfig_cpupm
   +638        0        0     +638  omap2plus_defconfig_n800_multi_omap2xxx
   +606        0        0     +606  omap2plus_defconfig_n800_only_a
  +1638       -8        0    +1630  omap2plus_defconfig_no_pm
  +1638        0        0    +1638  omap2plus_defconfig_omap2_4_only
  +1638       -8        0    +1630  omap2plus_defconfig_omap3_4_only
  +1336        0     -112    +1224  rmk_omap3430_ldp_allnoconfig
   +994        0        0     +994  rmk_omap3430_ldp_oldconfig
  +1288        0      -96    +1192  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc3 (15c03dd4859ab16f9212238f29dd315654aa94f6))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  am335xbonelt   omap2plus_defconfig_am33xx_only

