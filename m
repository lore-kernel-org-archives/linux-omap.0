From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.7-rc8
Date: Wed, 5 Dec 2012 19:37:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212051936480.23086@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab2LETh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 14:37:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.7-rc8.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/


Passing tests
-------------

Boot to userspace (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
    3730beaglexm, 37xxevm, 4430es2panda, 5912osk, am335xbone,
    4460pandaes
  
PM ret/off, suspend + dynamic idle (3/4): 3530es3beagle, 3730beaglexm,
    37xxevm


Failing tests: fixed by posted patches
--------------------------------------

Boot tests:

* 3730 Beagle XM: "attempt to access beyond end of device"
  - Not an OMAP-specific problem
  - Should be fixed by http://marc.info/?l=linux-kernel&m=135458657217682&w=2

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

PM tests:

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not yet part of the automated test suite; cause unknown
  - Pending re-test



vmlinux object size
(delta in bytes from test_v3.7-rc7 (9489e9dcae718d5fde988e4a684a0f55b5f94d17)):
   text     data      bss    total  kernel
  -1624        0        0    -1624  am33xx_only
  -1280        0        0    -1280  n800_multi_omap2xxx
  -1264        0        0    -1264  n800_only_a
  -1508        0        0    -1508  omap1_defconfig
  -1492        0        0    -1492  omap1_defconfig_1510innovator_only
  -1524        0        0    -1524  omap1_defconfig_5912osk_only
  -1768        0        0    -1768  omap2plus_defconfig
  -1576        0        0    -1576  omap2plus_defconfig_2430sdp_only
  -1704        0        0    -1704  omap2plus_defconfig_cpupm
  -1704        0        0    -1704  omap2plus_defconfig_no_pm
  -1704        0        0    -1704  omap2plus_defconfig_omap2_4_only
  -1832        0        0    -1832  omap2plus_defconfig_omap3_4_only
  -1244        0      +68    -1176  rmk_omap3430_ldp_allnoconfig
  -1728        0        0    -1728  rmk_omap3430_ldp_oldconfig
  -1244        0      +68    -1176  rmk_omap4430_sdp_allnoconfig
  -1312        0        0    -1312  rmk_omap4430_sdp_oldconfig

