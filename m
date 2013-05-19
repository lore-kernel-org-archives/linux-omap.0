From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc1
Date: Sun, 19 May 2013 22:29:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305192159080.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43871 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab3ESW3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 May 2013 18:29:41 -0400
In-Reply-To: <alpine.DEB.2.00.1305192159080.2656@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Looks like a few messages were missed, so here's an updated version, along 
with the size data.

- Paul


Here are some basic OMAP test results for Linux v3.10-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.10-rc1/20130518212204/


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
    FAIL ( 6/12): 2430sdp, 3517evm, 37xxevm, am335xbone, am335xbonelt, cmt3517
    Pass ( 6/12): 2420n800, 3530es3beagle, 3730beaglexm, 4430es2panda,
                  4460pandaes, 5912osk

PM: chip retention via suspend:
    FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
    Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

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

Boot:

* ARMv6 OMAPs don't boot with omap2plus_defconfig
  - missing Kconfig 
  - http://marc.info/?l=linux-omap&m=136872761502689&w=2

* 3517EVM & CM-T3517: boot hangs with MMC root
  - Possibly fixed by https://lkml.org/lkml/2013/5/5/6


Failing tests: needing investigation
------------------------------------

Boot tests:

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug
  - Not currently part of the automated test suite

* 37xx EVM: boot fails
  - Cause unknown

Boot warnings:

* 2420N800: failed to get counter_32k resource
  - "omap2_sync32k_clocksource_init: failed to get counter_32k resource"
  - Cause unknown

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3730 Beagle XM, 3530 Beagle, 3517EVM, CM-T3517: {dmic,mcpdm} lookup failure
  - Cause unknown
  - These IP blocks don't exist on OMAP3xxx/AM35xx chips

* 3730 Beagle XM, am335xbone, CM-T3517: uart4_rx.uart4_rx mux failure
  - Cause unknown

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

vmlinux object size
(delta in bytes from test_v3.9 
(c1be5a5b1b355d40e6cf79cc979eb66dafa24ad1)):
   text     data      bss    total  kernel
+7698786  +424812  +5648088  +13771686  am33xx_only
 -18104   -20920     +684   -38340  n800_multi_omap2xxx
 -13776   -20896     +716   -33956  n800_only_a
 +61099    +2064   +41912  +105075  omap1_defconfig
 +61586    +2016   +41912  +105514  omap1_defconfig_1510innovator_only
 +56576    +1896   +41976  +100448  omap1_defconfig_5912osk_only
 -59854   -98552   +37136  -121270  omap2plus_defconfig
+7419117  +402860  +5622032  +13444009  omap2plus_defconfig_2430sdp_only
 -58570   -98248   +37136  -119682  omap2plus_defconfig_cpupm
 -60068   -96504   +37072  -119500  omap2plus_defconfig_no_pm
 +17627   -16936   +37328   +38019  omap2plus_defconfig_omap2_4_only
 +13196   -20536   +37200   +29860  omap2plus_defconfig_omap3_4_only
 -37304   -74116     +476  -110944  rmk_omap3430_ldp_allnoconfig
 +26264   -15928   +37568   +47904  rmk_omap3430_ldp_oldconfig
 -37304   -74116     +476  -110944  rmk_omap4430_sdp_allnoconfig
 +29503    -8576    +9400   +30327  rmk_omap4430_sdp_oldconfig

am33xx_only and omap2plus_defconfig_2430sdp_only kernel didn't build 
during the v3.9 series.

Good to see that the kernel size has decreased for omap2plus_defconfig.  
Hopefully most of this will remain after ARMv6 support is re-enabled.  
Unfortunately kernel size has increased considerably for 
omap1plus_defconfig.


Boot-time memory difference
(delta in bytes from test_v3.9 
(c1be5a5b1b355d40e6cf79cc979eb66dafa24ad1))
  avail  rsrvd   high  freed  board          kconfig
    44k   -44k      .  -144k  2420n800       n800_only_a
   120k  -120k      .  -340k  3517evm        omap2plus_defconfig
   120k  -120k      .  -340k  3530es3beagle  omap2plus_defconfig
   120k  -120k      .  -340k  3730beaglexm   omap2plus_defconfig
   120k  -120k      .  -340k  4430es2panda   omap2plus_defconfig
   120k  -120k      .  -340k  4460pandaes    omap2plus_defconfig
  -108k   108k      .  -172k  5912osk        omap1_defconfig

