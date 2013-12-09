From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc3
Date: Mon, 9 Dec 2013 10:00:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312090957460.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33515 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3LIKAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 05:00:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc3/20131208173612/


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
(delta in bytes from test_v3.13-rc2 (dc1ccc48159d63eca5089e507c82c7d22ef60839)):
   text     data      bss    total  kernel
   +376        0        0     +376  omap1_defconfig
   +332        0        0     +332  omap1_defconfig_1510innovator_only
  +1368        0        0    +1368  omap1_defconfig_5912osk_only
   +448    +1816        0    +2264  omap2plus_defconfig
    +44    +1952        0    +1996  omap2plus_defconfig_2430sdp_only
   +520    +1784        0    +2304  omap2plus_defconfig_cpupm
  +4372      +16        0    +4388  omap2plus_defconfig_n800_multi_omap2xxx
   +308      -16        0     +292  omap2plus_defconfig_n800_only_a
   +320    +1816        0    +2136  omap2plus_defconfig_no_pm
   +448    +1816        0    +2264  omap2plus_defconfig_omap2_4_only
   +448    +1784        0    +2232  omap2plus_defconfig_omap3_4_only
   +416      +16     -156     +276  rmk_omap3430_ldp_allnoconfig
   +176      +16        0     +192  rmk_omap3430_ldp_oldconfig
   +280      -16     -116     +148  rmk_omap4430_sdp_allnoconfig
   +256     +896        0    +1152  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc2 (dc1ccc48159d63eca5089e507c82c7d22ef60839))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  4460varsomom   omap2plus_defconfig
    -4k     4k      .      .  am335xbone     omap2plus_defconfig_am33xx_only

