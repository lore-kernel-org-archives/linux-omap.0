From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.16-rc4
Date: Sun, 6 Jul 2014 23:41:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46555 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaGFXlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2014 19:41:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.16-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.16-rc4/20140706150051/


Test summary
------------

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

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

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
(delta in bytes from test_v3.16-rc3 (4c834452aad01531db949414f94f817a86348d59)):
   text     data      bss    total  kernel
   +208      +96        0     +304  omap1_defconfig
   +176      +96        0     +272  omap1_defconfig_1510innovator_only
   +208      +96        0     +304  omap1_defconfig_5912osk_only
  +1648     +776        0    +2424  multi_v7_defconfig
  +4936     +512        0    +5448  omap2plus_defconfig
   +872     +112        0     +984  omap2plus_defconfig_2430sdp_only
  +1036     +128        0    +1164  omap2plus_defconfig_am33xx_only
  +3336     +248        0    +3584  omap2plus_defconfig_am43xx_only
   +840     +576        0    +1416  omap2plus_defconfig_cpupm
   +876     +120        0     +996  omap2plus_defconfig_dra7xx_only
   +336      +80        0     +416  omap2plus_defconfig_n800_multi_omap2xxx
   +368      +88        0     +456  omap2plus_defconfig_n800_only_a
   +840     +448        0    +1288  omap2plus_defconfig_no_pm
   +868      +56        0     +924  omap2plus_defconfig_omap2_4_only
   +932      +56        0     +988  omap2plus_defconfig_omap3_4_only
   +876     +560        0    +1436  omap2plus_defconfig_omap5_only
   +380      +24      -72     +332  rmk_omap3430_ldp_allnoconfig
   +380      +64        0     +444  rmk_omap3430_ldp_oldconfig
    +80       +4      +20     +104  rmk_omap4430_sdp_allnoconfig
   +180      +80        0     +260  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.16-rc3 (4c834452aad01531db949414f94f817a86348d59))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .   404k  4460varsomom   omap2plus_defconfig


After some troubleshooting, it turns out that the reason that the 4460 
VAR-SOM-OM-DVK wasn't booting was that I was missing 'rootwait' on the 
kernel command line. 
