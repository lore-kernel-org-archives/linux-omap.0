From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: OMAP DRA7xx display-related hwmod data
 changes for v4.1
Date: Fri, 3 Apr 2015 16:08:33 -0700
Message-ID: <20150403230833.GB18048@atomide.com>
References: <alpine.DEB.2.02.1504031953150.19540@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41743 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbbDCXM1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 19:12:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1504031953150.19540@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Hi Arnd & Olof,

Please feel free to pull this directly from Paul.

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [150403 12:55]:
> Hi Tony
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1/omap-hwmod-b
> 
> for you to fetch changes up to 0d75ebdd3230b3d085812df80ec54138828cc76a:
> 
>   ARM: DRA7: hwmod: set DSS submodule parent hwmods (2015-04-03 13:15:07 -0600)
> 
> ----------------------------------------------------------------
> OMAP DRA7xx display-related hwmod data changes for v4.1
> 
> Add DMM hwmod data for DRA7xx, and set the parent hwmods fields
> appropriately for the DRA7xx DSS submodules as we've done for
> other OMAP devices.
> 
> Note that I do not have a DRA7xx board, and thus cannot boot-test
> these patches.
> 
> Basic build, boot, and PM idle test logs are available at:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.1/20150403123702/
> 
> ----------------------------------------------------------------
> Tomi Valkeinen (2):
>       ARM: DRA7: hwmod: add DMM hwmod description
>       ARM: DRA7: hwmod: set DSS submodule parent hwmods
> 
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> 
> 
> vmlinux object size
> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539)):
>    text     data      bss    total  kernel
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>       0     +192        0     +192  multi_v7_defconfig
>       0     +216        0     +216  omap2plus_defconfig
>       0        0        0        0  omap2plus_defconfig_2430sdp_only
>       0        0        0        0  omap2plus_defconfig_am33xx_only
>       0        0        0        0  omap2plus_defconfig_am43xx_only
>       0     +224        0     +224  omap2plus_defconfig_cpupm
>       0     +192        0     +192  omap2plus_defconfig_dra7xx_only
>       0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
>       0        0        0        0  omap2plus_defconfig_n800_only_a
>       0     +192        0     +192  omap2plus_defconfig_no_pm
>       0        0        0        0  omap2plus_defconfig_omap2_4_only
>       0        0        0        0  omap2plus_defconfig_omap3_4_only
>       0        0        0        0  omap2plus_defconfig_omap5_only
>       0        0        0        0  rmk_omap3430_ldp_allnoconfig
>       0        0        0        0  rmk_omap3430_ldp_oldconfig
>      +8        0       -8        0  rmk_omap4430_sdp_allnoconfig
>       0        0        0        0  rmk_omap4430_sdp_oldconfig
> 
> Boot-time memory difference
> (delta in bytes from test_v4.0-rc1 (c517d838eb7d07bbe9507871fab3931deccff539))
>   avail  rsrvd   high  freed  board          kconfig
>     -4k     4k      .      .  4460pandaes    omap2plus_defconfig
>    -12k    12k      .      .  4460varsomom   omap2plus_defconfig
>     -4k     4k      .      .  5430es2sbct54  omap2plus_defconfig
> 
