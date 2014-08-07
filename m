From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16
Date: Thu, 7 Aug 2014 21:33:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408072131470.5770@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaHGVeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2014 17:34:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.infradead.org


Here are some basic OMAP test results for Linux v3.16.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16/20140804182520/


Test summary
------------

Build: zImage:
    Pass (16/16): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_dra7xx_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (10/10): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap5-uevm

Boot to userspace:
    FAIL ( 1/14): 2430sdp
    skip ( 1/14): 5912osk
    Pass (12/14): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 5/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3530es3beagle, 3730beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/ 7): 2430sdp, 3530es3beagle, 37xxevm, 4430es2panda,
		  4460pandaes, 4460varsomom
    Pass ( 1/ 7): 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.16-rc7 (64aa90f26c06e1cb2aacfb98a7d0eccfbd6c1a91)):
   text     data      bss    total  kernel
   +456        0        0     +456  omap1_defconfig
   +400      -16        0     +384  omap1_defconfig_1510innovator_only
   +400      +24        0     +424  omap1_defconfig_5912osk_only
  +4720       -8        0    +4712  multi_v7_defconfig
  +4600      +16        0    +4616  omap2plus_defconfig
  +9228        0        0    +9228  omap2plus_defconfig_2430sdp_only
  +4372       -8        0    +4364  omap2plus_defconfig_am33xx_only
  +4436       -8        0    +4428  omap2plus_defconfig_am43xx_only
  +8696      -16        0    +8680  omap2plus_defconfig_cpupm
  +4492        0        0    +4492  omap2plus_defconfig_dra7xx_only
  +3696      -16        0    +3680  omap2plus_defconfig_n800_multi_omap2xxx
  +7788      -16        0    +7772  omap2plus_defconfig_n800_only_a
  +4600      +16        0    +4616  omap2plus_defconfig_no_pm
  +4380      -16        0    +4364  omap2plus_defconfig_omap2_4_only
  +4448       +8        0    +4456  omap2plus_defconfig_omap3_4_only
  +4372      +24        0    +4396  omap2plus_defconfig_omap5_only
  +4100       +8    +3784    +7892  rmk_omap3430_ldp_allnoconfig
  +4060        0        0    +4060  rmk_omap3430_ldp_oldconfig
  +4228       -8     -456    +3764  rmk_omap4430_sdp_allnoconfig
  +7996        0        0    +7996  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc7 (64aa90f26c06e1cb2aacfb98a7d0eccfbd6c1a91))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  5430es2uevm    omap2plus_defconfig
    -8k     8k      .      .  am335xbonelt   omap2plus_defconfig


Someone snuck a patch in between v3.16-rc7 and v3.16 that breaks suspend 
and resume on 37xxevm.

