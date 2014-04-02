From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc7
Date: Wed, 2 Apr 2014 15:55:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404021552470.15928@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41590 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758665AbaDBPz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 11:55:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc7/20140401165024/


Test summary
------------

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

Boot to userspace:
    FAIL ( 1/12): 2430sdp
    skip ( 2/12): 5912osk, cmt3517
    Pass ( 9/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  4460varsomom

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
(delta in bytes from test_v3.14-rc6 (fa389e220254c69ffae0d403eac4146171062d08)):
   text     data      bss    total  kernel
   -767     -128        0     -895  omap1_defconfig
   -763     -128        0     -891  omap1_defconfig_1510innovator_only
   -735     -152        0     -887  omap1_defconfig_5912osk_only
   -599     -120        0     -719  multi_v7_defconfig
   -555     -128        0     -683  omap2plus_defconfig
   -707     -192        0     -899  omap2plus_defconfig_2430sdp_only
   -559     -192        0     -751  omap2plus_defconfig_am33xx_only
   -691     -128        0     -819  omap2plus_defconfig_am43xx_only
   -495     -200        0     -695  omap2plus_defconfig_cpupm
   -555     -216        0     -771  omap2plus_defconfig_dra7xx_only
   +125        0      +32     +157  omap2plus_defconfig_n800_multi_omap2xxx
   +125        0      +32     +157  omap2plus_defconfig_n800_only_a
   -627     -192        0     -819  omap2plus_defconfig_no_pm
   -555     -128        0     -683  omap2plus_defconfig_omap2_4_only
   -555     -128        0     -683  omap2plus_defconfig_omap3_4_only
   -491     -200        0     -691  omap2plus_defconfig_omap5_only
   +196        0      -16     +180  rmk_omap3430_ldp_allnoconfig
   +129        0        0     +129  rmk_omap3430_ldp_oldconfig
   +196        0      -16     +180  rmk_omap4430_sdp_allnoconfig
   +161        0        0     +161  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc6 (fa389e220254c69ffae0d403eac4146171062d08))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

