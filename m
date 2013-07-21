From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc1
Date: Sun, 21 Jul 2013 09:36:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307210933330.15337@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36650 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab3GUJgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Jul 2013 05:36:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org



Here are some basic OMAP test results for Linux v3.11-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc1/20130721020309/


Test summary
------------

Build: uImage:
    Pass (14/14): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
		  omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Build: uImage+dtb:
    Pass ( 3/ 3): am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Boot to userspace:
    FAIL ( 5/ 11): 2430sdp, 3530es3beagle, 3730beaglexm, 5912osk, am335xbonelt
    Pass ( 6/ 11): 3517evm, 37xxevm, 4430es2panda, 4460pandaes, am335xbone, cmt3517

PM: chip retention via suspend:
    FAIL ( 4/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda
    Pass ( 2/ 6): 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda, 4460pandaes
    Pass ( 1/ 6): 37xxevm

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm


vmlinux object size
(delta in bytes from test_v3.10 (8bb495e3f02401ee6f76d1b1d77f3ac9f079e376)):
   text     data      bss    total  kernel
+105416    +2632    +2000  +110048  am33xx_only
 +42013    +1728     +960   +44701  n800_multi_omap2xxx
 +41993    +1592     +960   +44545  n800_only_a
 +45499     +832     +472   +46803  omap1_defconfig
 +50118    +2584     +472   +53174  omap1_defconfig_1510innovator_only
 +53938    +2648     +440   +57026  omap1_defconfig_5912osk_only
+159173    -2456    +1680  +158397  omap2plus_defconfig
+156519    +8608    +2752  +167879  omap2plus_defconfig_2430sdp_only
+144258    -4400    +1680  +141538  omap2plus_defconfig_cpupm
+155750    -2800    +1744  +154694  omap2plus_defconfig_no_pm
+155973   -27688    +1936  +130221  omap2plus_defconfig_omap2_4_only
+103989   -55072    +1616   +50533  omap2plus_defconfig_omap3_4_only
 -30840  -110588     -736  -142164  rmk_omap3430_ldp_allnoconfig
 +41080   -28816    +3988   +16252  rmk_omap3430_ldp_oldconfig
 -60468  -176540     +560  -236448  rmk_omap4430_sdp_allnoconfig


Boot-time memory difference
(delta in bytes from test_v3.10 (8bb495e3f02401ee6f76d1b1d77f3ac9f079e376))
  avail  rsrvd   high  freed  board          kconfig
   -44k    44k      .    -4k  2420n800       n800_only_a
 -98412k -32660k      .  -392k  2430sdp        omap2plus_defconfig
  -152k  -872k      .   -12k  3517evm        omap2plus_defconfig
  -152k  -872k      .   -12k  3530es3beagle  omap2plus_defconfig
  -152k  -872k      .   -12k  3730beaglexm   omap2plus_defconfig
  -216k  -808k      .   -12k  4430es2panda   omap2plus_defconfig
  -204k  -820k      .   -12k  4460pandaes    omap2plus_defconfig
   -48k    48k      .      .  5912osk        omap1_defconfig
  -116k   116k      .     4k  am335xbone     am33xx_only
  -152k  -872k      .   -12k  am335xbonelt   am33xx_only


OMAP4 platforms have been switched to DT boots, since board file-based 
booting was deprecated for OMAP4 after v3.10.
