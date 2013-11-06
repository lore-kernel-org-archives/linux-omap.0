From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12
Date: Wed, 6 Nov 2013 15:31:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311061531030.13695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54653 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab3KFPbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 10:31:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.12.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12/20131105122637/


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
(delta in bytes from test_v3.12-rc7 (959f58544b7f20c92d5eb43d1232c96c15c01bfb)):
   text     data      bss    total  kernel
   -136      +32        0     -104  omap1_defconfig
   -168      +32        0     -136  omap1_defconfig_1510innovator_only
   -136       +8        0     -128  omap1_defconfig_5912osk_only
   -492        0        0     -492  omap2plus_defconfig
   -436        0        0     -436  omap2plus_defconfig_2430sdp_only
   -492        0        0     -492  omap2plus_defconfig_cpupm
   -464        0        0     -464  omap2plus_defconfig_n800_multi_omap2xxx
   -528        0        0     -528  omap2plus_defconfig_n800_only_a
   -300        0        0     -300  omap2plus_defconfig_no_pm
   -492        0        0     -492  omap2plus_defconfig_omap2_4_only
  -4588        0        0    -4588  omap2plus_defconfig_omap3_4_only
   -484        0       +8     -476  rmk_omap3430_ldp_allnoconfig
   -512        0        0     -512  rmk_omap3430_ldp_oldconfig
   -444        0        0     -444  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc7 (959f58544b7f20c92d5eb43d1232c96c15c01bfb))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  2430sdp        omap2plus_defconfig
     8k    -8k      .      .  3517evm        omap2plus_defconfig
     8k    -8k      .      .  3530es3beagle  omap2plus_defconfig
     8k    -8k      .      .  3730beaglexm   omap2plus_defconfig
     8k    -8k      .      .  37xxevm        omap2plus_defconfig
     8k    -8k      .      .  4430es2panda   omap2plus_defconfig
     8k    -8k      .      .  4460pandaes    omap2plus_defconfig
     8k    -8k      .      .  4460varsomom   omap2plus_defconfig
     8k    -8k      .      .  am335xbonelt   omap2plus_defconfig_am33xx_only

