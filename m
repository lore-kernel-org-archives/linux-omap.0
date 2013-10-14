From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc5
Date: Mon, 14 Oct 2013 03:21:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310140320420.22465@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab3JNDVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Oct 2013 23:21:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.12-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc5/20131013203109/


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
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af)):
   text     data      bss    total  kernel
    +92        0        0      +92  omap1_defconfig
    +92       -8        0      +84  omap1_defconfig_1510innovator_only
    +92      +16        0     +108  omap1_defconfig_5912osk_only
   +444        0        0     +444  omap2plus_defconfig
   +228      -16        0     +212  omap2plus_defconfig_2430sdp_only
   +508        0        0     +508  omap2plus_defconfig_cpupm
   +256       -8        0     +248  omap2plus_defconfig_n800_multi_omap2xxx
   +288        0        0     +288  omap2plus_defconfig_n800_only_a
   +476       +8        0     +484  omap2plus_defconfig_no_pm
   +356      -16        0     +340  omap2plus_defconfig_omap2_4_only
   +508        0        0     +508  omap2plus_defconfig_omap3_4_only
    +96       +4      -72      +28  rmk_omap3430_ldp_allnoconfig
    +28       +8        0      +36  rmk_omap3430_ldp_oldconfig
    -44       -8      -16      -68  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only

