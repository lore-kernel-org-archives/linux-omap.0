From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 00/27] ARM: OMAP2+: clock code migration to
 drivers/clk/ti
Date: Mon, 11 May 2015 20:21:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505111747460.19833@utopia.booyaka.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43529 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbEKUVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 16:21:38 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

Hi

On Mon, 11 May 2015, Tero Kristo wrote:

> This set moves most of the OMAP2+ clock driver code under drivers/clk.
> There are still a couple of files under mach-omap2 folder after this
> set which have either unmet dependencies still (towards PRCM driver)
> or is currently slightly broken (some of the DVFS code for OMAP2/OMAP3.)
> Earlier version of this set has been posted back in March (see
> http://www.spinics.net/lists/linux-omap/msg116418.html), mostly
> the code is the same except patches 25+ which are new.
> 
> Overall diffstat for this set:
>  42 files changed, 2644 insertions(+), 3707 deletions(-)
> 
> Testing done:
> am335x-evm      : boot
> am335x-evmsk    : boot
> am3517-evm      : boot
> am37x-evm       : boot
> am43x-epos-evm  : boot
> am437x-gp-evm   : boot
> omap3-beagle-xm : boot
> omap3-beagle    : boot, suspend-resume (ret/off), cpuidle (ret/off)
> am335x-boneblack: boot
> am335x-bone     : boot
> craneboard      : boot
> dra7xx-evm      : boot
> omap3430-ldp    : boot
> omap3-n900      : boot
> omap5-uevm      : boot
> omap4-panda-es  : boot, suspend-resume (ret), cpuidle (ret)
> omap4-panda     : boot
> omap2430-sdp    : boot
> omap3430-sdp    : boot 
> omap4-sdp-es23plus: boot
> 
> Branch info:
> - tree: https://github.com/t-kristo/linux-pm.git
> - branch: for-4.2/ti-clk-move

I can't replicate your test results.  Several Kconfigs fail to build here, 
and many boards don't even boot.

Could you please post a copy of your boot logs?

- Paul

http://www.pwsan.com/omap/testlogs/test-tkristo-clk-move-v4.2/20150511115145/

OMAP development test results for test-tkristo-clk-move-v4.2 20150511115145


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    FAIL ( 2/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig_n800_only_a/omap2420-n800
    Pass (11/13): omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    FAIL ( 9/17): omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig
    Pass ( 8/17): omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    FAIL ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build warnings from toolchain: uImage+dtb:
    FAIL ( 2/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig_n800_only_a/omap2420-n800

Build warnings from toolchain: zImage:
    FAIL (14/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 6/17): 4460varsomom, 2430sdp, 3530es3beagle, 3530es31beagle,
		  cmt3517, 5430es2sbct54
    skip ( 5/17): 5912osk, 3517evm, am335xbonelt, am335xbone, 2420n800
    Pass ( 6/17): 4430es2panda, 4460pandaes, 37xxevm, 3730beaglexm,
		  3730es12beaglexm, 5430es2uevm

Kernel warnings during boot to userspace:
    FAIL ( 1/17): 4430es2panda

PM: chip retention via suspend:
    skip ( 1/12): am335xbonelt
    FAIL ( 7/12): 4430es2panda, 4460varsomom, 3530es3beagle,
		  3530es31beagle, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 4/12): 4460pandaes, 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    skip ( 1/12): am335xbonelt
    FAIL ( 7/12): 4430es2panda, 4460varsomom, 3530es3beagle,
		  3530es31beagle, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 4/12): 4460pandaes, 37xxevm, 3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 3530es3beagle, 3530es31beagle
    Pass ( 2/ 4): 37xxevm, 3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.1-rc2 (5ebe6afaf0057ac3eaeb98defd5456894b446d22)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  -1484       -8        0    -1492  multi_v7_defconfig
  -2108      +56        0    -2052  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
  -6140      +56      -64    -6148  omap2plus_defconfig_cpupm
  -6204       -8        0    -6212  omap2plus_defconfig_no_pm
  -1908       -8        0    -1916  omap2plus_defconfig_omap3_4_only
  -2804       -4     +780    -2028  rmk_omap3430_ldp_allnoconfig
  -1812       -8      +64    -1756  rmk_omap3430_ldp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc2 (5ebe6afaf0057ac3eaeb98defd5456894b446d22))
  avail  rsrvd   high  freed  board          kconfig
 -117644k -13428k      .  -168k  2420n800       omap2plus_defconfig_n800_only_a
    -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
 -79556k -51516k      .  -364k  am335xbone     omap2plus_defconfig_am33xx_only
 -224000k -37120k      .  -440k  am335xbonelt   omap2plus_defconfig

