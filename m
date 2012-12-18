From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: clock/cpuidle: fixes for the v3.8 merge
 window
Date: Mon, 17 Dec 2012 16:38:55 -0800
Message-ID: <20121218003855.GZ4989@atomide.com>
References: <alpine.DEB.2.00.1212171908460.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753458Ab2LRAi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 19:38:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212171908460.29833@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Olof,

* Paul Walmsley <paul@pwsan.com> [121217 11:12]:
> Hi Tony
> 
> The following changes since commit 7a280cf512053137a37da2801eac73a8842fa50d:
> 
>   Merge tag 'disintegrate-x86-20121214' of git://git.infradead.org/users/dhowells/linux-headers (2012-12-14 15:48:52 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-v3.8-window
> 
> for you to fetch changes up to 9db316b6bf0234d9391f87dd0d28b23f5a44facb:
> 
>   ARM: OMAP3/4: cpuidle: fix sparse and checkpatch warnings (2012-12-15 01:41:24 -0700)
> 
> ----------------------------------------------------------------
> Fix some OMAP4 clock problems, and deal with some sparse warnings from
> the OMAP CPUIdle code.

Can you please pick up this one too?

Thanks,

Tony
 
> ----------------------------------------------------------------
> Jon Hunter (5):
>       ARM: OMAP4: Update timer clock aliases
>       ARM: OMAP4: Add function table for non-M4X dplls
>       ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
>       ARM: OMAP4460: Workaround ABE DPLL failing to turn-on
>       ARM: OMAP4: Fix EMU clock domain always on
> 
> Paul Walmsley (3):
>       ARM: OMAP4: clock data: div_iva_hs_clk is a power-of-two divider
>       ARM: OMAP4: clock data: DPLLs are missing bypass clocks in their parent lists
>       ARM: OMAP3/4: cpuidle: fix sparse and checkpatch warnings
> 
>  arch/arm/mach-omap2/cclock44xx_data.c |   78 +++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/clock.h           |   10 +++++
>  arch/arm/mach-omap2/clockdomain.c     |    3 +-
>  arch/arm/mach-omap2/cpuidle34xx.c     |   14 +++---
>  arch/arm/mach-omap2/cpuidle44xx.c     |   28 +++++++-----
>  arch/arm/mach-omap2/dpll3xxx.c        |   46 +++++++++++++------
>  arch/arm/mach-omap2/dpll44xx.c        |   64 +++++++++++++++++++++++----
>  7 files changed, 189 insertions(+), 54 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
