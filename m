From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9-rc6
Date: Wed, 10 Apr 2013 20:05:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304102003190.25123@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46815 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3DJUFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 16:05:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9-rc6/20130410123059/


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
    FAIL ( 3/ 6): 2430sdp, 37xxevm, 4430es2panda
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 4460pandaes

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

* am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link 
errors
  - Discussion & RFC patch: 
http://www.spinics.net/lists/arm-kernel/msg230017.html
  - Still needs revision of the patch


Failing tests: needing investigation
------------------------------------

Boot tests:

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug
  - Not currently part of the automated test suite

Boot warnings:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see 
http://marc.info/?l=linux-omap&m=134833869730129&w=2
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


Failing tests: reported by others 
---------------------------------

- MUSB broken after v3.9-rc6
  - due to commit 92702df3570e1ccfa050e135e50c450502251b79
  - discussion here: http://marc.info/?l=linux-omap&m=136544098331552&w=2
  - patch here but needs work:
    http://marc.info/?l=linux-kernel&m=136554118002341&w=2


vmlinux object size
(delta in bytes from test_v3.9-rc5 
(07961ac7c0ee8b546658717034fe692fd12eefa9)):
   text     data      bss    total  kernel
   +579     +104      +64     +747  n800_multi_omap2xxx
   +503      +88        0     +591  n800_only_a
  +1111      -40        0    +1071  omap1_defconfig
  +1123      -72        0    +1051  omap1_defconfig_1510innovator_only
  +1107      -32        0    +1075  omap1_defconfig_5912osk_only
  +1291     +248        0    +1539  omap2plus_defconfig
  +1223     +216        0    +1439  omap2plus_defconfig_cpupm
  +1287     +184        0    +1471  omap2plus_defconfig_no_pm
  +1015     +184      +64    +1263  omap2plus_defconfig_omap2_4_only
  +1159     +184      +64    +1407  omap2plus_defconfig_omap3_4_only
   +780     +136     -124     +792  rmk_omap3430_ldp_allnoconfig
  +1075     +144        0    +1219  rmk_omap3430_ldp_oldconfig
   +780     +136     -124     +792  rmk_omap4430_sdp_allnoconfig
  +1155     +144        0    +1299  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.9-rc5 
(07961ac7c0ee8b546658717034fe692fd12eefa9))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2420n800       n800_only_a
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  5912osk        omap1_defconfig


- Paul
