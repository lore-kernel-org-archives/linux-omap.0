From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.19-rc7
Date: Thu, 5 Feb 2015 06:03:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502050601040.10430@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502031943480.10430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41850 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbBEGDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 01:03:22 -0500
In-Reply-To: <alpine.DEB.2.02.1502031943480.10430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Tue, 3 Feb 2015, Paul Walmsley wrote:

> vmlinux object size
> (delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce)):
>    text     data      bss    total  kernel
>    +364      +80        0     +444  omap1_defconfig
>    +396      +80        0     +476  omap1_defconfig_1510innovator_only
>    +364      +48        0     +412  omap1_defconfig_5912osk_only
>  +99570    +5096     +320  +104986  multi_v7_defconfig
> -522133   -33016    -2880  -558029  omap2plus_defconfig
> -504092   -26904    -2816  -533812  omap2plus_defconfig_2430sdp_only
> -534205   -28088    -2816  -565109  omap2plus_defconfig_am33xx_only
> -521309   -27768    -2816  -551893  omap2plus_defconfig_am43xx_only
> -522133   -33008    -2880  -558021  omap2plus_defconfig_cpupm
> -521309   -30328    -2816  -554453  omap2plus_defconfig_dra7xx_only
>  -46578     -912     -180   -47670  omap2plus_defconfig_n800_multi_omap2xxx
>  -46610     -944     -180   -47734  omap2plus_defconfig_n800_only_a
> -518949   -32936    -2816  -554701  omap2plus_defconfig_no_pm
> -525661   -28024    -2816  -556501  omap2plus_defconfig_omap2_4_only
> -504945   -27888    -2880  -535713  omap2plus_defconfig_omap3_4_only
> -525405   -29936    -2816  -558157  omap2plus_defconfig_omap5_only
>    -320      +32      +56     -232  rmk_omap3430_ldp_allnoconfig
>    +736        0        0     +736  rmk_omap3430_ldp_oldconfig
>    -280        0      +48     -232  rmk_omap4430_sdp_allnoconfig
>    +728      -24        0     +704  rmk_omap4430_sdp_oldconfig
> 
> Boot-time memory difference
> (delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce))
>   avail  rsrvd   high  freed  board          kconfig
>     52k   -52k      .      .  2420n800       omap2plus_defconfig_n800_only_a
>    536k  -536k      .      .  2430sdp        omap2plus_defconfig
>    540k  -540k      .      .  3530es31beagle omap2plus_defconfig
>    540k  -540k      .      .  3530es3beagle  omap2plus_defconfig
>    536k  -536k      .      .  3730beaglexm   omap2plus_defconfig
>    536k  -536k      .      .  3730es12beaglexmomap2plus_defconfig
>    540k  -540k      .      .  37xxevm        omap2plus_defconfig
>    540k  -540k      .      .  4430es2panda   omap2plus_defconfig
>    540k  -540k      .      .  4460pandaes    omap2plus_defconfig
>    540k  -540k      .      .  4460varsomom   omap2plus_defconfig
>    540k  -540k      .      .  5430es2sbct54  omap2plus_defconfig
>    536k  -536k      .      .  5430es2uevm    omap2plus_defconfig
>    548k  -548k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
>    536k  -536k      .      .  am335xbonelt   omap2plus_defconfig
> 
> 
> While in general it's nice to see kernel memory consumption decrease, it's 
> disturbing to see it happen between an -rc6 and -rc7 release.

Looked into this further.  It turns out that the Kconfigs for this test 
run were generated from an older kernel version, so the Kconfigs don't 
match what's in v3.19-rc7.  I've added an additional verification check 
that should catch this if it happens again, and will post a corrected 
test run shortly.


- Paul
