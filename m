From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc1
Date: Sat, 26 Apr 2014 22:37:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404262232100.24168@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49913 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaDZWhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Apr 2014 18:37:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.15-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc1/20140421113253/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: zImage:
    Pass (14/14): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
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

Boot to userspace:
    FAIL ( 1/12): 2430sdp
    skip ( 2/12): 5912osk, cmt3517
    Pass ( 9/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

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
(delta in bytes from test_v3.14 (455c6fdbd219161bd09b1165f11699d6d73de11c)):
   text     data      bss    total  kernel
 +47540    +1904    +4120   +53564  omap1_defconfig
 +48760    +1232    +4152   +54144  omap1_defconfig_1510innovator_only
 +48556    +1328    +4120   +54004  omap1_defconfig_5912osk_only
+336031  +133512    +6112  +475655  multi_v7_defconfig
 +30722   +11392    +4312   +46426  omap2plus_defconfig
 +83096    +9344    +7512   +99952  omap2plus_defconfig_2430sdp_only
+317069   +13808   +29040  +359917  omap2plus_defconfig_am33xx_only
+256147   +12688   +29040  +297875  omap2plus_defconfig_am43xx_only
 +31521   +11464    +4376   +47361  omap2plus_defconfig_cpupm
 +18233    +1520    +4440   +24193  omap2plus_defconfig_dra7xx_only
 +41982    -2880    +4532   +43634  omap2plus_defconfig_n800_multi_omap2xxx
 +45678    -2800    +4532   +47410  omap2plus_defconfig_n800_only_a
 +28802   +11856    +4312   +44970  omap2plus_defconfig_no_pm
 -53331   -86096     +664  -138763  omap2plus_defconfig_omap2_4_only
 -59700   -86624    +1112  -145212  omap2plus_defconfig_omap3_4_only
 +21025    +1536    +4376   +26937  omap2plus_defconfig_omap5_only
 +26068     -864    +7928   +33132  rmk_omap3430_ldp_allnoconfig
 +58468    -2968    +4584   +60084  rmk_omap3430_ldp_oldconfig
 +19892    -3092    +4664   +21464  rmk_omap4430_sdp_allnoconfig
 +61177    -3416    +4480   +62241  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.14 (455c6fdbd219161bd09b1165f11699d6d73de11c))
  avail  rsrvd   high  freed  board          kconfig
   -64k    64k      .     4k  2420n800       omap2plus_defconfig_n800_only_a
   -64k    64k      .      .  2430sdp        omap2plus_defconfig
  -148k   148k      .     4k  3517evm        omap2plus_defconfig
  -172k   172k      .     4k  3530es3beagle  omap2plus_defconfig
  -176k   176k      .     4k  3730beaglexm   omap2plus_defconfig
  -168k   168k      .     4k  37xxevm        omap2plus_defconfig
  -160k   160k      .     4k  4430es2panda   omap2plus_defconfig
  -160k   160k      .     4k  4460pandaes    omap2plus_defconfig
  -148k   148k      .     4k  4460varsomom   omap2plus_defconfig
  -408k   408k      .    32k  am335xbone     omap2plus_defconfig_am33xx_only


The ~400KB runtime memory bloat for AM335x is quite a bit beyond the usual 
~150KB per-release bloat.  It's probably worth someone's time to figure 
out what happened here. 
