From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc5
Date: Thu, 17 Jul 2014 18:25:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407171819540.22427@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34090 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaGQS0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 14:26:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, tony@atomide.com

Here are some basic OMAP test results for Linux v3.16-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc5/20140716140950/


Test summary
------------

Build: zImage:
    Pass (16/16): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_dra7xx_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (10/10): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap5-uevm

Boot to userspace:
    FAIL ( 1/14): 2430sdp
    skip ( 1/14): 5912osk
    Pass (12/14): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
		  4430es2panda, 4460pandaes, 4460varsomom

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom


vmlinux object size
(delta in bytes from test_v3.16-rc4 (cd3de83f147601356395b57a8673e9c5ff1e59d1)):
   text     data      bss    total  kernel
   +160        0        0     +160  omap1_defconfig
   +192        0        0     +192  omap1_defconfig_1510innovator_only
   +160        0        0     +160  omap1_defconfig_5912osk_only
  +1044     -160        0     +884  multi_v7_defconfig
   +284      +16        0     +300  omap2plus_defconfig
   +284       +8        0     +292  omap2plus_defconfig_2430sdp_only
   +284       +8        0     +292  omap2plus_defconfig_am33xx_only
   +524     +192        0     +716  omap2plus_defconfig_am43xx_only
   +348      -16        0     +332  omap2plus_defconfig_cpupm
   +284       +8        0     +292  omap2plus_defconfig_dra7xx_only
   +172        0        0     +172  omap2plus_defconfig_n800_multi_omap2xxx
   +140       -8        0     +132  omap2plus_defconfig_n800_only_a
   +348      +16        0     +364  omap2plus_defconfig_no_pm
   +348      -16        0     +332  omap2plus_defconfig_omap2_4_only
   +348      +16        0     +364  omap2plus_defconfig_omap3_4_only
   +284      +16        0     +300  omap2plus_defconfig_omap5_only
   +216        0      -16     +200  rmk_omap3430_ldp_allnoconfig
   +160        0        0     +160  rmk_omap3430_ldp_oldconfig
   +184        0      -16     +168  rmk_omap4430_sdp_allnoconfig
   +168       -8        0     +160  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc4 (cd3de83f147601356395b57a8673e9c5ff1e59d1))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


Two bugs were fixed in the PM testing scripts for this test. One of them 
prevented UART wakeups from being enabled.  The other caused off-mode test 
results to not be reported if retention test results failed.  (Thanks to 
Tony for prompting me to closely review the test scripts here and fix 
them.)  After fixing these, suspend/resume power management, including 
both retention and off-idle, now appears to be working for OMAP37xx-series 
chips.  Dynamic PM idle entry still appears broken, as does PM for 
OMAP35xx-series chips and OMAP4 chips.

