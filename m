From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc5
Date: Wed, 14 Aug 2013 15:59:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308141558540.24247@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab3HNP7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 11:59:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@vger.kernel.org


Here are some basic OMAP test results for Linux v3.11-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc5/20130814083603/


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
(delta in bytes from test_v3.11-rc4 
(c095ba7224d8edc71dcef0d655911399a8bd4a3f)):
   text     data      bss    total  kernel
   +116      +24        0     +140  n800_multi_omap2xxx
    +84        0        0      +84  n800_only_a
   +576        0        0     +576  omap1_defconfig
   +576        0        0     +576  omap1_defconfig_1510innovator_only
   +576        0        0     +576  omap1_defconfig_5912osk_only
   +804       -8        0     +796  omap2plus_defconfig
   +988       -8        0     +980  omap2plus_defconfig_2430sdp_only
   +804       -8        0     +796  omap2plus_defconfig_cpupm
   +868       -8        0     +860  omap2plus_defconfig_no_pm
   +868      +24        0     +892  omap2plus_defconfig_omap2_4_only
   +804       -8        0     +796  omap2plus_defconfig_omap3_4_only
   +296      +64      -40     +320  rmk_omap3430_ldp_allnoconfig
   +352        0        0     +352  rmk_omap3430_ldp_oldconfig
   +360      +64     -104     +320  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc4 
(c095ba7224d8edc71dcef0d655911399a8bd4a3f))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)



