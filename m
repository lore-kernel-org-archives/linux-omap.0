From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc8
Date: Wed, 15 Jan 2014 19:58:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1401151953580.20720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54977 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaAOT6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2014 14:58:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc8.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc8/20140113013852/


Test summary
------------

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: uImage:
    Pass (14/14): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Boot to userspace:
    skip ( 2/ 2): 5912osk, 4460varsomom
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3530es3beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle

PM: chip off via dynamic idle:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle


vmlinux object size
(delta in bytes from test_v3.13-rc7 (d6e0a2dd12f4067a5bcefb8bbd8ddbeff800afbc)):
   text     data      bss    total  kernel
    +45        0        0      +45  omap1_defconfig
    +49       -8        0      +41  omap1_defconfig_1510innovator_only
    +77        0        0      +77  omap1_defconfig_5912osk_only
     +5        0        0       +5  omap2plus_defconfig
    +25        0        0      +25  omap2plus_defconfig_2430sdp_only
     +5        0        0       +5  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
     +5        0        0       +5  omap2plus_defconfig_no_pm
    +69        0        0      +69  omap2plus_defconfig_omap2_4_only
     +5        0        0       +5  omap2plus_defconfig_omap3_4_only
    +80        0      -88       -8  rmk_omap3430_ldp_allnoconfig
    +65        0        0      +65  rmk_omap3430_ldp_oldconfig
    -16        0      -24      -40  rmk_omap4430_sdp_allnoconfig
   +125        0        0     +125  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc7 (d6e0a2dd12f4067a5bcefb8bbd8ddbeff800afbc))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


