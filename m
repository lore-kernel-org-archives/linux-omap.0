From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc2
Date: Mon, 10 Feb 2014 18:14:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402101812190.30435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54831 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbaBJSOz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 13:14:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc2/20140210103104/


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

Build: zImage:
    Pass (13/13): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Boot to userspace:
    FAIL ( 1/10): 2430sdp
    skip ( 2/ 2): 5912osk, cmt3517
    Pass ( 9/10): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
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
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72)):
   text     data      bss    total  kernel
   +393        0        0     +393  omap1_defconfig
   +393        0        0     +393  omap1_defconfig_1510innovator_only
   +361        0        0     +361  omap1_defconfig_5912osk_only
   +705      +64        0     +769  omap2plus_defconfig
  -3467        0        0    -3467  omap2plus_defconfig_2430sdp_only
   +649        0        0     +649  omap2plus_defconfig_am33xx_only
   +705        0        0     +705  omap2plus_defconfig_am43xx_only
   +701      +64        0     +765  omap2plus_defconfig_cpupm
   +769      +64        0     +833  omap2plus_defconfig_dra7xx_only
   +805        0        0     +805  omap2plus_defconfig_n800_multi_omap2xxx
   +805        0        0     +805  omap2plus_defconfig_n800_only_a
   +705      +64        0     +769  omap2plus_defconfig_no_pm
   +705      +64        0     +769  omap2plus_defconfig_omap2_4_only
   +705      +64        0     +769  omap2plus_defconfig_omap3_4_only
   +705      +64        0     +769  omap2plus_defconfig_omap5_only
   +652        0      +64     +716  rmk_omap3430_ldp_allnoconfig
   +769        0        0     +769  rmk_omap3430_ldp_oldconfig
   +620        0      +96     +716  rmk_omap4430_sdp_allnoconfig
   +777      -40        0     +737  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


