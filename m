From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9-rc1
Date: Tue, 12 Mar 2013 16:40:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34698 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933138Ab3CLQkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 12:40:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/


Test summary
------------

Build:
    FAIL ( 4/16): am33xx_only, omap1_defconfig,
    	   	  omap1_defconfig_5912osk_only,
		  omap2plus_defconfig_2430sdp_only
    Pass (12/16): n800_multi_omap2xxx, n800_only_a,
    	 	  omap1_defconfig_1510innovator_only, 
		  omap2plus_defconfig, omap2plus_defconfig_cpupm,
		  omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 4/11): 2430sdp, 37xxevm, am335xbone, cmt3517
    Pass ( 7/11): 2420n800, 3517evm, 3530es3beagle,
  	   	  3730beaglexm, 4430es2panda, 5912osk,
		  4460pandaes
  
PM ret, suspend:
    FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

PM ret, dynamic idle:
    FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

PM off, suspend:
    FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 5): 3530es3beagle, 3730beaglexm

PM off, dynamic idle:
    FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 5): 3530es3beagle, 3730beaglexm


Failing tests: fixed by posted patches
--------------------------------------

Build:

* omap1_defconfig: several problems with mach-omap1/board-h2.c
  - Fixed by Tony: http://www.spinics.net/lists/arm-kernel/msg224133.html

* omap1_defconfig_5912osk_only: implicit declaration of function 'cpu_is_omap15xx'
  - Fixed by Aaro: http://www.spinics.net/lists/linux-omap/msg87523.html


Failing tests: needing investigation
------------------------------------

Build:

* am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link errors

Boot tests:

* 2430sdp & 37xxevm: hang during MMC partition probe
  - Cause unknown

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file
  - http://www.spinics.net/lists/arm-kernel/msg211471.html
  - Longstanding bug

Boot warnings:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: pwrdm state mismatch(dsp_pwrdm) 0 != 3
  - need to doublecheck wakeup dependencies
  - (am assuming it's still there; does not boot to userspace)

* 2430sdp: power domains not entering retention
  - Cause unknown
  - (am assuming it's still there; does not boot to userspace)

* 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE

* 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79

* 4460pandaes: CORE, L3INIT didn't enter target state
  - Cause unknown; appeared with v3.9-rc1

* 4460pandaes: chip not entering retention in dynamic idle
  - Presumably 4430es2panda also fails this

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock-gate ("debug ignore_loglevel")
  - Cause unknown
  - Not yet part of the automated test suite
  - Re-tested at v3.7; still failing:
    http://www.pwsan.com/omap/transcripts/20121211-3730beaglexm-3.7-pm-offmode-fail-debug.txt

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265
  - http://marc.info/?l=linux-omap&m=135274739624125&w=2
  - http://marc.info/?l=linux-omap&m=135664195831104&w=2
  - Should be working in v3.9-rc1 when CONFIG_RETU_WATCHDOG=y ?

* 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code
  - Jon Hunter reports this does not appear with the same X-loader/bootloader
    on his 4430ES2.3 Panda, so could be ES-level dependent



vmlinux object size
(delta in bytes from test_v3.8 (19f949f52599ba7c3f67a5897ac6be14bfcb1200)):
   text     data      bss    total  kernel
+195310   +37968    +1364  +234642  omap2plus_defconfig
+185362   +37128    +1364  +223854  omap2plus_defconfig_cpupm
+186719   +31416    +1300  +219435  omap2plus_defconfig_omap2_4_only
+181125   +41432    +1300  +223857  omap2plus_defconfig_omap3_4_only
 +10460   +10272    +1184   +21916  rmk_omap3430_ldp_allnoconfig
 +40867   +14672     +972   +56511  rmk_omap4430_sdp_oldconfig

Looks like v3.9 is well on target to exceed even the previous 
per-release bloat records.

There are some entries missing from the above table; this is probably due 
to some bug in my scripts that needs to be dealt with.


Boot-time memory difference
(delta in bytes from test_v3.8 (19f949f52599ba7c3f67a5897ac6be14bfcb1200))
  avail  rsrvd   high  freed  board          kconfig
 -15892k 15892k      .     4k  2420n800       n800_only_a
 -16644k 16644k      .  -328k  2430sdp        omap2plus_defconfig
 -16644k 16644k      .    12k  3517evm        omap2plus_defconfig
 -16644k 16644k      .    12k  3530es3beagle  omap2plus_defconfig
 -16644k 16644k      .    12k  3730beaglexm   omap2plus_defconfig
 -16644k 16644k      .  -328k  37xxevm        omap2plus_defconfig
 -16636k 16636k      .    12k  4430es2panda   omap2plus_defconfig
 -16656k 16656k      .    12k  4460pandaes    omap2plus_defconfig

Current guess is that this huge change is due to CMA:

[    0.000000] cma: CMA: reserved 16 MiB at 86800000

etc.

