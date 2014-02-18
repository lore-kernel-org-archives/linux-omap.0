From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc3
Date: Tue, 18 Feb 2014 17:48:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402181746390.6702@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaBRRse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Feb 2014 12:48:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc3/20140217214814/


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
(delta in bytes from test_v3.14-rc2 
(b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed)):
   text     data      bss    total  kernel
  +9089     +256        0    +9345  omap1_defconfig
  +5085     +288        0    +5373  omap1_defconfig_1510innovator_only
  +4993     +264        0    +5257  omap1_defconfig_5912osk_only
+8797439  +826332  +291072  +9914843  multi_v7_defconfig
  +5340     +304        0    +5644  omap2plus_defconfig
  +9164     +288        0    +9452  omap2plus_defconfig_2430sdp_only
  +4996     +272        0    +5268  omap2plus_defconfig_am33xx_only
  +5068     +304        0    +5372  omap2plus_defconfig_am43xx_only
  +9372     +264        0    +9636  omap2plus_defconfig_cpupm
  +5148     +264        0    +5412  omap2plus_defconfig_dra7xx_only
   +581        0        0     +581  omap2plus_defconfig_n800_multi_omap2xxx
   +549        0        0     +549  omap2plus_defconfig_n800_only_a
  +9372     +256        0    +9628  omap2plus_defconfig_no_pm
  +5276     +256        0    +5532  omap2plus_defconfig_omap2_4_only
  +5276     +272        0    +5548  omap2plus_defconfig_omap3_4_only
 +11048     +896        0   +11944  omap2plus_defconfig_omap5_only
   +388        0      -88     +300  rmk_omap3430_ldp_allnoconfig
   +449        0        0     +449  rmk_omap3430_ldp_oldconfig
   +388        0      -88     +300  rmk_omap4430_sdp_allnoconfig
   +317        0      -64     +253  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14-rc2 
(b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  4460varsomom   omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only


Have added a build config for multi_v7_defconfig.  Not booting it yet on 
any boards.

