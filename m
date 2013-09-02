From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11
Date: Mon, 2 Sep 2013 23:31:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309022330350.4234@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58975 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab3IBXbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Sep 2013 19:31:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.11.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11/20130902150604/


Test summary
------------

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Build: uImage:
    Pass (14/14): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
		  omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Build: uImage+dtb:
    Pass ( 3/ 3): am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    FAIL ( 2/ 6): 2430sdp, 4430es2panda
    Pass ( 4/ 6): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 3/ 6): 2430sdp, 4430es2panda, 4460pandaes
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 4430es2panda, 4460pandaes
    Pass ( 2/ 4): 3530es3beagle, 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 4430es2panda, 4460pandaes
    Pass ( 2/ 4): 3530es3beagle, 37xxevm


vmlinux object size
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
   text     data      bss    total  kernel
    +56        0        0      +56  n800_multi_omap2xxx
    +56        0        0      +56  n800_only_a
   +849       +8        0     +857  omap1_defconfig
   +785       +8        0     +793  omap1_defconfig_1510innovator_only
   +817      +16        0     +833  omap1_defconfig_5912osk_only
   +633      -24        0     +609  omap2plus_defconfig
   +625       +8        0     +633  omap2plus_defconfig_2430sdp_only
   +633      -24        0     +609  omap2plus_defconfig_cpupm
   +633       +8        0     +641  omap2plus_defconfig_no_pm
   +633       +8        0     +641  omap2plus_defconfig_omap2_4_only
   +697      -24        0     +673  omap2plus_defconfig_omap3_4_only
   +236        0      +20     +256  rmk_omap3430_ldp_allnoconfig
   +341       +8        0     +349  rmk_omap3430_ldp_oldconfig
   +228        0      +28     +256  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

