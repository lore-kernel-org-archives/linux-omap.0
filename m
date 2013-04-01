From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9-rc5
Date: Mon, 1 Apr 2013 05:35:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304010531500.28273@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38281 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab3DAFfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 01:35:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9-rc5/20130331205513/


Test summary
------------

Build:
    FAIL ( 2/16): am33xx_only, omap2plus_defconfig_2430sdp_only
    Pass (14/16): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
		  omap1_defconfig_1510innovator_only, 
		  omap1_defconfig_5912osk_only,
		  omap2plus_defconfig, omap2plus_defconfig_cpupm,
		  omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 1/11): am335xbone
    Pass (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
  	   	  3730beaglexm, 37xxevm, 4430es2panda, 4460pandaes,
		  5912osk, cmt3517

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

* am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link errors
  - Discussion & RFC patch: http://www.spinics.net/lists/arm-kernel/msg230017.html

PM:

* 37xx EVM: UART sluggishness causes timeouts
  - Caused by commit 1776fd059c40907297d6c26c51876575d63fd9e2 
  - http://marc.info/?l=linux-omap&m=136479391601254&w=2

* 4460pandaes: CORE, L3INIT didn't enter target state
  - Caused by 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
    (ARM: OMAP4: clock/hwmod data: start to remove some IP block control
     "clocks")
  - Fixed by "ARM: OMAP4: PM: fix PM regression introduced by recent clock
    cleanup"
    - http://www.spinics.net/lists/arm-kernel/msg224419.html


Failing tests: needing investigation
------------------------------------

Boot tests:

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug
  - Not currently part of the automated test suite

Boot warnings:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: pwrdm state mismatch(dsp_pwrdm) 0 != 3
  - need to doublecheck wakeup dependencies
  - (am assuming it's still there; userspace problems prevent the test
     from running, probably due to the lock warning)

* 2430sdp: power domains not entering retention
  - Cause unknown
  - (am assuming it's still there; userspace problems prevent the test
     from running, probably due to the lock warning)

* 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE

* 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79
  - http://marc.info/?l=linux-arm-kernel&m=136432340618226&w=2

* 4460pandaes: chip not entering retention in dynamic idle
  - Presumably 4430es2panda also fails this
  - Suspend-to-RAM enters full chip retention

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
  - Jon Hunter and Santosh Shilimkar report this does not appear with
    the same X-loader/bootloader on his 4430ES2.3 Panda, so could be
    ES-level dependent


vmlinux object size
(delta in bytes from test_v3.9-rc4 (8bb9660418e05bb1845ac1a2428444d78e322cc7)):
   text     data      bss    total  kernel
   +711        0        0     +711  n800_multi_omap2xxx
   +695        0        0     +695  n800_only_a
   +809        0        0     +809  omap1_defconfig
   +813        0        0     +813  omap1_defconfig_1510innovator_only
+5583029  +312636  +117376  +6013041  omap1_defconfig_5912osk_only
  +4419      -16        0    +4403  omap2plus_defconfig
   +323       -8        0     +315  omap2plus_defconfig_cpupm
  +1111       -8        0    +1103  omap2plus_defconfig_no_pm
   +323      +24        0     +347  omap2plus_defconfig_omap2_4_only
   +331      -16        0     +315  omap2plus_defconfig_omap3_4_only
  +1024        0      -64     +960  rmk_omap3430_ldp_allnoconfig
   +527      -16        0     +511  rmk_omap3430_ldp_oldconfig
  +1024        0      -64     +960  rmk_omap4430_sdp_allnoconfig
  +1097       -8        0    +1089  rmk_omap4430_sdp_oldconfig


