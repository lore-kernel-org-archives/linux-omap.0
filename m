From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc5
Date: Thu, 26 Dec 2013 04:04:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312260402460.15949@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41744 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3LZEEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Dec 2013 23:04:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.13-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc5/20131223031812/


Test summary
------------

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

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

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

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
(delta in bytes from test_v3.13-rc4 (319e2e3f63c348a9b66db4667efa73178e18b17d)):
   text     data      bss    total  kernel
  +7036        0        0    +7036  omap1_defconfig
  +8060        0        0    +8060  omap1_defconfig_1510innovator_only
  +7004        0        0    +7004  omap1_defconfig_5912osk_only
   -664      -24        0     -688  omap2plus_defconfig
  -1040        0        0    -1040  omap2plus_defconfig_2430sdp_only
   -664       +8        0     -656  omap2plus_defconfig_cpupm
   +276       +8        0     +284  omap2plus_defconfig_n800_multi_omap2xxx
   +340      +40        0     +380  omap2plus_defconfig_n800_only_a
   -600       +8        0     -592  omap2plus_defconfig_no_pm
   -728        0        0     -728  omap2plus_defconfig_omap2_4_only
   -664        0        0     -664  omap2plus_defconfig_omap3_4_only
   +228        0      -16     +212  rmk_omap3430_ldp_allnoconfig
  +6304        0        0    +6304  rmk_omap3430_ldp_oldconfig
   +536        0        0     +536  rmk_omap4430_sdp_allnoconfig
    -96        0        0      -96  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc4 (319e2e3f63c348a9b66db4667efa73178e18b17d))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


Ho ho ho
