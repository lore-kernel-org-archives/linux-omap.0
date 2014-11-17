From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc4
Date: Mon, 17 Nov 2014 03:33:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411170331420.3210@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35889 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaKQDdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Nov 2014 22:33:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.18-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc4/20141110160915/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (17/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 3/17): 5912osk, 3517evm, 4430es2panda
    Pass (13/17): am335xbonelt, am335xbone, 4460pandaes, 4460varsomom,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

PM: chip retention via suspend:
    FAIL ( 5/11): am335xbonelt, 4460varsomom, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 6/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/11): am335xbonelt, 4460pandaes, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 5/11): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

PM: chip off via dynamic idle:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm


vmlinux object size
(delta in bytes from test_v3.18-rc3 (0df1f2487d2f0d04703f142813d53615d62a1da4)):
   text     data      bss    total  kernel
   +448        0        0     +448  omap1_defconfig
   +448        0        0     +448  omap1_defconfig_1510innovator_only
   +448        0        0     +448  omap1_defconfig_5912osk_only
  +1175      -88      +64    +1151  multi_v7_defconfig
   +355        0        0     +355  omap2plus_defconfig
   +319        0        0     +319  omap2plus_defconfig_2430sdp_only
   +355       +8        0     +363  omap2plus_defconfig_am33xx_only
   +419       +8        0     +427  omap2plus_defconfig_am43xx_only
   +355      -24        0     +331  omap2plus_defconfig_cpupm
   +351       +8        0     +359  omap2plus_defconfig_dra7xx_only
   +359       +8        0     +367  omap2plus_defconfig_n800_multi_omap2xxx
   +327       +8        0     +335  omap2plus_defconfig_n800_only_a
   +295        0        0     +295  omap2plus_defconfig_no_pm
   +299       +8        0     +307  omap2plus_defconfig_omap2_4_only
   +359       +8        0     +367  omap2plus_defconfig_omap3_4_only
   +351       +8        0     +359  omap2plus_defconfig_omap5_only
   +360      -24      -32     +304  rmk_omap3430_ldp_allnoconfig
   +347       +8        0     +355  rmk_omap3430_ldp_oldconfig
   +316      -20      -24     +272  rmk_omap4430_sdp_allnoconfig
   +371      +16        0     +387  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc3 (0df1f2487d2f0d04703f142813d53615d62a1da4))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

