From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod data changes for AM43xx and DRA7xx
 for v4.1
Date: Fri, 27 Mar 2015 12:14:28 -0700
Message-ID: <20150327191428.GF10805@atomide.com>
References: <alpine.DEB.2.02.1503271008120.25612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40308 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbbC0TSp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Mar 2015 15:18:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1503271008120.25612@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150327 03:09]:
> Hi Tony,
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1/omap-hwmod-a
> 
> for you to fetch changes up to edec17863362e0106b9e6b2f83237c7bd535e346:
> 
>   ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4 (2015-03-24 11:52:50 -0600)
> 
> ----------------------------------------------------------------
> OMAP hwmod data changes for AM43xx and DRA7xx for v4.1
> 
> Add support for the AM43xx HDQ/1-wire driver and fix the GPTIMER data
> for DRA7xx.
> 
> Note that I do not have AM43xx nor DRA7xx boards, and cannot test these
> patches on those platforms.
> 
> Basic build, boot, and PM test logs are available at:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.1/20150324185246/

Pulling into omap-for-v4.1/soc thanks.

Tony
 
> ----------------------------------------------------------------
> Sourav Poddar (1):
>       ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W
> 
> Suman Anna (2):
>       ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
>       ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  36 +++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 113 +++++++++++++++++++++++++----
>  arch/arm/mach-omap2/prcm43xx.h             |   1 +
>  3 files changed, 134 insertions(+), 16 deletions(-)
> 
> 
> 
> vmlinux object size
> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539)):
>    text     data      bss    total  kernel
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>       0     +800        0     +800  multi_v7_defconfig
>       0     +920        0     +920  omap2plus_defconfig
>       0        0        0        0  omap2plus_defconfig_2430sdp_only
>       0        0        0        0  omap2plus_defconfig_am33xx_only
>       0     +256        0     +256  omap2plus_defconfig_am43xx_only
>       0     +928        0     +928  omap2plus_defconfig_cpupm
>       0     +704        0     +704  omap2plus_defconfig_dra7xx_only
>       0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
>       0        0        0        0  omap2plus_defconfig_n800_only_a
>       0     +896        0     +896  omap2plus_defconfig_no_pm
>       0        0        0        0  omap2plus_defconfig_omap2_4_only
>       0        0        0        0  omap2plus_defconfig_omap3_4_only
>       0        0        0        0  omap2plus_defconfig_omap5_only
>       0        0        0        0  rmk_omap3430_ldp_allnoconfig
>       0        0        0        0  rmk_omap3430_ldp_oldconfig
>       0        0        0        0  rmk_omap4430_sdp_allnoconfig
>       0        0        0        0  rmk_omap4430_sdp_oldconfig
> 
> Boot-time memory difference
> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539))
>   avail  rsrvd   high  freed  board          kconfig
>  -117772k -13300k      .  -168k  2420n800       omap2plus_defconfig_n800_only_a
>     -4k     4k      .      .  37xxevm        omap2plus_defconfig
>     -4k     4k      .      .  4430es2panda   omap2plus_defconfig
>     -4k     4k      .      .  4460pandaes    omap2plus_defconfig
>     -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
> 
