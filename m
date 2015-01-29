From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.19-rc6
Date: Thu, 29 Jan 2015 08:16:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501290808440.19947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36925 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbA2IQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2015 03:16:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.19-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.19-rc6/20150128221837/


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
    FAIL ( 1/ 3): omap1_defconfig_1510innovator_only

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL ( 2/17): omap2plus_defconfig_no_pm, multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 2/17): 5912osk, 3517evm
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 3/17): 4430es2panda, 4460varsomom, cmt3517

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 7/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 5/12): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

PM: chip off via dynamic idle:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 2/17): 4430es2panda, 4460varsomom


vmlinux object size
(delta in bytes from test_v3.19-rc5 (ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc)):
   text     data      bss    total  kernel
   +252      +32        0     +284  omap1_defconfig
   +252      +40        0     +292  omap1_defconfig_1510innovator_only
   +252      +32        0     +284  omap1_defconfig_5912osk_only
  +1445    +2440        0    +3885  multi_v7_defconfig
  +3345    +2952        0    +6297  omap2plus_defconfig
 +10263     +384       +8   +10655  omap2plus_defconfig_2430sdp_only
 +10791     +768        0   +11559  omap2plus_defconfig_am33xx_only
 +10919    +1416        0   +12335  omap2plus_defconfig_am43xx_only
  +3281    +2944        0    +6225  omap2plus_defconfig_cpupm
  +6887    +1344        0    +8231  omap2plus_defconfig_dra7xx_only
 +10187     +608        0   +10795  omap2plus_defconfig_n800_multi_omap2xxx
 +10066     +544        0   +10610  omap2plus_defconfig_n800_only_a
  +3277    +3008        0    +6285  omap2plus_defconfig_no_pm
  +7377    +1600        0    +8977  omap2plus_defconfig_omap2_4_only
  +3277    +1600        0    +4877  omap2plus_defconfig_omap3_4_only
 +10919    +1336        0   +12255  omap2plus_defconfig_omap5_only
   +172     +324      -24     +472  rmk_omap3430_ldp_allnoconfig
   +508     +392        0     +900  rmk_omap3430_ldp_oldconfig
   +580    +1028      -96    +1512  rmk_omap4430_sdp_allnoconfig
   +972    +1048        0    +2020  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.19-rc5 (ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc))
  avail  rsrvd   high  freed  board          kconfig
   -12k    12k      .      .  2420n800       omap2plus_defconfig_n800_only_a
    -4k     4k      .    -4k  3530es31beagle omap2plus_defconfig
    -4k     4k      .    -4k  3530es3beagle  omap2plus_defconfig
      .      .      .    -4k  3730beaglexm   omap2plus_defconfig
      .      .      .    -4k  3730es12beaglexmomap2plus_defconfig
    -4k     4k      .    -4k  37xxevm        omap2plus_defconfig
    -4k     4k      .    -4k  4430es2panda   omap2plus_defconfig
    -4k     4k      .    -4k  4460pandaes    omap2plus_defconfig
    -4k     4k      .    -4k  4460varsomom   omap2plus_defconfig
    -4k     4k      .    -4k  5430es2sbct54  omap2plus_defconfig
      .      .      .    -4k  5430es2uevm    omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
      .      .      .    -4k  am335xbonelt   omap2plus_defconfig


Something is not right with either our kernel, or the OMAP4460 VAR-SOM-OM 
board in the testbed.  It hit an alignment fault during the boot test:

http://www.pwsan.com/omap/testlogs/test_v3.19-rc6/20150128221837/boot/4460varsomom/4460varsomom_log.txt

but not the PM test:

http://www.pwsan.com/omap/testlogs/test_v3.19-rc6/20150128221837/pm/4460varsomom/4460varsomom_log.txt

The kernel command line options are different between the two boots.  
Something to keep an eye on.
