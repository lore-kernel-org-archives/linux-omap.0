From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.6
Date: Mon, 1 Oct 2012 19:55:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210011923120.2160@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54434 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab2JATzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 15:55:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.6.
Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.6/


Passing tests
-------------

Boot to userspace: 2420n800, 2430sdp, 3530es3beagle, 3730beaglexm, 
                   37xxevm, 4430es2panda, 5912osk

PM ret/off, suspend + dynamic idle: 3530es3beagle, 3730beaglexm


Failing tests: fixed by posted patches
--------------------------------------

PM tests:

* 4430ES2 Panda: UART corruption during long transmit buffers
  - Presumably due to either a missing hardware workaround or a bug in
    the OMAP serial driver
  - Corruption disappears after this series is applied:
    http://www.spinics.net/lists/arm-kernel/msg192995.html
    * Unknown whether these are an actual fix, or just mask the problem

Other:

* RCU stall messages appear if boards are booted into a minimal userspace
  and left to sit for a few minutes
  - Not shown in the current test logs
  - Fixed by http://marc.info/?l=linux-arm-kernel&m=134835120600590&w=2

* 2420N800: powers down 30 seconds after boot
  - Presumably due to missing CBUS patches for watchdog control



Failing tests: needing investigation
------------------------------------

Boot tests:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs               
  - Probably due to the use of NFS root; there are likely some Kconfig,
    board file, and PM issues with EMAC

PM tests:

* 37xx EVM: CORE not entering dynamic off-idle
  - Cause unknown; dynamic retention-idle seems to work; system suspend to 
    off works

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown



Kernel size/memory differences
------------------------------

vmlinux object size
(delta in bytes from test_v3.5 (28a33cbc24e4256c143dce96c7d93bf423229f92)):
  text    data     bss   total  kernel
+106549 +17784   +2380  +126713 2430_testconfig
+38971   +5296    +920  +45187  5912osk_testconfig
+98563  +30344    -316  +128591 am33xx_testconfig
+63542  +14584   +1992  +80118  n800_b_testconfig
+58180  +14808   +1988  +74976  n800_multi_omap2xxx
+39388  +15672   +1960  +57020  n800_testconfig
+49048   +5328    +920  +55296  omap1510_defconfig
+45816   +5264    +952  +52032  omap1_defconfig
+42090  +15360    -156  +57294  omap2_4_testconfig
+121890 +23480   +2884  +148254 omap2plus_defconfig
+125042 +23624   +2884  +151550 omap2plus_defconfig_cpupm
+54593  +21360    -380  +75573  omap2plus_no_pm
+83137  +23760    -316  +106581 omap3_4_testconfig
+55217  +21576   +1036  +77829  omap3_testconfig
+62061  +18840      +4  +80905  omap4_testconfig
+86789  +21608   +1380  +109777 rmk_omap3430_ldp_oldconfig
+96177  -14216    +208  +82169  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.5 (28a33cbc24e4256c143dce96c7d93bf423229f92))
  avail  rsrvd   high  freed  board          kconfig
   -72k    72k      .      .  2420n800       omap2plus_defconfig
  -156k   156k      .     8k  2430sdp        omap2plus_defconfig
  -156k   156k      .      .  3517evm        omap2plus_defconfig
  -156k   156k      .     8k  3530es3beagle  omap2plus_defconfig
  -156k   156k      .     8k  3730beaglexm   omap2plus_defconfig
  -156k   156k      .     8k  37xxevm        omap2plus_defconfig
  -160k   160k      .     8k  4430es2panda   omap2plus_defconfig
   -56k    56k      .     4k  5912osk        omap2plus_defconfig
  -156k   156k      .      .  cmt3517        omap2plus_defconfig


- Paul
