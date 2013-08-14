From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc4
Date: Wed, 14 Aug 2013 15:58:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308141554400.24247@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39341 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3HNP6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 11:58:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.11-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc4/20130814082546/

I'm sorry to report that my second OMAP5912 OSK has bitten the dust.  So 
until I can get my hands on another one, I won't be able to boot-test that 
platform any more.  If anyone out there happens to have one that they 
aren't using, I'd gladly take it.

In terms of v3.11-rc, I -rc5 should boot again on that board now that the 
GPIO reverts are in.  The early -rc1 and -rc2 boot "failures" were due to 
a validation script issue here.  -rc3 and -rc4 were legitimately broken.


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
(delta in bytes from test_v3.11-rc3 
(5ae90d8e467e625e447000cb4335c4db973b1095)):
   text     data      bss    total  kernel
   +480       -8      +32     +504  n800_multi_omap2xxx
   +544       -8      +32     +568  n800_only_a
   +592      +24       +8     +624  omap1_defconfig
   +564        0       +8     +572  omap1_defconfig_1510innovator_only
  +1588       -8       +8    +1588  omap1_defconfig_5912osk_only
  +1036      +48        0    +1084  omap2plus_defconfig
   +844        0        0     +844  omap2plus_defconfig_2430sdp_only
   +520      -16        0     +504  omap2plus_defconfig_cpupm
   +916      +80        0     +996  omap2plus_defconfig_no_pm
   +972      +48        0    +1020  omap2plus_defconfig_omap2_4_only
  +1036      +48        0    +1084  omap2plus_defconfig_omap3_4_only
   +612        0      +56     +668  rmk_omap3430_ldp_allnoconfig
   +612        0       +8     +620  rmk_omap3430_ldp_oldconfig
   +556       -8     +120     +668  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc3 
(5ae90d8e467e625e447000cb4335c4db973b1095))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2420n800       n800_only_a
    -4k     4k      .      .  3517evm        omap2plus_defconfig
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -4k     4k      .      .  3730beaglexm   omap2plus_defconfig
    -4k     4k      .      .  37xxevm        omap2plus_defconfig
    -4k     4k      .      .  4430es2panda   omap2plus_defconfig
    -4k     4k      .      .  4460pandaes    omap2plus_defconfig
    -4k     4k      .      .  am335xbone     am33xx_only
    -4k     4k      .      .  am335xbonelt   am33xx_only


