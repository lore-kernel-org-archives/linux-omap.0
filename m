From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc1
Date: Thu, 18 Oct 2012 05:20:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2JRFUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 01:20:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc1.
Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/


Changes from previous tests
---------------------------

Kernel configs have been reorganized and updated.  AM335x Beaglebone and
OMAP4460 Pandaboard-ES boards have been added to the testbed.


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

Other:

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control
  - http://lkml.org/lkml/2012/9/3/265



Failing tests: needing investigation
------------------------------------

Boot tests:

* 2420n800: boot hangs during UART initialization
  - http://lkml.org/lkml/2012/9/11/454
  - Various attempts at fixes posted; etiology known; issue still unresolved

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC

* CM-T3517: boot hangs with MMC boot
  - Due to missing MMC setup in board file

PM tests:

* 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
  - Causes MMC to become unusable since regulators are not reenabled
  - Can be worked around by reverting the I2C driver conversion to
    threaded IRQs:
    - http://marc.info/?l=linux-i2c&m=135026587102887&w=2
  - Appears to be due to an accounting problem; under discussion:
    - http://marc.info/?l=linux-arm-kernel&m=135042360725821&w=2

* 3530es3beagle: hangs during off-mode dynamic idle test
  - Unknown cause; not investigated

* 37xx EVM: CORE not entering dynamic off-idle
  - Cause unknown; dynamic retention-idle seems to work; system suspend to 
    off works

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown


Kernel size/memory differences
------------------------------

vmlinux object size
(delta in bytes from test_v3.6 (a0d271cbfed1dd50278c6b06bead3d00ba0a88f9)):
   text     data      bss    total  kernel
+118682   -66688    +2280   +54274  am33xx_only
 +57789   -88928    +2148   -28991  n800_multi_omap2xxx
 +58669   -86432    +2180   -25583  n800_only_a
 +54196    +4616     -136   +58676  omap1_defconfig
 +53420    +3096     -104   +56412  omap1_defconfig_1510innovator_only
 +54384    +3112     -168   +57328  omap1_defconfig_5912osk_only
+128332   -67728    +2144   +62748  omap2plus_defconfig
+106894   -83664    +1992   +25222  omap2plus_defconfig_2430sdp_only
+128296   -67744    +2080   +62632  omap2plus_defconfig_cpupm
+130151   -67552    +1824   +64423  omap2plus_defconfig_no_pm
+107810   -88848    +1952   +20914  omap2plus_defconfig_omap2_4_only
+107293   -88232    +2016   +21077  omap2plus_defconfig_omap3_4_only
+113921   -66976    +2348   +49293  rmk_omap3430_ldp_oldconfig
+106849   -47216    +2760   +62393  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.6 (a0d271cbfed1dd50278c6b06bead3d00ba0a88f9))
  avail  rsrvd   high  freed  board          kconfig
    20k   -20k      .  -152k  2420n800       omap2plus_defconfig
   -60k    60k      .     4k  2430sdp        omap2plus_defconfig
   -60k    60k      .     4k  3517evm        omap2plus_defconfig
   -60k    60k      .     4k  3530es3beagle  omap2plus_defconfig
   -60k    60k      .     4k  3730beaglexm   omap2plus_defconfig
   -60k    60k      .     4k  37xxevm        omap2plus_defconfig
   -60k    60k      .     4k  4430es2panda   omap2plus_defconfig
   -52k    52k      .      .  5912osk        omap2plus_defconfig
   -60k    60k      .      .  cmt3517        omap2plus_defconfig


- Paul


