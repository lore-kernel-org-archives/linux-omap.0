From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.6-rc5
Date: Sun, 9 Sep 2012 17:56:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab2IIR4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Sep 2012 13:56:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>, grinberg@compulab.co.il


Here are some basic OMAP boot and power management test results for 
v3.6-rc5:

   http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/

Some observations:

Boot tests:

* CM-T3517: L3 in-band error with USB OTG during boot
  - Cause unknown; longstanding issue; does not occur on the 3517EVM

* 3517EVM & CM-T3517: boot hangs
  - Probably due to the use of NFS root; there are likely some Kconfig, 
    board file, and PM issues with EMAC

PM tests:

* 37xx EVM: CORE not entering dynamic off-idle
  - Cause unknown; dynamic retention-idle seems to work; system suspend to 
    off works

* 4430ES2 Panda: UART corruption during long transmit buffers
  - Presumably due to either a missing hardware workaround or a bug in
    the OMAP serial driver

* 4430ES2 Panda: CORE, L4PER, L3INIT, TESLA, IVAHD not going idle
  - Cause unknown; may be partially due to McPDM reset problem


Changes from v3.6-rc4 (test 20120904122415):
(see http://www.pwsan.com/omap/testlogs/test_v3.6-rc4/20120904122415/ )

- N800 no longer panics on boot

- Kernel command line changed for PM tests; 'debug ignore_loglevel' no
  longer specified.  This allows UART clock gating on OMAP4, but does
  not seem to affect OMAP3 (!).  During test 20120904122415, this
  masked the UART transmit data corruption problem that was seen on
  previous tests, e.g.
  http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/pm/4430es2panda_log.txt

- OMAP4 UART transmit buffer corruption visible again, due to the
  above change.

- 3730 Beagle XM added back into to boot & PM testbed.

- Kernel configs are now included in the test report tree under the 
  build/kernels directory (thanks to Andreas for the suggestion)


object size (delta in bytes from test_v3.6-rc4 (4cbe5a555fa58a79b6ecbb6c531b8bab0650778d)):
  text 	  data 	   bss 	 total 	kernel
  +364 	   -16 	     0 	  +348 	2430_testconfig
  +308 	   -16 	     0 	  +292 	5912osk_testconfig
  +304 	   -16 	     0 	  +288 	am33xx_testconfig
  +260 	    -8 	     0 	  +252 	n800_b_testconfig
  +260 	   +24 	     0 	  +284 	n800_multi_omap2xxx
  +276 	     0 	     0 	  +276 	n800_testconfig
  +192 	   +16 	     0 	  +208 	omap1510_defconfig
  +192 	   -16 	     0 	  +176 	omap1_defconfig
  +308 	     0 	     0 	  +308 	omap2_4_testconfig
  +300 	   -16 	     0 	  +284 	omap2plus_defconfig
  +300 	    -8 	     0 	  +292 	omap2plus_no_pm
  +364 	   +16 	     0 	  +380 	omap3_4_testconfig
  +300 	   +16 	     0 	  +316 	omap3_testconfig
  +364 	    -8 	     0 	  +356 	omap4_testconfig
  +304 	   +16 	     0 	  +320 	rmk_omap3430_ldp_oldconfig
  +244 	   +16 	     0 	  +260 	rmk_omap4430_sdp_oldconfig


- Paul
