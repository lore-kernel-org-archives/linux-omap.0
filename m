From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.15-rc4
Date: Thu, 8 May 2014 04:23:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37537 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaEHEXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 00:23:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.15-rc4.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.15-rc4/20140505112251/


Test summary
------------

Build: uImage+dtb:
    Pass ( 9/ 9): omap2plus_defconfig_am33xx_only/am335x-bone,
                  omap2plus_defconfig/omap4-panda,
                  omap2plus_defconfig/omap4-panda-es,
                  omap2plus_defconfig/am3517-evm,
                  omap2plus_defconfig/omap2430-sdp,
                  omap2plus_defconfig/omap3-beagle,
                  omap2plus_defconfig/omap3-beagle-xm,
                  omap2plus_defconfig/omap3-evm-37xx,
                  omap2plus_defconfig/omap4-var-som

Build: zImage:
    Pass (14/14): multi_v7_defconfig, omap2plus_defconfig,
                  omap2plus_defconfig_am33xx_only,
                  omap2plus_defconfig_2430sdp_only,
                  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
                  omap2plus_defconfig_n800_only_a,
                  omap2plus_defconfig_n800_multi_omap2xxx,
                  omap2plus_defconfig_omap2_4_only,
                  omap2plus_defconfig_omap3_4_only,
                  rmk_omap3430_ldp_allnoconfig,
                  rmk_omap3430_ldp_oldconfig,
                  rmk_omap4430_sdp_allnoconfig,
                  rmk_omap4430_sdp_oldconfig

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
                  omap1_defconfig_5912osk_only

Boot to userspace:
    FAIL ( 1/12): 2430sdp
    skip ( 3/12): 5912osk, cmt3517, 4460varsomom
    Pass ( 8/12): 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
                  4430es2panda, 4460pandaes, am335xbone, am335xbonelt

PM: chip retention via suspend:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 2/ 7): 2430sdp, 4430es2panda
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    skip ( 1/ 7): 4460varsomom
    FAIL ( 6/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
                  4430es2panda, 4460pandaes

PM: chip off except CORE via suspend:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    FAIL ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes

PM: chip off via dynamic idle:
    skip ( 1/ 5): 4460varsomom
    FAIL ( 4/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes


vmlinux object size
(delta in bytes from test_v3.15-rc3 (d1db0eea852497762cab43b905b879dfcd3b8987)):
   text     data      bss    total  kernel
   +216        0        0     +216  omap1_defconfig
   +248        0        0     +248  omap1_defconfig_1510innovator_only
   +216        0        0     +216  omap1_defconfig_5912osk_only
   +364       +8        0     +372  multi_v7_defconfig
   +448        0        0     +448  omap2plus_defconfig
   +304        0        0     +304  omap2plus_defconfig_2430sdp_only
   +512       +8        0     +520  omap2plus_defconfig_am33xx_only
   +512       +8        0     +520  omap2plus_defconfig_am43xx_only
   +448        0        0     +448  omap2plus_defconfig_cpupm
   +512       +8        0     +520  omap2plus_defconfig_dra7xx_only
   +420       +8       +4     +432  omap2plus_defconfig_n800_multi_omap2xxx
   +388        0       +4     +392  omap2plus_defconfig_n800_only_a
   +512       +8        0     +520  omap2plus_defconfig_no_pm
   +384        0        0     +384  omap2plus_defconfig_omap2_4_only
   +512        0        0     +512  omap2plus_defconfig_omap3_4_only
   +512        0        0     +512  omap2plus_defconfig_omap5_only
   +336        0        0     +336  rmk_omap3430_ldp_allnoconfig
   +352       +8        0     +360  rmk_omap3430_ldp_oldconfig
   +352        0      -16     +336  rmk_omap4430_sdp_allnoconfig
   +392       -8        0     +384  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.15-rc3 (d1db0eea852497762cab43b905b879dfcd3b8987))
  avail  rsrvd   high  freed  board          kconfig
 -1007432k -40120k -269312k  -388k  4460varsomom   omap2plus_defconfig


The eMMC on the 4460 VAR-SOM-OM has failed; I guess it's run out of 
reserve blocks to reallocate.  Now it's time to find yet another way 
to boot it.


