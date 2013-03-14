From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9-rc2
Date: Thu, 14 Mar 2013 19:02:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303141858320.28203@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51182 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3CNTCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 15:02:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9-rc2/20130314094808/


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
    FAIL ( 4/11): 2430sdp, 37xxevm, 5912osk, am335xbone
    Pass ( 7/11): 2420n800, 3517evm, 3530es3beagle,
  	   	  3730beaglexm, 4430es2panda, 4460pandaes,
		  cmt3517

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

PM:

* 4460pandaes: CORE, L3INIT didn't enter target state
  - Caused by 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
    (ARM: OMAP4: clock/hwmod data: start to remove some IP block control
     "clocks")
  - Fixed by "ARM: OMAP4: PM: fix PM regression introduced by recent clock
    cleanup"
    - http://www.spinics.net/lists/arm-kernel/msg224419.html

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
  - Jon Hunter reports this does not appear with the same X-loader/bootloader
    on his 4430ES2.3 Panda, so could be ES-level dependent


vmlinux object size
(delta in bytes from test_v3.9-rc1 
(6dbe51c251a327e012439c4772097a13df43c5b8)):
   text     data      bss    total  kernel
 +13528      +64        0   +13592  omap1_defconfig
  +9440     +120        0    +9560  omap2plus_defconfig
 +13472     +128        0   +13600  omap2plus_defconfig_cpupm
 +13472     +128        0   +13600  omap2plus_defconfig_omap2_4_only
  +9756     +120        0    +9876  omap2plus_defconfig_omap3_4_only
   +704      -64     -188     +452  rmk_omap3430_ldp_allnoconfig
   +556      -64        0     +492  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.9-rc1 
(6dbe51c251a327e012439c4772097a13df43c5b8))
  avail  rsrvd   high  freed  board          kconfig
   -16k    16k      .      .  2430sdp        omap2plus_defconfig
   -16k    16k      .      .  3517evm        omap2plus_defconfig
   -16k    16k      .      .  3530es3beagle  omap2plus_defconfig
   -16k    16k      .      .  3730beaglexm   omap2plus_defconfig
   -16k    16k      .      .  37xxevm        omap2plus_defconfig
   -16k    16k      .      .  4430es2panda   omap2plus_defconfig
   -16k    16k      .      .  4460pandaes    omap2plus_defconfig


- Paul
