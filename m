From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.8-rc1
Date: Fri, 28 Dec 2012 17:48:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212281738300.27761@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35609 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab2L1Rsh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Dec 2012 12:48:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.8-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/


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

Build tests:

* rmk_3430_ldp_allnoconfig, rmk_4430_sdp_allnoconfig: twl4030 build failures
  - in drivers/mfd/twl-core.c

Boot tests:

* am335xbone: hangs after "Starting kernel"
  - Cause unknown
  - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file

Boot warnings:

* 3530es3beagle, 3730beaglexm, 37xxevm: nand_scan_ident() warning
  - "at drivers/mtd/nand/nand_base.c:2861 nand_scan_ident+0xdb4/0xf90()"
  - http://marc.info/?l=linux-omap&m=135630897110185&w=2

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: pwrdm state mismatch(mdm_pwrdm) 0 != 3
  - Fixed by http://www.spinics.net/lists/arm-kernel/msg209739.html
    - but this causes "pwrdm state mismatch(dsp_pwrdm) 0 != 3"

* 2430sdp: incorrect power states reported in /debug/pm_debug/count
  - Power states reported as OFF rather than ON or RET
  - Fixed by http://www.spinics.net/lists/arm-kernel/msg209739.html

* 2430sdp: power domains not entering retention

* 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79

* 4460pandaes: pwrdm state mismatch on IVAHD, TESLA

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
(delta in bytes from test_v3.7 (29594404d7fe73cd80eaa4ee8c43dcc53970c60e)):
   text     data      bss    total  kernel
-180020    -9368   -30332  -219720  n800_multi_omap2xxx
-178004   -11528   -30300  -219832  n800_only_a
 +83162    +3600     +160   +86922  omap1_defconfig
 +86446    +4032     +160   +90638  omap1_defconfig_5912osk_only
+168843   +25288     +900  +195031  omap2plus_defconfig
+113347   +16608     +100  +130055  omap2plus_defconfig_2430sdp_only
+168903   +28296     +900  +198099  omap2plus_defconfig_no_pm
+132066   +16128     +772  +148966  omap2plus_defconfig_omap2_4_only
+161969   +47968     +900  +210837  omap2plus_defconfig_omap3_4_only
 +99840   +16204      -52  +115992  rmk_omap3430_ldp_oldconfig
 +88235    +7032     +192   +95459  rmk_omap4430_sdp_oldconfig

The size for the n800_* kernels may not really be comparable with the
configs I used for v3.7.  They had to be stripped down to boot on n800
due to the NOLO 2GiB size limitation.  Otherwise, pretty major kernel size
increase from v3.7 to v3.8-rc1.


Boot-time memory difference
(delta in bytes from test_v3.7 (29594404d7fe73cd80eaa4ee8c43dcc53970c60e))
  avail  rsrvd   high  freed  board          kconfig
   212k  -212k      .   -12k  2420n800       n800_only_a
  -188k   188k      .     8k  2430sdp        omap2plus_defconfig
  -188k   188k      .     8k  3517evm        omap2plus_defconfig
  -188k   188k      .     8k  3530es3beagle  omap2plus_defconfig
 12100k -12100k      .     8k  3730beaglexm   omap2plus_defconfig
  -188k   188k      .     8k  37xxevm        omap2plus_defconfig
 16196k -16196k      .     8k  4430es2panda   omap2plus_defconfig
 32592k -32592k      .     8k  4460pandaes    omap2plus_defconfig
   -84k    84k      .      .  5912osk        omap1_defconfig
  -188k   188k      .      .  cmt3517        omap2plus_defconfig

Now this is really remarkable, and worth researching to find out what 
happened and why it only affected three boards.  I doublechecked the size 
calculation scripts here and the calculations appear correct.  


- Paul
