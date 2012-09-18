From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.6-rc6
Date: Tue, 18 Sep 2012 16:55:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209181653300.4747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54441 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2IRQzv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 12:55:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@vger.kernel.org


Here are some basic OMAP boot and power management test results for 
v3.6-rc6:

   http://www.pwsan.com/omap/testlogs/test_v3.6-rc6/20120918101040/

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

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown

* 4430ES2 Panda: UART corruption during long transmit buffers
  - Presumably due to either a missing hardware workaround or a bug in
    the OMAP serial driver

Changes from v3.6-rc5 (test 20120908202511):
(see http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/ )

- Dropped the line in this README.txt about 4430ES2 retention not working;
  this is expected until some further patch series are merged


object size (delta in bytes from test_v3.6-rc5 (55d512e245bc7699a8800e23df1a24195dd08217)):
  text 	  data 	   bss 	 total 	kernel
 +9633 	   +16 	     0 	 +9649 	2430_testconfig
 +8793 	   +48 	     0 	 +8841 	5912osk_testconfig
 +9901 	 +6120 	 -1280 	+14741 	am33xx_testconfig
 +8580 	   -16 	     0 	 +8564 	n800_b_testconfig
 +8996 	   -16 	     0 	 +8980 	n800_multi_omap2xxx
 +8980 	    +8 	     0 	 +8988 	n800_testconfig
 +8993 	    -8 	     0 	 +8985 	omap1510_defconfig
 +9089 	   +48 	     0 	 +9137 	omap1_defconfig
 +8852 	  -280 	 -1280 	 +7292 	omap2_4_testconfig
+13397 	  -256 	 -1280 	+11861 	omap2plus_defconfig
 +9241 	  -320 	 -1280 	 +7641 	omap2plus_defconfig_cpupm
+10745 	  -136 	 -1280 	 +9329 	omap2plus_no_pm
+10833 	  -224 	 -1216 	 +9393 	omap3_4_testconfig
+11001 	   +64 	     0 	+11065 	omap3_testconfig
+10661 	  -184 	 -1280 	 +9197 	omap4_testconfig
+10785 	 +2344 	     0 	+13129 	rmk_omap3430_ldp_oldconfig
 +5389 	  -208 	 -1280 	 +3901 	rmk_omap4430_sdp_oldconfig


- Paul
