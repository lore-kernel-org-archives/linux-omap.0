From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.8-rc7
Date: Sun, 10 Feb 2013 22:20:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302102216480.6247@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603Ab3BJWUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 17:20:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org



Here are some basic OMAP test results for Linux v3.8-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.8-rc7/20130210080644/


Test summary
------------

Boot to userspace:
    Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
  	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
		  4460pandaes
    FAIL ( 2/11): am335xbone, cmt3517 
  
PM ret/off, suspend + dynamic idle:
    Pass (3/3): 3530es3beagle, 3730beaglexm, 37xxevm

PM ret, suspend + dynamic idle:
    Pass (1/2): 4460pandaes
    FAIL (1/2): 4430es2panda

PM ret, dynamic idle:
    FAIL (1/1): 2430sdp


Failing tests: fixed by posted patches
--------------------------------------

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265
  - http://marc.info/?l=linux-omap&m=135274739624125&w=2
  - http://marc.info/?l=linux-omap&m=135664195831104&w=2


Failing tests: needing investigation
------------------------------------

Boot tests:

* am335xbone: hangs after "Starting kernel"
  - Cause unknown
  - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
  - http://marc.info/?l=linux-omap&m=135903184512238&w=2
  - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83942.html

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file
  - http://www.spinics.net/lists/arm-kernel/msg211471.html

Boot warnings:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: pwrdm state mismatch(dsp_pwrdm) 0 != 3
  - need to doublecheck wakeup dependencies

* 2430sdp: power domains not entering retention
  - Cause unknown

* 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE

* 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock-gate ("debug ignore_loglevel")
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
  - Nishanth Menon & Vaibhav Hiremath report that it works for them
  * May be due to an old U-boot with FDT support problems used here?
    Pending local investigation and re-test


Problems reported by others
---------------------------

(none currently listed)




vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
  +1146    -2560       +4    -1410  am33xx_only
   +164        0        0     +164  n800_multi_omap2xxx
   +164        0        0     +164  n800_only_a
  +5500    -2592       +4    +2912  omap1_defconfig
  +1436    -2600       +4    -1160  omap1_defconfig_1510innovator_only
  +1404    -2592       +4    -1184  omap1_defconfig_5912osk_only
  +1566    -2632       +4    -1062  omap2plus_defconfig
  +1118    -2592       +4    -1470  omap2plus_defconfig_2430sdp_only
  +1562    -2544       +4     -978  omap2plus_defconfig_cpupm
  +1562    -2600       +4    -1034  omap2plus_defconfig_no_pm
  +1630    -2544       +4     -910  omap2plus_defconfig_omap2_4_only
  +1366    -2608       +4    -1238  omap2plus_defconfig_omap3_4_only
   +412      +16     -104     +324  rmk_omap3430_ldp_allnoconfig
   +224        0       +4     +228  rmk_omap3430_ldp_oldconfig
   +412      +16     -104     +324  rmk_omap4430_sdp_allnoconfig
   +272      +16       +4     +292  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2430sdp        omap2plus_defconfig
     4k    -4k      .      .  3530es3beagle  omap2plus_defconfig
     4k    -4k      .      .  3730beaglexm   omap2plus_defconfig
     4k    -4k      .      .  37xxevm        omap2plus_defconfig
     4k    -4k      .      .  4430es2panda   omap2plus_defconfig
     4k    -4k      .      .  4460pandaes    omap2plus_defconfig
    -4k     4k      .      .  5912osk        omap1_defconfig
     4k    -4k      .      .  cmt3517        omap2plus_defconfig




- Paul
