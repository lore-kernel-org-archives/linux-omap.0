From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc6 (corrected)
Date: Fri, 25 Jul 2014 19:01:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407251900370.5875@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37679 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaGYTB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 15:01:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.16-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc6/20140724142225/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

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
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.16-rc5 
(1795cd9b3a91d4b5473c97f491d63892442212ab)):
   text     data      bss    total  kernel
  +2332      +16        0    +2348  omap1_defconfig
  +2332      +40        0    +2372  omap1_defconfig_1510innovator_only
  +2364      +16        0    +2380  omap1_defconfig_5912osk_only
  +2201     +376        0    +2577  multi_v7_defconfig
  +3173     +464        0    +3637  omap2plus_defconfig
  +2465        0        0    +2465  omap2plus_defconfig_2430sdp_only
  +7249       +8        0    +7257  omap2plus_defconfig_am33xx_only
  +3153     +400        0    +3553  omap2plus_defconfig_am43xx_only
  +3173     +400        0    +3573  omap2plus_defconfig_cpupm
  +3153     +400        0    +3553  omap2plus_defconfig_dra7xx_only
   +880        0        0     +880  omap2plus_defconfig_n800_multi_omap2xxx
   +880      +32        0     +912  omap2plus_defconfig_n800_only_a
  +3109     +400        0    +3509  omap2plus_defconfig_no_pm
  +3109     +464        0    +3573  omap2plus_defconfig_omap2_4_only
  +7253     +464        0    +7717  omap2plus_defconfig_omap3_4_only
  +3153     +400        0    +3553  omap2plus_defconfig_omap5_only
   +116        0      -56      +60  rmk_omap3430_ldp_allnoconfig
  +1885       +8        0    +1893  rmk_omap3430_ldp_oldconfig
   +164     +384      -72     +476  rmk_omap4430_sdp_allnoconfig
  +2056     +424        0    +2480  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc5 (1795cd9b3a91d4b5473c97f491d63892442212ab))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  5430es2uevm    omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
    -8k     8k      .      .  am335xbonelt   omap2plus_defconfig


