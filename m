From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc4
Date: Mon, 5 Nov 2012 02:46:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2KECqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 21:46:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc4/20121104142910/


Passing tests
-------------

Boot to userspace: 2420n800, 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
                   4430es2panda, 5912osk, am335xbone

PM ret/off, suspend + dynamic idle: (none)


Failing tests: fixed by posted patches
--------------------------------------

Boot tests:

* 2430sdp: vfp_reload_hw oops during MMC initialization
  - Kernel attempts to save FP registers that don't exist; fix posted:
    - http://www.spinics.net/lists/arm-kernel/msg200646.html
    - added to rmk's patch system as 7566/1

* AM335x Beaglebone: omap2plus_defconfig kernels don't boot
  - Due to GPMC missing support for DT
  - Temporary workaround at 
http://www.spinics.net/lists/arm-kernel/msg200787.html
  - May be fixed now, pending retest:
    - http://marc.info/?l=linux-omap&m=135082257727502&w=2
  - Not yet part of the automated test suite
  * May be due to an old U-boot with FDT support problems?

PM tests:

* 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
  - Causes MMC to become unusable since regulators are not reenabled
  - Caused by RT throttling
  - Fixed by http://www.spinics.net/lists/arm-kernel/msg202224.html
  - Patch in rmk's patch system as 7565/1

* 3530es3beagle: hangs during off-mode dynamic idle test
  - Appears to be caused by commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c:
    - http://marc.info/?l=linux-omap&m=135075364705188&w=2
  - Fixed by http://www.spinics.net/lists/arm-kernel/msg202116.html
 
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
  - Appears to be due to X-loader problems here
  - Need to note the X-loader version so we know it's broken

* 3530ES3 Beagle: I2C timeouts during userspace init
  - Intermittent, appears on 5 out of 6 boots here
  - Aaro Koskinen observes this also on N900
  - Appears to be caused by commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
    - http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
    - http://marc.info/?l=linux-omap&m=135197877112220&w=2

PM tests:

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown
  - Pending re-test

Other:

* 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code
  - Jon Hunter reports this does not appear with the same X-loader/bootloader
    on his 4430ES2.3 Panda, so could be ES-level dependent

vmlinux object size
(delta in bytes from test_v3.7-rc3 (8f0d8163b50e01f398b14bcd4dc039ac5ab18d64)):
   text     data      bss    total  kernel
   +750        0        0     +750  am33xx_only
   +208        0        0     +208  n800_multi_omap2xxx
   +208        0        0     +208  n800_only_a
  +2645        0        0    +2645  omap1_defconfig
  +2641        0        0    +2641  omap1_defconfig_1510innovator_only
  +2629        0        0    +2629  omap1_defconfig_5912osk_only
   +738        0        0     +738  omap2plus_defconfig
   +746        0        0     +746  omap2plus_defconfig_2430sdp_only
   +742        0        0     +742  omap2plus_defconfig_cpupm
   +742        0        0     +742  omap2plus_defconfig_no_pm
   +742        0        0     +742  omap2plus_defconfig_omap2_4_only
   +750        0        0     +750  omap2plus_defconfig_omap3_4_only
  +1105        0        0    +1105  rmk_omap3430_ldp_oldconfig
  +1527       +8        0    +1535  rmk_omap4430_sdp_oldconfig

An interesting 2.5KiB jump in OMAP1 kernel size.



- Paul
