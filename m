From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13
Date: Sun, 9 Feb 2014 21:06:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402092104130.17231@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47839 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbaBIVGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Feb 2014 16:06:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13/20140127101347/


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
    skip ( 2/ 2): 5912osk, 4460varsomom
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 2/ 7): 2430sdp, 4430es2panda
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 4/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 7): 3530es3beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 1/ 5): 3530es3beagle

PM: chip off via dynamic idle:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 1/ 5): 3530es3beagle


vmlinux object size
(delta in bytes from test_v3.13-rc8 (7e22e91102c6b9df7c4ae2168910e19d2bb14cd6)):
   text     data      bss    total  kernel
    -20        0        0      -20  omap1_defconfig
    -20       +8        0      -12  omap1_defconfig_1510innovator_only
    -52        0        0      -52  omap1_defconfig_5912osk_only
   +116        0        0     +116  omap2plus_defconfig
    -44        0        0      -44  omap2plus_defconfig_2430sdp_only
   +180        0        0     +180  omap2plus_defconfig_cpupm
    -96        0        0      -96  omap2plus_defconfig_n800_multi_omap2xxx
    -96       -8        0     -104  omap2plus_defconfig_n800_only_a
   +180        0        0     +180  omap2plus_defconfig_no_pm
   +116        0        0     +116  omap2plus_defconfig_omap2_4_only
   +180       -8        0     +172  omap2plus_defconfig_omap3_4_only
    +80        0      +16      +96  rmk_omap3430_ldp_allnoconfig
    -32       -8        0      -40  rmk_omap3430_ldp_oldconfig
   +180        0       +8     +188  rmk_omap4430_sdp_allnoconfig
   +256        0        0     +256  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc8 (7e22e91102c6b9df7c4ae2168910e19d2bb14cd6))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


The 4460 VAR-SOM-OM test failures have been reclassified as "skip" rather 
than failures, to reflect my belief that these problems are due to a 
failure of my local board rather than a software problem.

