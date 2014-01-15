From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc7
Date: Wed, 15 Jan 2014 19:53:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1401151951420.20720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbaAOTxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2014 14:53:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.13-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc7/20140107113336/


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
    skip ( 2/ 2): 5912osk, 4460varsomom
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

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
(delta in bytes from test_v3.13-rc6 (802eee95bde72fd0cd0f3a5b2098375a487d1eda)):
   text     data      bss    total  kernel
   +128        0        0     +128  omap1_defconfig
   +128        0        0     +128  omap1_defconfig_1510innovator_only
    +96        0        0      +96  omap1_defconfig_5912osk_only
   +348        0        0     +348  omap2plus_defconfig
   +124       +8        0     +132  omap2plus_defconfig_2430sdp_only
   +476        0        0     +476  omap2plus_defconfig_cpupm
     -4        0        0       -4  omap2plus_defconfig_n800_multi_omap2xxx
    -36        0        0      -36  omap2plus_defconfig_n800_only_a
   +228        0        0     +228  omap2plus_defconfig_no_pm
   +284        0        0     +284  omap2plus_defconfig_omap2_4_only
   +348       +8        0     +356  omap2plus_defconfig_omap3_4_only
    -32       +8       +8      -16  rmk_omap3430_ldp_allnoconfig
    +24       +8        0      +32  rmk_omap3430_ldp_oldconfig
    +24       +8      -48      -16  rmk_omap4430_sdp_allnoconfig
 +16400    +6296    +1268   +23964  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc6 (802eee95bde72fd0cd0f3a5b2098375a487d1eda))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)


