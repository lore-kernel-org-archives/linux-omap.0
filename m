From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7
Date: Tue, 11 Dec 2012 22:17:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212112213100.26612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47535 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab2LKWRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 17:17:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7/20121211094536/


Test summary
------------

Boot to userspace:
    Pass (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
    	  	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
		  am335xbone, 4460pandaes
    FAIL ( 1/11): cmt3517 
  
PM ret/off, suspend + dynamic idle:
    Pass (3/3): 3530es3beagle, 3730beaglexm, 37xxevm

PM ret, suspend + dynamic idle:
    FAIL (1/1): 4430es2panda


Failing tests: fixed by posted patches
--------------------------------------

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265
  - http://marc.info/?l=linux-omap&m=135274739624125&w=2


Failing tests: needing investigation
------------------------------------

Boot tests:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file

PM tests:

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Cause unknown
  - Not yet part of the automated test suite
  - Re-tested at v3.7; still failing:
    http://www.pwsan.com/omap/transcripts/20121211-3730beaglexm-3.7-pm-offmode-fail-debug.txt

Other:

* 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code
  - Jon Hunter reports this does not appear with the same X-loader/bootloader
    on his 4430ES2.3 Panda, so could be ES-level dependent


Failing tests: needing local investigation (may be due to testbed issues)
-------------------------------------------------------------------------

Boot tests:

* AM335x Beaglebone: omap2plus_defconfig kernels don't boot
  - May be fixed now, pending retest:
    - http://marc.info/?l=linux-omap&m=135082257727502&w=2
  - Not yet part of the automated test suite
  * May be due to an old U-boot with FDT support problems used here?
    Pending local investigation and re-test


vmlinux object size
(delta in bytes from test_v3.6 (a0d271cbfed1dd50278c6b06bead3d00ba0a88f9)):
   text     data      bss    total  kernel
+122692   -66544    +2224   +58372  am33xx_only
 +65113   -88872    +2100   -21659  n800_multi_omap2xxx
 +61845   -86344    +2132   -22367  n800_only_a
 +60069    +5472     -104   +65437  omap1_defconfig
 +59297    +3136      -72   +62361  omap1_defconfig_1510innovator_only
 +60293    +3152     -104   +63341  omap1_defconfig_5912osk_only
+137078   -67552    +2080   +71606  omap2plus_defconfig
+110984   -83632    +1968   +29320  omap2plus_defconfig_2430sdp_only
+133010   -67560    +2016   +67466  omap2plus_defconfig_cpupm
+134877   -67432    +1888   +69333  omap2plus_defconfig_no_pm
+112176   -88776    +2016   +25416  omap2plus_defconfig_omap2_4_only
+111951   -88104    +2016   +25863  omap2plus_defconfig_omap3_4_only
+134205   -66896    +2348   +69657  rmk_omap3430_ldp_oldconfig
+110261   -47016    +2760   +66005  rmk_omap4430_sdp_oldconfig



Boot-time memory difference
(delta in bytes from test_v3.6 (a0d271cbfed1dd50278c6b06bead3d00ba0a88f9))
  avail  rsrvd   high  freed  board          kconfig
    20k   -20k      .      .  2420n800       n800_only_a
   -72k    72k      .     4k  2430sdp        omap2plus_defconfig
   -72k    72k      .     4k  3517evm        omap2plus_defconfig
   -72k    72k      .     4k  3530es3beagle  omap2plus_defconfig
   -72k    72k      .     4k  3730beaglexm   omap2plus_defconfig
   -72k    72k      .     4k  37xxevm        omap2plus_defconfig
   -72k    72k      .     4k  4430es2panda   omap2plus_defconfig
   -64k    64k      .      .  5912osk        omap1_defconfig
   -72k    72k      .      .  cmt3517        omap2plus_defconfig


