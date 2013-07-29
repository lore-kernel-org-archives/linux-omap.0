From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc3
Date: Mon, 29 Jul 2013 05:46:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290545030.30864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab3G2Fqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 01:46:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.11-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc3/20130728224046/


Test summary
------------

Build: uImage:
    Pass (14/14): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
		  omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Build: uImage+dtb:
    Pass ( 3/ 3): am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Boot to userspace:
    FAIL ( 5/11): 2430sdp, 3530es3beagle, 3730beaglexm, 5912osk,
		  am335xbonelt
    Pass ( 6/11): 3517evm, 37xxevm, 4430es2panda, 4460pandaes,
		  am335xbone, cmt3517

PM: chip retention via suspend:
    FAIL ( 4/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda
    Pass ( 2/ 6): 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda,
		  4460pandaes
    Pass ( 1/ 6): 37xxevm

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm


vmlinux object size
(delta in bytes from test_v3.11-rc2 (3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b)):
   text     data      bss    total  kernel
  -1879     -216      -64    -2159  am33xx_only
   +200      -16        0     +184  n800_multi_omap2xxx
    +56        0        0      +56  n800_only_a
   +176      +64        0     +240  omap1_defconfig
   +176      +64        0     +240  omap1_defconfig_1510innovator_only
   +176      +64        0     +240  omap1_defconfig_5912osk_only
  -5919     -208      -64    -6191  omap2plus_defconfig
  -5967     -280        0    -6247  omap2plus_defconfig_2430sdp_only
  -5919     -272      -64    -6255  omap2plus_defconfig_cpupm
  -1823     -248      -64    -2135  omap2plus_defconfig_no_pm
  -5919     -240      -64    -6223  omap2plus_defconfig_omap2_4_only
  -1823     -208      -64    -2095  omap2plus_defconfig_omap3_4_only
   +420       +8     -160     +268  rmk_omap3430_ldp_allnoconfig
   -371     -248        0     -619  rmk_omap3430_ldp_oldconfig
   +476      +12     -216     +272  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc2 (3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  am335xbonelt   am33xx_only

