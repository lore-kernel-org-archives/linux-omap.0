From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1-rc1
Date: Mon, 27 Apr 2015 18:00:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1504271759400.31868@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49884 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbbD0SA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2015 14:00:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v4.1-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (17/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    FAIL ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL (14/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 6/17): 4460varsomom, 2430sdp, 3530es3beagle, 3530es31beagle,
		  cmt3517, 5430es2sbct54
    skip ( 2/17): 5912osk, 3517evm
    Pass ( 9/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  37xxevm, 3730beaglexm, 3730es12beaglexm, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 1/17): 4430es2panda

PM: chip retention via suspend:
    FAIL ( 8/12): am335xbonelt, 4430es2panda, 4460varsomom,
		  3530es3beagle, 3530es31beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 4/12): 4460pandaes, 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 9/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 3530es3beagle, 3530es31beagle, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 3/12): 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.0 (39a8804455fb23f09157341d3ba7db6d7ae6ee76)):
   text     data      bss    total  kernel
 +39378     +632     +760   +40770  omap1_defconfig
 +41722     +616     +760   +43098  omap1_defconfig_1510innovator_only
 +40430     +592     +728   +41750  omap1_defconfig_5912osk_only
+329506   +29440    +1472  +360418  multi_v7_defconfig
+230849  +164752    +1664  +397265  omap2plus_defconfig
+203731  +159872    +1520  +365123  omap2plus_defconfig_2430sdp_only
+234533  +172200    +1664  +408397  omap2plus_defconfig_am33xx_only
+235213  +172832    +1664  +409709  omap2plus_defconfig_am43xx_only
+235137  +164808    +1728  +401673  omap2plus_defconfig_cpupm
+235341  +173200    +1728  +410269  omap2plus_defconfig_dra7xx_only
+145086    -5184     +876  +140778  omap2plus_defconfig_n800_multi_omap2xxx
+117531    -5280     +908  +113159  omap2plus_defconfig_n800_only_a
+229841  +165560    +1664  +397065  omap2plus_defconfig_no_pm
+231321  +173368    +1664  +406353  omap2plus_defconfig_omap2_4_only
+225505  +160616    +1664  +387785  omap2plus_defconfig_omap3_4_only
+230973  +173128    +1664  +405765  omap2plus_defconfig_omap5_only
 +23044    -8460     -280   +14304  rmk_omap3430_ldp_allnoconfig
+200865    -2072    +1040  +199833  rmk_omap3430_ldp_oldconfig
 +23052     +488     +368   +23908  rmk_omap4430_sdp_allnoconfig
+265861    +4824    +1344  +272029  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.0 (39a8804455fb23f09157341d3ba7db6d7ae6ee76))
  avail  rsrvd   high  freed  board          kconfig
  -112k   112k      .      .  2420n800       omap2plus_defconfig_n800_only_a
 -94508k -35540k      .      .  2430sdp        omap2plus_defconfig
 -224220k -36900k      .  -428k  3530es31beagle omap2plus_defconfig
 -224220k -36900k      .  -428k  3530es3beagle  omap2plus_defconfig
  -396k   396k      .    12k  3730beaglexm   omap2plus_defconfig
  -396k   396k      .    12k  3730es12beaglexmomap2plus_defconfig
  -392k   392k      .    12k  37xxevm        omap2plus_defconfig
  -400k   400k      .    12k  4430es2panda   omap2plus_defconfig
  -400k   400k      .    12k  4460pandaes    omap2plus_defconfig
 -1003328k -44224k -252928k  -428k  4460varsomom   omap2plus_defconfig
  -404k   404k      .  -428k  5430es2sbct54  omap2plus_defconfig
  -400k   400k      .    12k  5430es2uevm    omap2plus_defconfig
  -400k   400k      .     8k  am335xbone     omap2plus_defconfig_am33xx_only
  -396k   396k      .    12k  am335xbonelt   omap2plus_defconfig

