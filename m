From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc3
Date: Mon, 30 Sep 2013 02:00:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309300158430.17980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42248 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3I3CAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Sep 2013 22:00:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.12-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc3/20130929171908/


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
(delta in bytes from test_v3.12-rc2 (4a10c2ac2f368583138b774ca41fac4207911983)):
   text     data      bss    total  kernel
   +492      -16        0     +476  omap1_defconfig
   +524      -16        0     +508  omap1_defconfig_1510innovator_only
   +524       +8        0     +532  omap1_defconfig_5912osk_only
   +404        0        0     +404  omap2plus_defconfig
   +388      +16      -32     +372  omap2plus_defconfig_2430sdp_only
   +404       -8        0     +396  omap2plus_defconfig_cpupm
   +200       +8        0     +208  omap2plus_defconfig_n800_multi_omap2xxx
   +232       +8        0     +240  omap2plus_defconfig_n800_only_a
   +404        0        0     +404  omap2plus_defconfig_no_pm
   +404      +24        0     +428  omap2plus_defconfig_omap2_4_only
   +340        0        0     +340  omap2plus_defconfig_omap3_4_only
    -88      +24      +32      -32  rmk_omap3430_ldp_allnoconfig
   +128        0        0     +128  rmk_omap3430_ldp_oldconfig
    -72       -8      +16      -64  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc2 (4a10c2ac2f368583138b774ca41fac4207911983))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

