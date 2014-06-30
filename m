From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc2
Date: Mon, 30 Jun 2014 08:56:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406300855570.24036@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbaF3I4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 04:56:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org



Here are some basic OMAP test results for Linux v3.16-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc2/20140630000629/


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
(delta in bytes from test_v3.16-rc1 (7171511eaec5bf23fb06078f59784a3a0626b38f)):
   text     data      bss    total  kernel
   +594      -24        0     +570  omap1_defconfig
   +626      -24        0     +602  omap1_defconfig_1510innovator_only
   +594       +8        0     +602  omap1_defconfig_5912osk_only
   +746       +8        0     +754  multi_v7_defconfig
   +598       +8      +64     +670  omap2plus_defconfig
   +390      -24        0     +366  omap2plus_defconfig_2430sdp_only
   +530       +8        0     +538  omap2plus_defconfig_am33xx_only
   +594       +8        0     +602  omap2plus_defconfig_am43xx_only
   +598       +8        0     +606  omap2plus_defconfig_cpupm
   +530       +8        0     +538  omap2plus_defconfig_dra7xx_only
    +30       +8        0      +38  omap2plus_defconfig_n800_multi_omap2xxx
    -34      -16        0      -50  omap2plus_defconfig_n800_only_a
   +530      -24        0     +506  omap2plus_defconfig_no_pm
   +534      +16        0     +550  omap2plus_defconfig_omap2_4_only
   +594      -16      +64     +642  omap2plus_defconfig_omap3_4_only
   +594      +16        0     +610  omap2plus_defconfig_omap5_only
   -172        0      -40     -212  rmk_omap3430_ldp_allnoconfig
   +182       +8        0     +190  rmk_omap3430_ldp_oldconfig
   -204        0       -8     -212  rmk_omap4430_sdp_allnoconfig
   +290        0        0     +290  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc1 (7171511eaec5bf23fb06078f59784a3a0626b38f))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

