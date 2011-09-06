From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v3] OMAP: clock/powerdomain/clockdomain/hwmod: fixes
 for 3.1-rc
Date: Tue, 6 Sep 2011 04:29:14 -0700
Message-ID: <20110906112914.GC1895@atomide.com>
References: <alpine.DEB.2.00.1108222319310.28226@utopia.booyaka.com>
 <alpine.DEB.2.00.1108230105180.28226@utopia.booyaka.com>
 <alpine.DEB.2.00.1108300104010.26173@utopia.booyaka.com>
 <alpine.DEB.2.00.1109011751370.26025@utopia.booyaka.com>
 <alpine.DEB.2.00.1109042023190.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18814 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754170Ab1IFL3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 07:29:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1109042023190.9056@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, santosh.shilimkar@ti.com, Paul Walmsley <paul@pwsan.com>

Arnd,

Care to pull the following fixes to the -rc series from Paul?


* Paul Walmsley <paul@pwsan.com> [110904 18:53]:
> The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
> 
>   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 prcm-fixes-a-3.1rc
> 
> This update adds a patch for a missing array terminator in the OMAP2430 
> hwmod data.
> 
> Paul Walmsley (5):
>       OMAP4: clock: re-enable previous clockdomain enable/disable sequence
>       OMAP4: clock: fix compile warning
>       OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in the WKUP clockdomain
>       OMAP2430: hwmod: musb: add missing terminator to omap2430_usbhsotg_addrs[]
>       Merge branches 'non_hwmod_compliant_fix_3.1rc', 'omap3_clock_fixes_3.1rc', 'omap4_clock_fixes_3.1rc', 'missing_2430_musb_adds_terminator_fix_3.1rc' and 'pwrdm_clkdm_fixes_3.1rc' into prcm-fixes-a-3.1rc
> 
> Rajendra Nayak (1):
>       OMAP: powerdomains: Make all powerdomain target states as ON at init
> 
> Santosh Shilimkar (1):
>       OMAP: clockdomain: Wait for powerdomain to be ON when using clockdomain force wakeup
> 
>  arch/arm/mach-omap2/clock3xxx_data.c       |    2 ++
>  arch/arm/mach-omap2/clock44xx_data.c       |   10 +++++++++-
>  arch/arm/mach-omap2/clockdomain.c          |    2 ++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
>  arch/arm/mach-omap2/pm.c                   |    2 --
>  arch/arm/mach-omap2/powerdomain.c          |   25 ++++++++++++++++---------
>  6 files changed, 30 insertions(+), 12 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
