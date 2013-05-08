From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9
Date: Wed, 8 May 2013 19:39:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58199 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab3EHTkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:40:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9/20130429104339/


Test summary
------------

Build:
    FAIL ( 2/16): am33xx_only, omap2plus_defconfig_2430sdp_only
    Pass (14/16): n800_multi_omap2xxx, n800_only_a, omap1_defconfig, 
                  omap1_defconfig_1510innovator_only, 
                  omap1_defconfig_5912osk_only, omap2plus_defconfig, 
                  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm, 
                  omap2plus_defconfig_omap2_4_only, 
                  omap2plus_defconfig_omap3_4_only, 
                  rmk_omap3430_ldp_allnoconfig, 
                  rmk_omap3430_ldp_oldconfig, 
                  rmk_omap4430_sdp_allnoconfig, 
                  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 1/11): am335xbone
    Pass (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
                  3730beaglexm, 37xxevm, 4430es2panda, 4460pandaes,
                  5912osk, cmt3517

PM ret, suspend:
    FAIL ( 2/ 6): 2430sdp, 4430es2panda
    Pass ( 4/ 6): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM ret, dynamic idle:
    FAIL ( 3/ 6): 2430sdp, 4430es2panda, 4460pandaes
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 37xxevm

PM off, suspend:
    FAIL ( 2/ 5): 4430es2panda, 4460pandaes
    Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm

PM off, dynamic idle:
    FAIL ( 2/ 5): 4430es2panda, 4460pandaes
    Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm



Failing tests: fixed by posted patches
--------------------------------------

Build:

* am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link errors
  - Discussion & RFC patch: http://www.spinics.net/lists/arm-kernel/msg230017.html
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
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: power domains not entering retention
  - Cause unknown

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
(delta in bytes from test_v3.9-rc8 
(60d509fa6a9c4653a86ad830e4c4b30360b23f0e)):
   text     data      bss    total  kernel
   +176       +8        0     +184  n800_multi_omap2xxx
   +160       +8        0     +168  n800_only_a
   +120       +8        0     +128  omap1_defconfig
   +136       +8        0     +144  omap1_defconfig_1510innovator_only
   +152      -24        0     +128  omap1_defconfig_5912osk_only
   +204        0        0     +204  omap2plus_defconfig
   +204        0        0     +204  omap2plus_defconfig_cpupm
   +204        0        0     +204  omap2plus_defconfig_no_pm
   +204        0        0     +204  omap2plus_defconfig_omap2_4_only
   +204        0        0     +204  omap2plus_defconfig_omap3_4_only
   +132        0        0     +132  rmk_omap3430_ldp_allnoconfig
    +80        0        0      +80  rmk_omap3430_ldp_oldconfig
   +132        0        0     +132  rmk_omap4430_sdp_allnoconfig
    +96        0        0      +96  rmk_omap4430_sdp_oldconfig



vmlinux object size
(delta in bytes from test_v3.8 
(19f949f52599ba7c3f67a5897ac6be14bfcb1200)):
   text     data      bss    total  kernel
-549808   +23520    -9184  -535472  n800_multi_omap2xxx
-548359   +27432    -9268  -530195  n800_only_a
 +61909    +5680     +392   +67981  omap1_defconfig
 +62549    +5664     +424   +68637  omap1_defconfig_1510innovator_only
 +63725    +5672     +328   +69725  omap1_defconfig_5912osk_only
+215063   +40984    +1364  +257411  omap2plus_defconfig
+209163   +40088    +1364  +250615  omap2plus_defconfig_cpupm
+213279   +39256    +1364  +253899  omap2plus_defconfig_no_pm
+206200   +34440    +1428  +242068  omap2plus_defconfig_omap2_4_only
+200798   +44440    +1364  +246602  omap2plus_defconfig_omap3_4_only
  -5420    +9908    +2428    +6916  rmk_omap3430_ldp_allnoconfig
 +43627   +27696     +788   +72111  rmk_omap3430_ldp_oldconfig
  -5420    +9908    +2428    +6916  rmk_omap4430_sdp_allnoconfig
 +46204   +14712     +980   +61896  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.8 (19f949f52599ba7c3f67a5897ac6be14bfcb1200))
  avail  rsrvd   high  freed  board          kconfig
 -15904k 15904k      .     4k  2420n800       n800_only_a
 -16668k 16668k      .    12k  2430sdp        omap2plus_defconfig
 -16668k 16668k      .    12k  3517evm        omap2plus_defconfig
 -16668k 16668k      .    12k  3530es3beagle  omap2plus_defconfig
 -16668k 16668k      .    12k  3730beaglexm   omap2plus_defconfig
 -16668k 16668k      .    12k  37xxevm        omap2plus_defconfig
 -16660k 16660k      .    12k  4430es2panda   omap2plus_defconfig
 -16680k 16680k      .    12k  4460pandaes    omap2plus_defconfig
   -68k    68k      .     4k  5912osk        omap1_defconfig

16MiB of the reserved memory increase is probably due to CMA.

