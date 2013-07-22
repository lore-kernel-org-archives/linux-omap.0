From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for Linux v3.11-rc2
Date: Mon, 22 Jul 2013 04:01:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307220400260.4804@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42069 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3GVEB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 00:01:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.11-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc2/20130721203314/


Test summary
------------

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

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Boot to userspace:
    FAIL ( 5/11): 2430sdp, 3530es3beagle, 3730beaglexm, 5912osk,
		  am335xbonelt
    Pass ( 6/11): 3517evm, 37xxevm, 4430es2panda, 4460pandaes,
		  am335xbone, cmt3517

PM: chip retention via suspend:
    FAIL ( 4/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda
    Pass ( 2/ 6): 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 6): 2430sdp, 3530es3beagle, 3730beaglexm, 4430es2panda,
		  4460pandaes
    Pass ( 1/ 6): 37xxevm

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 3530es3beagle, 4430es2panda, 4460pandaes
    Pass ( 1/ 4): 37xxevm


vmlinux object size
(delta in bytes from test_v3.11-rc1 (ad81f0545ef01ea651886dddac4bef6cec930092)):
   text     data      bss    total  kernel
   +658     +320        0     +978  am33xx_only
   +350     +192        0     +542  n800_multi_omap2xxx
   +318     +192        0     +510  n800_only_a
   +490     +192        0     +682  omap1_defconfig
   +554     +224        0     +778  omap1_defconfig_1510innovator_only
   +490     +192        0     +682  omap1_defconfig_5912osk_only
   +670     +320        0     +990  omap2plus_defconfig
  +4834     +320        0    +5154  omap2plus_defconfig_2430sdp_only
   +618     +384        0    +1002  omap2plus_defconfig_cpupm
   +670     +256        0     +926  omap2plus_defconfig_no_pm
   +670     +320        0     +990  omap2plus_defconfig_omap2_4_only
   +670     +320        0     +990  omap2plus_defconfig_omap3_4_only
   +336      +96      -72     +360  rmk_omap3430_ldp_allnoconfig
   +318     +192        0     +510  rmk_omap3430_ldp_oldconfig
   +288      +96      -24     +360  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc1 (ad81f0545ef01ea651886dddac4bef6cec930092))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

