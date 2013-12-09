From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
Date: Mon, 9 Dec 2013 09:54:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com> <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33423 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564Ab3LIJyU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 04:54:20 -0500
In-Reply-To: <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, 25 Nov 2013, Paul Walmsley wrote:

> On Mon, 25 Nov 2013, Paul Walmsley wrote:
> 
> > Boot to userspace:
> >     FAIL ( 1/11): 37xxevm
> 
> So looks like this is due to the switchover to DT-based booting for 37xx 
> EVM.  Will plug that in here and re-test.

Here's the updated test report.  Looks like dynamic idle PM tests are 
failing on the 37xxevm now.


- Paul


OMAP baseline test results for v3.13-rc1 (toolchain Debian 4.7.2-5)

Here are some basic OMAP test results for Linux v3.13-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131208173326/


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
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52)):
   text     data      bss    total  kernel
-351659     +384    +4216  -347059  omap1_defconfig
-354695     +296    +4216  -350183  omap1_defconfig_1510innovator_only
-354491     +360    +4216  -349915  omap1_defconfig_5912osk_only
-276029    -5584    +5008  -276605  omap2plus_defconfig
-292693    +9808    +4656  -278229  omap2plus_defconfig_2430sdp_only
-273194    -5512    +5008  -273698  omap2plus_defconfig_cpupm
 +88436   +10392    +4368  +103196  omap2plus_defconfig_n800_multi_omap2xxx
 +88404   +10408    +4368  +103180  omap2plus_defconfig_n800_only_a
-273765    -4704    +5008  -273461  omap2plus_defconfig_no_pm
-263629   +13912    +4944  -244773  omap2plus_defconfig_omap2_4_only
-270645    -5584    +5008  -271221  omap2plus_defconfig_omap3_4_only
-119724   -10124    +2960  -126888  rmk_omap3430_ldp_allnoconfig
 +49719    +3936    +4352   +58007  rmk_omap3430_ldp_oldconfig
-115704    +1788    +5608  -108308  rmk_omap4430_sdp_allnoconfig
+4738404  +250480  +443152  +5432036  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52))
  avail  rsrvd   high  freed  board          kconfig
  -104k   104k      .     4k  2420n800       omap2plus_defconfig_n800_only_a
   276k  -276k      .    -8k  2430sdp        omap2plus_defconfig
   276k  -276k      .    -8k  3517evm        omap2plus_defconfig
   276k  -276k      .    -8k  3530es3beagle  omap2plus_defconfig
   276k  -276k      .    -8k  3730beaglexm   omap2plus_defconfig
   228k  -228k      .    -8k  37xxevm        omap2plus_defconfig
   272k  -272k      .    -8k  4430es2panda   omap2plus_defconfig
   268k  -268k      .    -8k  4460pandaes    omap2plus_defconfig
   272k  -272k      .    -8k  4460varsomom   omap2plus_defconfig
   312k  -312k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
   268k  -268k      .    -8k  am335xbonelt   omap2plus_defconfig


