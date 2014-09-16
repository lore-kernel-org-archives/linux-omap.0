From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc5
Date: Tue, 16 Sep 2014 17:36:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409161731360.23518@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54048 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaIPRgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 13:36:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.17-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc5/20140916100200/


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

Boot to userspace:
    FAIL ( 2/17): 2430sdp, 5430es2sbct54
    skip ( 1/17): 5912osk
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3517evm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 5430es2uevm, 2420n800

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 8/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 3530es3beagle, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 4/12): 37xxevm, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 1/ 4): 3530es3beagle
    Pass ( 3/ 4): 37xxevm, 3530es31beagle, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 1/ 4): 3530es3beagle
    Pass ( 3/ 4): 37xxevm, 3530es31beagle, 3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.17-rc4 (2ce7598c9a453e0acd0e07be7be3f5eb39608ebd)):
   text     data      bss    total  kernel
  +1980      +40        0    +2020  omap1_defconfig
  +1980      -16        0    +1964  omap1_defconfig_1510innovator_only
  +1980      +40        0    +2020  omap1_defconfig_5912osk_only
  +1964      +72        0    +2036  multi_v7_defconfig
  +1172      +16        0    +1188  omap2plus_defconfig
  +1212      +16        0    +1228  omap2plus_defconfig_2430sdp_only
  +1172      -48        0    +1124  omap2plus_defconfig_am33xx_only
  +1236      -48        0    +1188  omap2plus_defconfig_am43xx_only
  +1172      -80        0    +1092  omap2plus_defconfig_cpupm
  +1172      +24        0    +1196  omap2plus_defconfig_dra7xx_only
   +576      -40        0     +536  omap2plus_defconfig_n800_multi_omap2xxx
   +544      -40        0     +504  omap2plus_defconfig_n800_only_a
  +1236       -8        0    +1228  omap2plus_defconfig_no_pm
  +1236       -8        0    +1228  omap2plus_defconfig_omap2_4_only
  +1172      +16        0    +1188  omap2plus_defconfig_omap3_4_only
  +1172       -8        0    +1164  omap2plus_defconfig_omap5_only
   +516      +16      +16     +548  rmk_omap3430_ldp_allnoconfig
   +960      -64        0     +896  rmk_omap3430_ldp_oldconfig
   +548      +12      -16     +544  rmk_omap4430_sdp_allnoconfig
  +1024      -64        0     +960  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc4 (2ce7598c9a453e0acd0e07be7be3f5eb39608ebd))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
 -224884k -36236k      .  -404k  am335xbonelt   omap2plus_defconfig



am335xbonelt has been switched to using the am335x-boneblack.dts file to 
boot it, rather than the original am335x-bone.dts file.
 
The boot-time memory difference entry for am335xbonelt is bogus - it's 
because the diff scripts don't handle the DTS change correctly.

A Rev. C1 3730 Beagle-XM has been added to the testbed as 
"3730es12beaglexm".  These contain ES1.2 3730 chips which can enter 
CORE-off states correctly, unlike the Rev A Beagle-XM that's in the 
testbed as "3730beaglexm".

