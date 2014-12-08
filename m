From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18
Date: Mon, 8 Dec 2014 23:24:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412082323001.31750@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42658 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaLHXYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2014 18:24:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Here are some basic OMAP test results for Linux v3.18.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18/20141208144211/


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
    skip ( 2/17): 5912osk, 3517evm
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 7/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 5/12): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
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
(delta in bytes from test_v3.18-rc7 (009d0431c3914de64666bec0d350e54fdd59df6a)):
   text     data      bss    total  kernel
     -7        0        0       -7  omap1_defconfig
    +57        0        0      +57  omap1_defconfig_1510innovator_only
     -7        0        0       -7  omap1_defconfig_5912osk_only
    -87       -8        0      -95  multi_v7_defconfig
    -59       -8        0      -67  omap2plus_defconfig
    -91      -16        0     -107  omap2plus_defconfig_2430sdp_only
   -123       -8        0     -131  omap2plus_defconfig_am33xx_only
    -63      -16        0      -79  omap2plus_defconfig_am43xx_only
    -59      +16        0      -43  omap2plus_defconfig_cpupm
   -127       -8        0     -135  omap2plus_defconfig_dra7xx_only
    -67      -16        0      -83  omap2plus_defconfig_n800_multi_omap2xxx
    -35      -16        0      -51  omap2plus_defconfig_n800_only_a
   -123      +24        0      -99  omap2plus_defconfig_no_pm
    -59      +16        0      -43  omap2plus_defconfig_omap2_4_only
   -123      -16        0     -139  omap2plus_defconfig_omap3_4_only
    -63      -16        0      -79  omap2plus_defconfig_omap5_only
   -132      -16      +16     -132  rmk_omap3430_ldp_allnoconfig
   -103       +8        0      -95  rmk_omap3430_ldp_oldconfig
   -132      -12      +16     -128  rmk_omap4430_sdp_allnoconfig
  +3993       +8        0    +4001  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc7 (009d0431c3914de64666bec0d350e54fdd59df6a))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

