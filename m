From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc6
Date: Tue, 20 Aug 2013 22:00:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308202156340.6426@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45187 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3HTWAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 18:00:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.11-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc6/20130818180958/


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
(delta in bytes from test_v3.11-rc5 
(d4e4ab86bcba5a72779c43dc1459f71fea3d89c8)):
   text     data      bss    total  kernel
   +272        0        0     +272  n800_multi_omap2xxx
   +272        0        0     +272  n800_only_a
  +1000        0        0    +1000  omap1_defconfig
  +1984        0        0    +1984  omap1_defconfig_1510innovator_only
   +992        0        0     +992  omap1_defconfig_5912osk_only
  +4880        0        0    +4880  omap2plus_defconfig
   +712        0        0     +712  omap2plus_defconfig_2430sdp_only
   +784        0        0     +784  omap2plus_defconfig_cpupm
   +720        0        0     +720  omap2plus_defconfig_no_pm
   +784        0        0     +784  omap2plus_defconfig_omap2_4_only
   +784        0        0     +784  omap2plus_defconfig_omap3_4_only
   +296        0      -32     +264  rmk_omap3430_ldp_allnoconfig
   +448        0        0     +448  rmk_omap3430_ldp_oldconfig
   +280        0      -16     +264  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc5 
(d4e4ab86bcba5a72779c43dc1459f71fea3d89c8))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  am335xbonelt   am33xx_only

