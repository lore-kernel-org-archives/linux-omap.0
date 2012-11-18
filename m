From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc6
Date: Sun, 18 Nov 2012 04:21:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211180421180.22618@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50780 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2KREVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Nov 2012 23:21:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc6/20121117093152/


Passing tests
-------------

Boot to userspace (9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
    3730beaglexm, 37xxevm, 4430es2panda, 5912osk, am335xbone
  
PM ret/off, suspend + dynamic idle (3/4): 3530es3beagle, 3730beaglexm,
    37xxevm


Failing tests: fixed by posted patches
--------------------------------------

Boot tests:

* 3530ES3 Beagle: I2C timeouts during userspace init
  - Intermittent, appears on 5 out of 6 boots here
  - Aaro Koskinen observes this also on N900
  - Appears to be caused by commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
    - http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
    - http://marc.info/?l=linux-omap&m=135197877112220&w=2
  - Revert posted, pending I2C maintainers:
    - http://marc.info/?l=linux-arm-kernel&m=135221953727077&w=2

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

* 4460pandaes: boot fails early
  - Appears to be due to X-loader problems here
  - Need to note the X-loader version so we know it's broken

PM tests:

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown
  - Pending re-test



vmlinux object size
(delta in bytes from test_v3.7-rc5 (77b67063bb6bce6d475e910d3b886a606d0d91f7)):
   text     data      bss    total  kernel
  +1088       +8        0    +1096  am33xx_only
  +4928        0        0    +4928  n800_multi_omap2xxx
   +828       +8        0     +836  n800_only_a
   +932      -24      +32     +940  omap1_defconfig
   +932      -24      +32     +940  omap1_defconfig_1510innovator_only
   +932       +8      +32     +972  omap1_defconfig_5912osk_only
  +1044      +64        0    +1108  omap2plus_defconfig
  +1016        0        0    +1016  omap2plus_defconfig_2430sdp_only
  +1044     +128        0    +1172  omap2plus_defconfig_cpupm
  +1044      +64        0    +1108  omap2plus_defconfig_no_pm
  +1044      +64        0    +1108  omap2plus_defconfig_omap2_4_only
  +1168     +112        0    +1280  omap2plus_defconfig_omap3_4_only
   +760      +40     -396     +404  rmk_omap3430_ldp_allnoconfig
   +984       +8        0     +992  rmk_omap3430_ldp_oldconfig
   +760      +40     -396     +404  rmk_omap4430_sdp_allnoconfig
   +976     +112        0    +1088  rmk_omap4430_sdp_oldconfig



- Paul
