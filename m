From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc7 (corrected)
Date: Wed, 28 May 2014 19:10:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405281907410.1280@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405271657050.28436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42985 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbaE1TKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 15:10:15 -0400
In-Reply-To: <alpine.DEB.2.02.1405271657050.28436@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, aaro.koskinen@iki.fi


Here are some basic OMAP test results for Linux v3.15-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc7/20140528121000/


Test summary
------------

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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Boot to userspace:
    FAIL ( 2/13): 2430sdp, cmt3517
    skip ( 2/13): 5912osk, 4460varsomom
    Pass ( 9/13): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt

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
(delta in bytes from test_v3.15-rc6 (4b660a7f5c8099d88d1a43d8ae138965112592c7)):
   text     data      bss    total  kernel
  +2145     +136      -64    +2217  omap1_defconfig
  +2177     +104      -64    +2217  omap1_defconfig_1510innovator_only
  +2177     +104      -64    +2217  omap1_defconfig_5912osk_only
  +6097     +160     -144    +6113  multi_v7_defconfig
  +6445      +32      -56    +6421  omap2plus_defconfig
  +2125      +64      -40    +2149  omap2plus_defconfig_2430sdp_only
  +2293      +32      -56    +2269  omap2plus_defconfig_am33xx_only
  +2361      +32      -56    +2337  omap2plus_defconfig_am43xx_only
  +2349      +32      -56    +2325  omap2plus_defconfig_cpupm
  +2425      +32      -56    +2401  omap2plus_defconfig_dra7xx_only
   +144      +64        0     +208  omap2plus_defconfig_n800_multi_omap2xxx
   +144      +64        0     +208  omap2plus_defconfig_n800_only_a
  +2349        0      -56    +2293  omap2plus_defconfig_no_pm
  +6513      +32      -56    +6489  omap2plus_defconfig_omap2_4_only
  +2361      +32      -56    +2337  omap2plus_defconfig_omap3_4_only
  +2361      +32      -56    +2337  omap2plus_defconfig_omap5_only
    +96        0        0      +96  rmk_omap3430_ldp_allnoconfig
  +2061      +88      -64    +2085  rmk_omap3430_ldp_oldconfig
    +96        0        0      +96  rmk_omap4430_sdp_allnoconfig
  +2422     +112      -56    +2478  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc6 (4b660a7f5c8099d88d1a43d8ae138965112592c7))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .     4k  3517evm        omap2plus_defconfig
    -8k     8k      .     4k  3530es3beagle  omap2plus_defconfig
    -8k     8k      .     4k  3730beaglexm   omap2plus_defconfig
    -8k     8k      .     4k  37xxevm        omap2plus_defconfig
    -8k     8k      .     4k  4430es2panda   omap2plus_defconfig
    -8k     8k      .     4k  4460pandaes    omap2plus_defconfig

Aaro Koskinen's sharp eyes pointed out that 2420n800 test results weren't 
being summarized in the header of these test reports.  This has been now 
fixed. 

As I was looking into what he pointed out, I discovered also that the 
previous v3.15-rc7 test report was broken - it tested v3.15-rc6 instead - 
hence the zero-byte differences in the vmlinux object sizes.  This has 
been corrected in this report, which does in fact test v3.15-rc7.
