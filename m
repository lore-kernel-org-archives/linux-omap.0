From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.10-rc6
Date: Mon, 17 Jun 2013 05:23:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56632 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3FQFXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 01:23:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.10-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.10-rc6/20130616211951/


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
    FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt
    Pass ( 9/12): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
                  3730beaglexm, 4430es2panda, 4460pandaes, 5912osk,
                  cmt3517

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
  
* 2430SDP, 3730 Beagle XM, 3530 Beagle, 3517EVM, CM-T3517: {dmic,mcpdm} lookup failure
  - Cause unknown
  - These IP blocks don't exist on OMAP3xxx/AM35xx chips
  - Fixed by http://marc.info/?l=linux-omap&m=137093955903130&w=2


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
(delta in bytes from test_v3.10-rc5 
(317ddd256b9c24b0d78fa8018f80f1e495481a10)):
   text     data      bss    total  kernel
   +673      +56        0     +729  am33xx_only
   +444       +8        0     +452  n800_multi_omap2xxx
   +412       +8        0     +420  n800_only_a
   +808      +32        0     +840  omap1_defconfig
   +776      +24        0     +800  omap1_defconfig_1510innovator_only
   +808      +64        0     +872  omap1_defconfig_5912osk_only
   +537      +56        0     +593  omap2plus_defconfig
   +768      -24        0     +744  omap2plus_defconfig_2430sdp_only
   +537      +56        0     +593  omap2plus_defconfig_cpupm
   +613       -8        0     +605  omap2plus_defconfig_no_pm
   +545      -24        0     +521  omap2plus_defconfig_omap2_4_only
   +537      +56        0     +593  omap2plus_defconfig_omap3_4_only
   +440       -8      -64     +368  rmk_omap3430_ldp_allnoconfig
   +476      +72        0     +548  rmk_omap3430_ldp_oldconfig
   +440       -8      -64     +368  rmk_omap4430_sdp_allnoconfig
   +665     +168        0     +833  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.10-rc5 
(317ddd256b9c24b0d78fa8018f80f1e495481a10))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2420n800       n800_only_a

