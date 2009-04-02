From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Clean up spurious interrupt check logic
Date: Thu, 2 Apr 2009 09:25:29 -0700
Message-ID: <20090402162529.GO32530@atomide.com>
References: <49D4C9B8.10806@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56628 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZDBQZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 12:25:34 -0400
Content-Disposition: inline
In-Reply-To: <49D4C9B8.10806@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

* Roger Quadros <ext-roger.quadros@nokia.com> [090402 07:21]:
> From: Roger Quadros <ext-roger.quadros@nokia.com>
> Date: Thu, 2 Apr 2009 16:41:00 +0300
> Subject: [PATCH] ARM: OMAP3: Clean up spurious interrupt check logic
>
> SPURIOUSIRQ is contained in bits 31:7 of INTC_SIR, so
> INTC_SIR must be right shifted by 7, not 6.
>
> No change in logic, only changes for better readability.
> Refer to register definition of INTCPS_SIR_IRQ in OMAP3 Manual.

Argh, that bug explains why I could not figure out the meaning
of the first spurious bit.. :)

I guess the spurious bit value is still on or off instead of
actually telling the previous spurious irq number though.

Tony

> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
> arch/arm/mach-omap2/irq.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 2842fe8..296ab86 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -73,9 +73,9 @@ static int omap_check_spurious(unsigned int irq)
> 	u32 sir, spurious;
>
> 	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
> -	spurious = sir >> 6;
> +	spurious = sir >> 7;
>
> -	if (spurious > 1) {
> +	if (spurious) {
> 		printk(KERN_WARNING "Spurious irq %i: 0x%08x, please flush "
> 					"posted write for irq %i\n",
> 					irq, sir, previous_irq);
> -- 
> 1.5.6.5
>
>
