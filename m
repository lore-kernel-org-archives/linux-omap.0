From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc1 (toolchain CodeSourcery
 2010.09-50)
Date: Mon, 25 Nov 2013 07:31:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311250725060.1364@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35065 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3KYHbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 02:31:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124223225/


Test summary
------------

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

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

Boot to userspace:
    FAIL ( 1/11): 37xxevm
    skip ( 1/ 1): 5912osk
    Pass (10/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 4460pandaes

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
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52)):
   text     data      bss    total  kernel
 +53225     +320    +4200   +57745  omap1_defconfig
 +50509     +216    +4200   +54925  omap1_defconfig_1510innovator_only
 +47177     +272    +4200   +51649  omap1_defconfig_5912osk_only
+146639    -6024    +5056  +145671  omap2plus_defconfig
 +98635    +9768    +4672  +113075  omap2plus_defconfig_2430sdp_only
+150542    -6040    +5056  +149558  omap2plus_defconfig_cpupm
 +83976   +10248    +4400   +98624  omap2plus_defconfig_n800_multi_omap2xxx
 +83920   +10248    +4400   +98568  omap2plus_defconfig_n800_only_a
+145995    -5224    +5056  +145827  omap2plus_defconfig_no_pm
+154543   +13528    +4992  +173063  omap2plus_defconfig_omap2_4_only
+150515    -6016    +5056  +149555  omap2plus_defconfig_omap3_4_only
 +30064   -10076    +3116   +23104  rmk_omap3430_ldp_allnoconfig
 +48163    +3960    +4352   +56475  rmk_omap3430_ldp_oldconfig
 +34920    +1748    +5764   +42432  rmk_omap4430_sdp_allnoconfig
+4532235  +248124  +439128  +5219487  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52))
  avail  rsrvd   high  freed  board          kconfig
   -96k    96k      .     4k  2420n800       omap2plus_defconfig_n800_only_a
  -140k   140k      .    -4k  2430sdp        omap2plus_defconfig
  -140k   140k      .    -4k  3517evm        omap2plus_defconfig
  -140k   140k      .    -4k  3530es3beagle  omap2plus_defconfig
  -140k   140k      .    -4k  3730beaglexm   omap2plus_defconfig
 -227908k -33212k      .  -392k  37xxevm        omap2plus_defconfig
  -140k   140k      .    -4k  4430es2panda   omap2plus_defconfig
  -144k   144k      .    -4k  4460pandaes    omap2plus_defconfig
  -144k   144k      .    -4k  4460varsomom   omap2plus_defconfig
  -144k   144k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
  -148k   148k      .    -4k  am335xbonelt   omap2plus_defconfig_am33xx_only


Re-enabled rmk_omap4430_sdp_oldnoconfig.

Will be switching toolchains from CodeSourcery 2010.09-50 to Debian 
4.7.2-5; a test with the newer toolchain version is to follow.



