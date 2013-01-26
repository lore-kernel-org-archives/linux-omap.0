From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.8-rc5
Date: Sat, 26 Jan 2013 08:40:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49849 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3AZIkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jan 2013 03:40:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.8-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.8-rc5/20130126003323/


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
  - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
  - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
  - http://marc.info/?l=linux-omap&m=135903184512238&w=2

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file
  - http://www.spinics.net/lists/arm-kernel/msg211471.html

Boot warnings:

* 3530es3beagle, 3730beaglexm, 37xxevm: nand_scan_ident() warning
  - "at drivers/mtd/nand/nand_base.c:2861 nand_scan_ident+0xdb4/0xf90()"
  - http://marc.info/?l=linux-omap&m=135630897110185&w=2

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
  - Nishanth Menon & Vaibhav Hiremath report that it works for them
  * May be due to an old U-boot with FDT support problems used here?
    Pending local investigation and re-test


vmlinux object size
(delta in bytes from test_v3.8-rc4 
(7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619)):
   text     data      bss    total  kernel
   +512        0        0     +512  am33xx_only
   +776      +24        0     +800  n800_multi_omap2xxx
   +772       -8        0     +764  n800_only_a
   +648        0        0     +648  omap1_defconfig
   +648        0        0     +648  omap1_defconfig_1510innovator_only
   +664        0        0     +664  omap1_defconfig_5912osk_only
   +724       +8        0     +732  omap2plus_defconfig
   +504      +24        0     +528  omap2plus_defconfig_2430sdp_only
   +788       +8        0     +796  omap2plus_defconfig_cpupm
   +628       +8        0     +636  omap2plus_defconfig_no_pm
   +724       +8        0     +732  omap2plus_defconfig_omap2_4_only
   +504      +16        0     +520  omap2plus_defconfig_omap3_4_only
   +328       +8        0     +336  rmk_omap3430_ldp_allnoconfig
   +656        0        0     +656  rmk_omap3430_ldp_oldconfig
   +328       +8        0     +336  rmk_omap4430_sdp_allnoconfig
   +800       +8        0     +808  rmk_omap4430_sdp_oldconfig

