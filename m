From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch-v2.6.33-rc2+ 06/12] arm: omap: kill compile warning in
 irq.c
Date: Tue, 5 Jan 2010 12:20:53 -0800
Message-ID: <20100105202053.GB14533@atomide.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
 <1262127092-14878-7-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60383 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab0AEUUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 15:20:55 -0500
Content-Disposition: inline
In-Reply-To: <1262127092-14878-7-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <felipe.balbi@nokia.com> [091229 14:54]:
> intc_context is only used when omap3 is to be built,
> so also put it under ifdef CONFIG_ARM_OMAP3 to avoid
> the compile warning.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/irq.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index e9bc782..d370052 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -62,7 +62,9 @@ struct omap3_intc_regs {
>  	u32 mir[INTCPS_NR_MIR_REGS];
>  };
>  
> +#ifdef CONFIG_ARCH_OMAP3
>  static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
> +#endif
>  
>  /* INTC bank register get/set */

Can you please move the struct omap3_intc_regs intc_context into
to right above save_context function where we have the a block
already for ifdef CONFIG_ARCH_OMAP3?

That avoids adding a new ifdef block.

Regards,

Tony
