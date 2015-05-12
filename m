From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 00/27] ARM: OMAP2+: clock code migration to
 drivers/clk/ti
Date: Tue, 12 May 2015 20:58:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505122019220.21747@utopia.booyaka.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1505111747460.19833@utopia.booyaka.com> <5551D178.3000904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58220 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbELU6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2015 16:58:32 -0400
In-Reply-To: <5551D178.3000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Tue, 12 May 2015, Tero Kristo wrote:

> On 05/11/2015 11:21 PM, Paul Walmsley wrote:
> > On Mon, 11 May 2015, Tero Kristo wrote:
> > 
> > > This set moves most of the OMAP2+ clock driver code under drivers/clk.
> > > There are still a couple of files under mach-omap2 folder after this
> > > set which have either unmet dependencies still (towards PRCM driver)
> > > or is currently slightly broken (some of the DVFS code for OMAP2/OMAP3.)
> > > Earlier version of this set has been posted back in March (see
> > > http://www.spinics.net/lists/linux-omap/msg116418.html), mostly
> > > the code is the same except patches 25+ which are new.

...

> > > 
> > > Branch info:
> > > - tree: https://github.com/t-kristo/linux-pm.git
> > > - branch: for-4.2/ti-clk-move
> > 
> > I can't replicate your test results.  Several Kconfigs fail to build here,
> > and many boards don't even boot.
> > 
> > Could you please post a copy of your boot logs?
> > 
> > - Paul
> > 
> > http://www.pwsan.com/omap/testlogs/test-tkristo-clk-move-v4.2/20150511115145/
> > 
> > OMAP development test results for test-tkristo-clk-move-v4.2 20150511115145
> 
> Oh hmm, I seem to have introduced a Makefile issue which breaks a couple of
> special builds. I just force pushed updated branch.

This one is better... the build problems are now fixed.

> Here are the boot logs for it, I tried also single-soc builds with
> am3/am4/omap2/omap3/omap4/omap5/dra7:
> 
>   : Board           : Boot url
>  1: am335x-evm      : PASS http://paste.ubuntu.com/11093628/
>  2: am335x-evmsk    : PASS http://paste.ubuntu.com/11093629/
>  3: am3517-evm      : PASS http://paste.ubuntu.com/11093630/
>  4: am37x-evm       : PASS http://paste.ubuntu.com/11093632/
>  5: am43x-epos-evm  : PASS http://paste.ubuntu.com/11093633/
>  6: am437x-gp-evm   : PASS http://paste.ubuntu.com/11093634/
>  7: am57xx-evm      : FAIL http://paste.ubuntu.com/11093635/
>  8: omap3-beagle-xm : PASS http://paste.ubuntu.com/11093636/
>  9: omap3-beagle    : PASS http://paste.ubuntu.com/11093637/
> 10: am335x-boneblack: PASS http://paste.ubuntu.com/11093638/
> 11: am335x-bone     : PASS http://paste.ubuntu.com/11093639/
> 12: craneboard      : PASS http://paste.ubuntu.com/11093640/
> 13: dra7xx-evm      : PASS http://paste.ubuntu.com/11093641/
> 14: omap3430-ldp    : PASS http://paste.ubuntu.com/11093642/
> 15: omap3-n900      : PASS http://paste.ubuntu.com/11093643/
> 16: omap5-uevm      : PASS http://paste.ubuntu.com/11093645/
> 17: omap4-panda-es  : PASS http://paste.ubuntu.com/11093646/
> 18: omap4-panda     : PASS http://paste.ubuntu.com/11093647/
> 19: omap2430-sdp    : PASS http://paste.ubuntu.com/11093648/
> 20: omap3430-sdp    : PASS http://paste.ubuntu.com/11093649/
> 21: omap4-sdp-es23plus: PASS http://paste.ubuntu.com/11093650/
> TOTAL = 21 boards, Booted Boards = 20, No Boot boards = 1
> 
> AM57xx-evm boot fails as it is missing some patches from Nishanth (I think the
> UART mux has changed.)

But this one has the same problems as v4.1-rc1 and beyond: it still 
doesn't boot here on any OMAP34xx/OMAP35xx platform, nor the CM-T3517, 
OMAP4460 VAR-SOM-OM, or OMAP5430ES2 SBC-T54:

http://www.pwsan.com/omap/testlogs/test_v4.1-rc1/20150426200156/README.txt

Thanks for posting your test logs above.  They don't include bootloader 
info, but my guess is that v4.1-rc* has some hidden bootloader 
dependencies where things aren't being initialized properly from the 
kernel.

So those should be tracked down and fixed before we stack more patches on 
top.


- Paul


http://www.pwsan.com/omap/testlogs/test-tkristo-clk-move-v4.2/20150512121218/


OMAP development test results for test-tkristo-clk-move-v4.2 20150512121218


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (17/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
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
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    FAIL ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build warnings from toolchain: uImage+dtb:
    (none)

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
    skip ( 2/17): 5912osk, 3517evm
    Pass ( 9/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  37xxevm, 3730beaglexm, 3730es12beaglexm, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 1/17): 4430es2panda

PM: chip retention via suspend:
    FAIL ( 9/12): am335xbonelt, 4430es2panda, 4460varsomom,
		  3530es3beagle, 3530es31beagle, 3730es12beaglexm,
		  2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 3/12): 4460pandaes, 37xxevm, 3730beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 9/12): am335xbonelt, 4430es2panda, 4460varsomom,
		  3530es3beagle, 3530es31beagle, 3730es12beaglexm,
		  2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 3/12): 4460pandaes, 37xxevm, 3730beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 3530es3beagle, 3530es31beagle, 3730es12beaglexm
    Pass ( 1/ 4): 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 3530es3beagle, 3530es31beagle, 3730es12beaglexm
    Pass ( 1/ 4): 37xxevm

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
  -1492       -8        0    -1500  multi_v7_defconfig
  -2116      +56        0    -2060  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
  -1476        0      +64    -1412  omap2plus_defconfig_am33xx_only
  -5572        0      +64    -5508  omap2plus_defconfig_am43xx_only
  -6148      +56      -64    -6156  omap2plus_defconfig_cpupm
  -5500        0      +64    -5436  omap2plus_defconfig_dra7xx_only
  -1668        0      +12    -1656  omap2plus_defconfig_n800_multi_omap2xxx
  -1636       -8      -20    -1664  omap2plus_defconfig_n800_only_a
  -6212       -8        0    -6220  omap2plus_defconfig_no_pm
  -5828        0      -64    -5892  omap2plus_defconfig_omap2_4_only
  -1916       -8        0    -1924  omap2plus_defconfig_omap3_4_only
  -1412        0        0    -1412  omap2plus_defconfig_omap5_only
  -2804       -4     +780    -2028  rmk_omap3430_ldp_allnoconfig
  -1812       -8      +64    -1756  rmk_omap3430_ldp_oldconfig
  -2332        0     +956    -1376  rmk_omap4430_sdp_allnoconfig
  -1336      +64        0    -1272  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc2 (5ebe6afaf0057ac3eaeb98defd5456894b446d22))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
      .      .      .     4k  am335xbone     omap2plus_defconfig_am33xx_only

