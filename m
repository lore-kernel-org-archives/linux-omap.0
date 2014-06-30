From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc3
Date: Mon, 30 Jun 2014 08:58:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406300856510.24036@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41229 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaF3I6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 04:58:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org



Here are some basic OMAP test results for Linux v3.16-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc3/20140630004413/


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
    FAIL ( 2/14): 2430sdp, 4460varsomom
    skip ( 1/14): 5912osk
    Pass (11/14): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.16-rc2 (a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee)):
   text     data      bss    total  kernel
   +687      +16        0     +703  omap1_defconfig
   +687      +24        0     +711  omap1_defconfig_1510innovator_only
   +687      +16        0     +703  omap1_defconfig_5912osk_only
  +1915     +224        0    +2139  multi_v7_defconfig
  +1719     +120        0    +1839  omap2plus_defconfig
  +1591      +56        0    +1647  omap2plus_defconfig_2430sdp_only
  +1783     +120        0    +1903  omap2plus_defconfig_am33xx_only
  +1659     +120        0    +1779  omap2plus_defconfig_am43xx_only
  +1719      +56        0    +1775  omap2plus_defconfig_cpupm
  +5819      +56        0    +5875  omap2plus_defconfig_dra7xx_only
  +1010      +56        0    +1066  omap2plus_defconfig_n800_multi_omap2xxx
  +1042      +48        0    +1090  omap2plus_defconfig_n800_only_a
  +1763     +144        0    +1907  omap2plus_defconfig_no_pm
  +1719     +120        0    +1839  omap2plus_defconfig_omap2_4_only
  +1591     +120        0    +1711  omap2plus_defconfig_omap3_4_only
  +1659      +56        0    +1715  omap2plus_defconfig_omap5_only
   +980      +56      -96     +940  rmk_omap3430_ldp_allnoconfig
  +4995      +64        0    +5059  rmk_omap3430_ldp_oldconfig
  +1028      +52     -120     +960  rmk_omap4430_sdp_allnoconfig
  +1019      +64        0    +1083  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc2 (a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee))
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
    -8k     8k      .      .  am335xbonelt   omap2plus_defconfig

