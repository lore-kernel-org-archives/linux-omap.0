From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.17-rc3
Date: Tue, 2 Sep 2014 23:52:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409022346440.1546@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47643 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbaIBXwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 19:52:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, grinberg@compulab.co.il


Here are some basic OMAP test results for Linux v3.17-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.17-rc3/20140902165525/


Test summary
------------

Build: zImage:
    Pass (16/16): multi_v7_defconfig, omap2plus_defconfig,
		  omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_dra7xx_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig

Build: uImage+dtb:
    Pass (10/10): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap5-uevm

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Boot to userspace:
    FAIL ( 2/15): 2430sdp, 5430es2sbct54
    skip ( 1/15): 5912osk
    Pass (12/15): 2420n800, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom, 5430es2uevm

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 7): 2430sdp, 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 4/ 5): 3530es3beagle, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 1/ 5): 37xxevm


vmlinux object size
(delta in bytes from test_v3.17-rc2 (52addcf9d6669fa439387610bc65c92fa0980cef)):
   text     data      bss    total  kernel
   +120      +32        0     +152  omap1_defconfig
    +88      +64        0     +152  omap1_defconfig_1510innovator_only
    +88      +32      +32     +152  omap1_defconfig_5912osk_only
  -4992      -24        0    -5016  multi_v7_defconfig
  -4376        0      +64    -4312  omap2plus_defconfig
  -3896      +32        0    -3864  omap2plus_defconfig_2430sdp_only
  -4448       -8        0    -4456  omap2plus_defconfig_am33xx_only
  -4448       -8        0    -4456  omap2plus_defconfig_am43xx_only
  -4376      +64      +64    -4248  omap2plus_defconfig_cpupm
  -4320      +64        0    -4256  omap2plus_defconfig_dra7xx_only
 -15337     -552        0   -15889  omap2plus_defconfig_n800_multi_omap2xxx
 -11241     -504        0   -11745  omap2plus_defconfig_n800_only_a
   +640      +96        0     +736  omap2plus_defconfig_no_pm
  -4448      +80        0    -4368  omap2plus_defconfig_omap2_4_only
  -4384       -8        0    -4392  omap2plus_defconfig_omap3_4_only
  -4384      +80        0    -4304  omap2plus_defconfig_omap5_only
   +108      -16      +24     +116  rmk_omap3430_ldp_allnoconfig
   +172      -16        0     +156  rmk_omap3430_ldp_oldconfig
    +76      -12      +56     +120  rmk_omap4430_sdp_allnoconfig
   +140      +16        0     +156  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc2 (52addcf9d6669fa439387610bc65c92fa0980cef))
  avail  rsrvd   high  freed  board          kconfig
     8k    -8k      .      .  2420n800       omap2plus_defconfig_n800_only_a
     8k    -8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only


A Compulab SBC-T54 (OMAP5432) has been added to the testbed, graciously 
donated by Compulab and Igor Grinberg.  It currently isn't booting to 
userspace in the current mainline kernel, but if the 'ldo8' regulator is 
modified to be always-on in the omap5-sbc-t54.dts file, it will.
