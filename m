From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15
Date: Mon, 9 Jun 2014 05:53:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406090549530.21441@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59582 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaFIFxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2014 01:53:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.15.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15/20140608184455/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass ( 9/ 9): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som

Build: zImage:
    Pass (14/14): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 1/13): 2430sdp
    skip ( 2/13): 5912osk, 4460varsomom
    Pass (10/13): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 2/ 7): 2430sdp, 4430es2panda
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 6/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes

PM: chip off via dynamic idle:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes


vmlinux object size
(delta in bytes from test_v3.15-rc8 (fad01e866afdbe01a1f3ec06a39c3a8b9e197014)):
   text     data      bss    total  kernel
   +466      +32        0     +498  omap1_defconfig
   +462      +64        0     +526  omap1_defconfig_1510innovator_only
   +466      +32        0     +498  omap1_defconfig_5912osk_only
   +638       -8        0     +630  multi_v7_defconfig
   +650      +64        0     +714  omap2plus_defconfig
   +622      +64        0     +686  omap2plus_defconfig_2430sdp_only
  +4682      +64        0    +4746  omap2plus_defconfig_am33xx_only
   +582      +72        0     +654  omap2plus_defconfig_am43xx_only
   +586      +56        0     +642  omap2plus_defconfig_cpupm
   +582      +64        0     +646  omap2plus_defconfig_dra7xx_only
   +386       -8        0     +378  omap2plus_defconfig_n800_multi_omap2xxx
   +386        0        0     +386  omap2plus_defconfig_n800_only_a
   +586      +64        0     +650  omap2plus_defconfig_no_pm
   +646      +64        0     +710  omap2plus_defconfig_omap2_4_only
   +646      +64        0     +710  omap2plus_defconfig_omap3_4_only
   +582      +64        0     +646  omap2plus_defconfig_omap5_only
   +348        0       -8     +340  rmk_omap3430_ldp_allnoconfig
   +382      +64        0     +446  rmk_omap3430_ldp_oldconfig
   +372        0        0     +372  rmk_omap4430_sdp_allnoconfig
   +510      +64        0     +574  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc8 (fad01e866afdbe01a1f3ec06a39c3a8b9e197014))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2420n800       omap2plus_defconfig_n800_only_a
     4k    -4k      .      .  3530es3beagle  omap2plus_defconfig


cmt3517 works again - Dmitry Lifshitz pointed out that I was using the 
wrong DT file when I re-enabled it at v3.15-rc8.


