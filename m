From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc2
Date: Sat, 20 Oct 2012 21:26:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53883 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2JTV0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 17:26:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/


Passing tests
-------------

Boot to userspace: 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
                   4430es2panda, 5912osk, am335xbone

PM ret/off, suspend + dynamic idle: (none)


Failing tests: fixed by posted patches
--------------------------------------

Boot tests:

* 2430sdp: vfp_reload_hw oops during MMC initialization
  - Kernel attempts to save FP registers that don't exist; fix posted:
    - http://www.spinics.net/lists/arm-kernel/msg200646.html

* 2420n800: boot hangs during UART initialization
  - http://lkml.org/lkml/2012/9/11/454
  - Apparently fixed by http://marc.info/?l=linux-omap&m=135068547918479&w=2

* AM335x Beaglebone: omap2plus_defconfig kernels don't boot
  - due to a GPMC bug
  - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265

* 4430es2panda: omap_hwmod: mcpdm: cannot be enabled for reset (3)
  - clock source is from an external I2C-controlled source
  - must skip reset until the switchover to hwmod late init 
  - http://www.spinics.net/lists/arm-kernel/msg178138.html


Failing tests: needing investigation
------------------------------------

Boot tests:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC

* CM-T3517: boot hangs with MMC boot
  - Due to missing MMC setup in board file

* 4460pandaes: boot fails early
  - Appears to be timer-related

* 3530ES3 Beagle: I2C timeouts during userspace init
  - Intermittent, appears on 5 out of 6 boots here
  - Aaro Koskinen observes this also on N900
  - Appears to be caused by commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
    - http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2

PM tests:

* 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
  - Causes MMC to become unusable since regulators are not reenabled
  - Can be worked around by reverting the I2C driver conversion to
    threaded IRQs:
    - http://marc.info/?l=linux-i2c&m=135026587102887&w=2
  - Appears to be due to either an accounting or clocksource problem;
    under discussion:
    - http://marc.info/?l=linux-arm-kernel&m=135042360725821&w=2
    - http://marc.info/?l=linux-arm-kernel&m=135066462211056&w=2

* 3530es3beagle: hangs during off-mode dynamic idle test
  - Appears to be caused by commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c:
    - http://marc.info/?l=linux-omap&m=135075364705188&w=2

* 37xx EVM: CORE not entering dynamic off-idle
  - Cause unknown; dynamic retention-idle seems to work; system suspend to 
    off works

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown

* 3730 Beagle XM: OPPs do not initialize
  - Several "find_device_opp: Invalid parameters" messages appear on boot; 
    related warnings follow
  - Appears to be caused by commit 24d7b40a60cf19008334bcbcbd98da374d4d9c64
    - http://marc.info/?l=linux-omap&m=135071425527076&w=2

Other:

* 4430es2panda:	omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code



- Paul

