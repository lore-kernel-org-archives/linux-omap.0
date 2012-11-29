From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc7
Date: Thu, 29 Nov 2012 10:38:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211291036270.20529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43051 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2K2Kic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 05:38:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc7/20121127152704/


Passing tests
-------------

Boot to userspace (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
    3730beaglexm, 37xxevm, 4430es2panda, 5912osk, am335xbone,
    4460pandaes
  
PM ret/off, suspend + dynamic idle (3/4): 3530es3beagle, 3730beaglexm,
    37xxevm


Failing tests: fixed by posted patches
--------------------------------------

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265
  - http://marc.info/?l=linux-omap&m=135274739624125&w=2


Failing tests: needing investigation
------------------------------------

Boot tests:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC

* CM-T3517: boot hangs with MMC root
  - Due to missing MMC setup in board file

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

* 4460pandaes: boot to login prompt doesn't complete
  - May be due to root filesystem problems here

PM tests:

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown
  - Pending re-test



vmlinux object size
(delta in bytes from test_v3.7-rc6 
(f4a75d2eb7b1e2206094b901be09adb31ba63681)):
   text     data      bss    total  kernel
  +1147      +56       +8    +1211  am33xx_only
  +1223       +8        0    +1231  n800_multi_omap2xxx
  +1191      +32        0    +1223  n800_only_a
  +1499      +48        0    +1547  omap1_defconfig
  +1539      +24        0    +1563  omap1_defconfig_1510innovator_only
  +1535       -8      +32    +1559  omap1_defconfig_5912osk_only
  +1179      +48        0    +1227  omap2plus_defconfig
  +1063      +16       +8    +1087  omap2plus_defconfig_2430sdp_only
  +1115      -16        0    +1099  omap2plus_defconfig_cpupm
  +1179      -16      +64    +1227  omap2plus_defconfig_no_pm
  +1051       -8      +64    +1107  omap2plus_defconfig_omap2_4_only
  +1171        0        0    +1171  omap2plus_defconfig_omap3_4_only
    +96      +16      -36      +76  rmk_omap3430_ldp_allnoconfig
  +1307      +72        0    +1379  rmk_omap3430_ldp_oldconfig
    +96      +16      -36      +76  rmk_omap4430_sdp_allnoconfig
   +100      +24        0     +124  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.7-rc6 
(f4a75d2eb7b1e2206094b901be09adb31ba63681))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2430sdp        omap2plus_defconfig
    -4k     4k      .      .  3517evm        omap2plus_defconfig
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -4k     4k      .      .  3730beaglexm   omap2plus_defconfig
    -4k     4k      .      .  37xxevm        omap2plus_defconfig
    -4k     4k      .      .  4430es2panda   omap2plus_defconfig
    -4k     4k      .      .  cmt3517        omap2plus_defconfig
