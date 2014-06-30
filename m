From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc1
Date: Mon, 30 Jun 2014 06:12:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406300608160.24036@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40301 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbaF3GMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 02:12:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.16-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc1/20140629224344/


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
    FAIL ( 3/14): 2430sdp, 4460varsomom, 5430es2uevm
    skip ( 1/14): 5912osk
    Pass (10/14): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

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
(delta in bytes from test_v3.15 (1860e379875dfe7271c649058aeddffe5afd9d0d)):
   text     data      bss    total  kernel
 +23574    +3656     -312   +26918  omap1_defconfig
 +30629    +4080     -312   +34397  omap1_defconfig_1510innovator_only
 +25906    +3736     -312   +29330  omap1_defconfig_5912osk_only
+439965  +168248   +14472  +622685  multi_v7_defconfig
+133191   +20776  +2750728  +2904695  omap2plus_defconfig
 +98219    +3408  +2750408  +2852035  omap2plus_defconfig_2430sdp_only
+109673    +8560  +2750600  +2868833  omap2plus_defconfig_am33xx_only
+114337    +8664  +2750664  +2873665  omap2plus_defconfig_am43xx_only
+121683   +17736  +2750664  +2890083  omap2plus_defconfig_cpupm
+111269    +9184  +2750600  +2871053  omap2plus_defconfig_dra7xx_only
 +75236   +10760  +2883536  +2969532  omap2plus_defconfig_n800_multi_omap2xxx
 +71408   +10528  +2883536  +2965472  omap2plus_defconfig_n800_only_a
+135117   +22112  +2750664  +2907893  omap2plus_defconfig_no_pm
+131231   +14448  +2750664  +2896343  omap2plus_defconfig_omap2_4_only
+130619   +13864  +2750728  +2895211  omap2plus_defconfig_omap3_4_only
+114045    +9976  +2750664  +2874685  omap2plus_defconfig_omap5_only
 +33012    +4104    -2692   +34424  rmk_omap3430_ldp_allnoconfig
 +49799    +5712  +2883520  +2939031  rmk_omap3430_ldp_oldconfig
 +33724    +3344    +1292   +38360  rmk_omap4430_sdp_allnoconfig
 +62105    +5304  +2883484  +2950893  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15 (1860e379875dfe7271c649058aeddffe5afd9d0d))
  avail  rsrvd   high  freed  board          kconfig
 -2904k  2904k      .    16k  2420n800       omap2plus_defconfig_n800_only_a
 -3000k  3000k      .      .  2430sdp        omap2plus_defconfig
 -3000k  3000k      .    12k  3517evm        omap2plus_defconfig
 -3004k  3004k      .    12k  3530es3beagle  omap2plus_defconfig
 -3000k  3000k      .    12k  3730beaglexm   omap2plus_defconfig
 -3004k  3004k      .    12k  37xxevm        omap2plus_defconfig
 -2996k  2996k      .    12k  4430es2panda   omap2plus_defconfig
 -2840k  2840k      .    12k  4460pandaes    omap2plus_defconfig
 -2816k  2816k      .    12k  am335xbone     omap2plus_defconfig_am33xx_only
 -2996k  2996k      .    12k  am335xbonelt   omap2plus_defconfig


A remarkable increase in omap2plus_defconfig kernel image size and memory 
consumption: almost three megabytes.
