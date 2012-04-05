From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc (misc_devel_3.4 patches dropped)
Date: Thu, 5 Apr 2012 15:46:58 -0700
Message-ID: <20120405224658.GI3785@atomide.com>
References: <alpine.DEB.2.00.1204050339510.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39181 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2DEWrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 18:47:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204050339510.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>

Hi Olof,

* Paul Walmsley <paul@pwsan.com> [120405 02:45]:
> Hi Tony,
> 
> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> 
>   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-a2-for-3.4rc
> 
> for you to fetch changes up to a9dd31b744a033b4324c93cec4ecb4c74061e2cf:
> 
>   Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_a2_3.4rc' and 'powerdomain_fixes_a_3.4rc' into omap-fixes-a2-for-3.4rc-branch (2012-04-05 03:00:22 -0600)
> 
> This version is intended to merge cleanly into your 'fixes' branch.

If not too late for this round of fixes, can you please pull this
set of fixes directly from Paul?

I was planning on including this into my fixes yesterday, but
two patches had to be dropped that Paul did last night.

This one already has the signed tag ;)

Regards,

Tony


> 
> ----------------------------------------------------------------
> 
> OMAP clock, powerdomain, clockdomain, and hwmod fixes intended for the
> early v3.4-rc series.  Also contains an HSMMC integration refinement
> of an earlier hardware bug workaround.
> 
> ARM: OMAP3: clock data: fill in some missing clockdomains
> ARM: OMAP4: clock data: Force a DPLL clkdm/pwrdm ON before a relock
> ARM: OMAP4: clock data: fix mult and div mask for USB_DPLL
> ARM: OMAP2+: powerdomain: Wait for powerdomain transition in pwrdm_state_switch()
> ARM: OMAP AM3517/3505: clock data: change EMAC clocks aliases
> ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit definitions
> ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status
> ARM: OMAP2+: hwmod: Restore sysc after a reset
> ARM: OMAP: clock: fix race in disable all clocks
> ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
> ARM: OMAP2+: omap_hwmod: Allow io_ring wakeup configuration for all modules
> ARM: OMAP3xxx: clock data: fix DPLL4 CLKSEL masks
> ARM: OMAP3xxx: HSMMC: avoid erratum workaround when transceiver is attached
> ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTRL data
> 
> ----------------------------------------------------------------
> Ameya Palande (1):
>       ARM: OMAP4: clock data: fix mult and div mask for USB_DPLL
> 
> Govindraj.R (1):
>       ARM: OMAP2+: omap_hwmod: Allow io_ring wakeup configuration for all modules
> 
> Grazvydas Ignotas (2):
>       ARM: OMAP3xxx: HSMMC: avoid erratum workaround when transceiver is attached
>       ARM: OMAP3xxx: clock data: fix DPLL4 CLKSEL masks
> 
> Ilya Yanok (1):
>       ARM: OMAP AM3517/3505: clock data: change EMAC clocks aliases
> 
> Nishanth Menon (1):
>       ARM: OMAP: clock: fix race in disable all clocks
> 
> Paul Walmsley (4):
>       ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTRL data
>       ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
>       ARM: OMAP3: clock data: fill in some missing clockdomains
>       Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_a2_3.4rc' and 'powerdomain_fixes_a_3.4rc' into omap-fixes-a2-for-3.4rc-branch
> 
> Rajendra Nayak (3):
>       ARM: OMAP4: clock data: Force a DPLL clkdm/pwrdm ON before a relock
>       ARM: OMAP2+: hwmod: Restore sysc after a reset
>       ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status
> 
> Santosh Shilimkar (1):
>       ARM: OMAP2+: powerdomain: Wait for powerdomain transition in pwrdm_state_switch()
> 
> Vaibhav Hiremath (1):
>       ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit definitions
> 
>  arch/arm/mach-omap2/clock3xxx_data.c         |   18 ++++--
>  arch/arm/mach-omap2/clock44xx_data.c         |    5 +-
>  arch/arm/mach-omap2/clockdomains44xx_data.c  |    2 +-
>  arch/arm/mach-omap2/hsmmc.c                  |    7 ++
>  arch/arm/mach-omap2/omap_hwmod.c             |   88 +++++++++++---------------
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   28 ++++++++
>  arch/arm/mach-omap2/powerdomain.c            |    8 ++-
>  arch/arm/plat-omap/clock.c                   |    5 +-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++--
>  9 files changed, 105 insertions(+), 68 deletions(-)
