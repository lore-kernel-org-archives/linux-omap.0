From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.10-rc7
Date: Mon, 1 Jul 2013 19:48:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45358 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab3GATsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jul 2013 15:48:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.10-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.10-rc7/20130630191558/

Special thanks to Lokesh Vutla, Vaibhav Hiremath, Kevin Hilman, and 
Rajendra Nayak for helping unravel the Beaglebone-White test problems.


Test summary
------------

Build: uImage:
    Pass (16/16): am33xx_only, n800_multi_omap2xxx, n800_only_a,
                  omap1_defconfig, omap1_defconfig_1510innovator_only, 
                  omap1_defconfig_5912osk_only, omap2plus_defconfig, 
                  omap2plus_defconfig_2430sdp_only
                  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm, 
                  omap2plus_defconfig_omap2_4_only, 
                  omap2plus_defconfig_omap3_4_only, 
                  rmk_omap3430_ldp_allnoconfig, 
                  rmk_omap3430_ldp_oldconfig, 
                  rmk_omap4430_sdp_allnoconfig, 
                  rmk_omap4430_sdp_oldconfig

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Boot to userspace:
    FAIL ( 2/12): 37xxevm, am335xbonelt
    Pass (10/12): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
                  3730beaglexm, 4430es2panda, 4460pandaes, 5912osk,
                  am335xbone, cmt3517

PM: chip retention via suspend:
    FAIL ( 3/ 6): 2430sdp, 37xxevm, 4430es2panda
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 3530es3beagle

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 3530es3beagle


Failing tests: fixed by posted patches
--------------------------------------

* 37xx EVM: boot fails
  - as of v3.10-rc1
  - Fixed by http://marc.info/?l=linux-arm-kernel&m=137112093431021&w=2
  

Failing tests: needing investigation
------------------------------------

Boot tests:

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug
  - Not currently part of the automated test suite

Boot warnings:

* 2420N800, 2430sdp: failed to get counter_32k resource
  - "omap2_sync32k_clocksource_init: failed to get counter_32k resource"
  - Cause unknown

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3730 Beagle XM, 3517EVM, CM-T3517: uart4_rx.uart4_rx mux failure
  - Cause unknown
  - May be related to the OMAP serial driver and/or DT mux data
  - http://marc.info/?l=linux-arm-kernel&m=137121357528854&w=2

PM tests:

* 2430sdp: power domains not entering retention
  - Cause unknown

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock-gate ("debug ignore_loglevel")
  - Cause unknown
  - Not yet part of the automated test suite
  - Re-tested at v3.7; still failing:
    http://www.pwsan.com/omap/transcripts/20121211-3730beaglexm-3.7-pm-offmode-fail-debug.txt

* 4430es2panda: pwrdm state mismatch on CAM, DSS

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79
  - http://marc.info/?l=linux-arm-kernel&m=136432340618226&w=2

* 4430es2panda: MPU, ABE didn't enter target state
  - New for v3.10-rc

* 4460pandaes: pwrdm state mismatch on DSS, ABE, IVAHD, TESLA

* 4460pandaes: chip not entering retention in dynamic idle
  - Presumably 4430es2panda also fails this
  - Suspend-to-RAM enters full chip retention

Other:

* 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code
  - Jon Hunter and Santosh Shilimkar report this does not appear with
    the same X-loader/bootloader on his 4430ES2.3 Panda, so could be
    ES-level dependent


Failing tests: reported by others 
---------------------------------

- RTC wakeup from suspend broken on 3730beaglexm
  - as of v3.10-rc1
  - discussion here: http://marc.info/?l=linux-omap&m=136915841625434&w=2


vmlinux object size
(delta in bytes from test_v3.10-rc6 
(7d132055814ef17a6c7b69f342244c410a5e000f)):
   text     data      bss    total  kernel
   +969     +600        0    +1569  am33xx_only
   +813        0        0     +813  n800_multi_omap2xxx
   +813        0        0     +813  n800_only_a
   +861       -8        0     +853  omap1_defconfig
   +861        0        0     +861  omap1_defconfig_1510innovator_only
   +861      +24        0     +885  omap1_defconfig_5912osk_only
   +925        0        0     +925  omap2plus_defconfig
   +901        0        0     +901  omap2plus_defconfig_2430sdp_only
   +925        0        0     +925  omap2plus_defconfig_cpupm
 -14807    -1880    -8256   -24943  omap2plus_defconfig_no_pm
   +989        0        0     +989  omap2plus_defconfig_omap2_4_only
   +925        0        0     +925  omap2plus_defconfig_omap3_4_only
   +384        0      -16     +368  rmk_omap3430_ldp_allnoconfig
   +285        0        0     +285  rmk_omap3430_ldp_oldconfig
   +384        0      -16     +368  rmk_omap4430_sdp_allnoconfig
   +257        0        0     +257  rmk_omap4430_sdp_oldconfig

