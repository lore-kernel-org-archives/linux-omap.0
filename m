From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 02:36:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab2J3Cgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 22:36:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc3/20121028162003/


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
  - Temporary workaround at http://www.spinics.net/lists/arm-kernel/msg200787.html
  - May be fixed now, pending retest:
    - http://marc.info/?l=linux-omap&m=135082257727502&w=2

PM tests:

* 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
  - Causes MMC to become unusable since regulators are not reenabled
  - Caused by RT throttling
  - Fixed by http://www.spinics.net/lists/arm-kernel/msg202224.html
  - Patch in rmk's patch system as 7565/1

* 37xx EVM: CORE not entering dynamic off-idle
  - Dynamic retention-idle seems to work; system suspend to off works
  - Happens on both MMC root and NFS root
  - Can be detected by comparing the CORE off/ret counts from
    /debug/pm_debug/count before & after serial autosuspend occurs
  - Fixed by http://marc.info/?l=linux-arm-kernel&m=135127961519817&w=2

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
(delta in bytes from test_v3.7-rc2 (6f0c0580b70c89094b3422ba81118c7b959c7556)):
   text     data      bss    total  kernel
  +1141      +88      -64    +1165  am33xx_only
  +1037      +32      -48    +1021  n800_multi_omap2xxx
  +1053      +32      -48    +1037  n800_only_a
  +1317      +40        0    +1357  omap1_defconfig
  +1285       +8        0    +1293  omap1_defconfig_1510innovator_only
  +1333      +40        0    +1373  omap1_defconfig_5912osk_only
  +1433      +80      -64    +1449  omap2plus_defconfig
  +1089        0      -32    +1057  omap2plus_defconfig_2430sdp_only
  +1429      +56      -64    +1421  omap2plus_defconfig_cpupm
  +1377      +88        0    +1465  omap2plus_defconfig_no_pm
  +1273      -24        0    +1249  omap2plus_defconfig_omap2_4_only
  +1509        0        0    +1509  omap2plus_defconfig_omap3_4_only
 +17468        0        0   +17468  rmk_omap3430_ldp_oldconfig
  +1033      +56        0    +1089  rmk_omap4430_sdp_oldconfig

The 17k increase in the rmk_omap3430_ldp_oldconfig text appears to be due 
to the automatic selection of CONFIG_PINCTRL by 'make oldnoconfig', new in 
v3.7-rc3.

Boot-time memory difference
(delta in bytes from test_v3.7-rc2 (6f0c0580b70c89094b3422ba81118c7b959c7556))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  5912osk        omap2plus_defconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig


--------------------------------------------------------------

Branch: test_v3.7-rc3
Test-Serial: 20121028162003
Commit-ID: 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64
Test-Target-Board-Count: 11


- Paul
