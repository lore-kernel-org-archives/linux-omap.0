From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc4
Date: Mon, 24 Feb 2014 18:35:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402241832001.23725@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaBXSfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2014 13:35:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc4/20140224102552/


Test summary
------------

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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

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
    FAIL ( 1/12): 2430sdp
    skip ( 2/12): 5912osk, cmt3517
    Pass ( 9/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  4460varsomom

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

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
(delta in bytes from test_v3.14-rc3 (6d0abeca3242a88cab8232e4acd7e2bf088f3bc2)):
   text     data      bss    total  kernel
  -7997     -120        0    -8117  omap1_defconfig
  -3897     -192        0    -4089  omap1_defconfig_1510innovator_only
  -3901     -160        0    -4061  omap1_defconfig_5912osk_only
  -2633     +264        0    -2369  multi_v7_defconfig
  -3777     -192        0    -3969  omap2plus_defconfig
  -3661     -200        0    -3861  omap2plus_defconfig_2430sdp_only
  +3449      -80        0    +3369  omap2plus_defconfig_am33xx_only
   -963     -120        0    -1083  omap2plus_defconfig_am43xx_only
  -7805     -120        0    -7925  omap2plus_defconfig_cpupm
  +3009      -72        0    +2937  omap2plus_defconfig_dra7xx_only
   +112      +56        0     +168  omap2plus_defconfig_n800_multi_omap2xxx
   +112      +64        0     +176  omap2plus_defconfig_n800_only_a
  -7809     -120        0    -7929  omap2plus_defconfig_no_pm
  -3713     -184        0    -3897  omap2plus_defconfig_omap2_4_only
  -3713     -224        0    -3937  omap2plus_defconfig_omap3_4_only
  -1087      -32        0    -1119  omap2plus_defconfig_omap5_only
   +192      +72      -96     +168  rmk_omap3430_ldp_allnoconfig
  +1007      +48        0    +1055  rmk_omap3430_ldp_oldconfig
   +224      +36      -96     +164  rmk_omap4430_sdp_allnoconfig
  +1127      +56        0    +1183  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc3 (6d0abeca3242a88cab8232e4acd7e2bf088f3bc2))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  2430sdp        omap2plus_defconfig
     8k    -8k      .      .  3517evm        omap2plus_defconfig
     8k    -8k      .      .  3530es3beagle  omap2plus_defconfig
     8k    -8k      .      .  3730beaglexm   omap2plus_defconfig
     8k    -8k      .      .  37xxevm        omap2plus_defconfig
     8k    -8k      .      .  4430es2panda   omap2plus_defconfig
     8k    -8k      .      .  4460pandaes    omap2plus_defconfig
     8k    -8k      .      .  4460varsomom   omap2plus_defconfig
      .      .      .     4k  am335xbone     omap2plus_defconfig_am33xx_only

