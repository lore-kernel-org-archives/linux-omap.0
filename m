From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.14-rc1
Date: Mon, 10 Feb 2014 17:48:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54490 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbaBJRs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 12:48:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.14-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.14-rc1/20140210035354/


Test summary
------------

Build: uImage+dtb:
    Pass ( 9/ 9): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: zImage:
    Pass (13/13): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 1/10): 2430sdp
    skip ( 2/ 2): 5912osk, cmt3517
    Pass ( 9/10): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  4460varsomom

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.13 (d8ec26d7f8287f5788a494f56e8814210f0e64be)):
   text     data      bss    total  kernel
 +39941     +888     +640   +41469  omap1_defconfig
 +38701     +816     +608   +40125  omap1_defconfig_1510innovator_only
 +38949     +816     +640   +40405  omap1_defconfig_5912osk_only
 +94801   -17448    -9016   +68337  omap2plus_defconfig
+7161037  +361508  +5611136  +13133681  omap2plus_defconfig_2430sdp_only
+101806    +1712    -9144   +94374  omap2plus_defconfig_am33xx_only
+7641123  +429388  +5621344  +13691855  omap2plus_defconfig_am43xx_only
+8210228  +771260  +5651768  +14633256  omap2plus_defconfig_cpupm
+7889789  +453764  +5649080  +13992633  omap2plus_defconfig_dra7xx_only
+3431616  +268188  +5360432  +9060236  omap2plus_defconfig_n800_multi_omap2xxx
+3400380  +241748  +5360424  +9002552  omap2plus_defconfig_n800_only_a
+8094759  +758028  +5642680  +14495467  omap2plus_defconfig_no_pm
+8073679  +611084  +5650040  +14334803  omap2plus_defconfig_omap2_4_only
+8120107  +707676  +5651192  +14478975  omap2plus_defconfig_omap3_4_only
+7886749  +445660  +5649144  +13981553  omap2plus_defconfig_omap5_only
+2117724  +247972  +182980  +2548676  rmk_omap3430_ldp_allnoconfig
+4906713  +344676  +5360616  +10612005  rmk_omap3430_ldp_oldconfig
+2085088  +163420  +183428  +2431936  rmk_omap4430_sdp_allnoconfig
+5408423  +278900  +5392280  +11079603  rmk_omap4430_sdp_oldconfig


Boot-time memory difference
(delta in bytes from test_v3.13 (d8ec26d7f8287f5788a494f56e8814210f0e64be))
  avail  rsrvd   high  freed  board          kconfig
   -32k    32k      .    -8k  2420n800       omap2plus_defconfig_n800_only_a
   -88k    88k      .  -384k  2430sdp        omap2plus_defconfig
  -188k   188k      .      .  3517evm        omap2plus_defconfig
  -220k   220k      .      .  3530es3beagle  omap2plus_defconfig
  -220k   220k      .      .  3730beaglexm   omap2plus_defconfig
  -180k   180k      .      .  37xxevm        omap2plus_defconfig
  -144k   144k      .      .  4430es2panda   omap2plus_defconfig
  -144k   144k      .      .  4460pandaes    omap2plus_defconfig
  -116k   116k      .    12k  am335xbone     omap2plus_defconfig_am33xx_only
   -88k    88k      .      .  am335xbonelt   omap2plus_defconfig


The large vmlinux size deltas are due to the OMAP2+ shift from uImage 
builds to zImage builds.  The script here doesn't track size differences 
across kernel build formats, so to that script, it appears that the builds 
just started working.

Full-chip power management for OMAP3 is now clearly broken.  Folks who 
need that for their application should use older kernels.  Recollection is 
foggy but v3.7 should be pretty good for OMAP3; the clock code & data in 
that one is a bit more mature.

The good news is that the 4460 VAR-SOM-OM is now booting again.  Removed 
the LCD board, which got rid of the noise on the serial line - must have 
been leaking through from the inverter.  Also switched serial interfaces.  
Clearly this needs a bit more investigation.  

Looks like the kernel runtime memory bloat trend has resumed.

