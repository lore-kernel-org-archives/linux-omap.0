From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: ack spurious IRQs in get_irqnr_and_base
Date: Fri, 17 Oct 2008 02:30:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810170226530.729@utopia.booyaka.com>
References: <1224071511-4670-1-git-send-email-lauri.leukkunen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48663 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYJQIaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 04:30:52 -0400
In-Reply-To: <1224071511-4670-1-git-send-email-lauri.leukkunen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi Lauri,

I think we should merge your patch along with the SO patch also, so in the 
event of a spurious interrupt, it won't wedge the whole system.   One 
question though:

On Wed, 15 Oct 2008, Lauri Leukkunen wrote:

> This prevents spurious interrupts from repeating unacked and
> thus locking the system, while still allowing the spurious
> bad irq error message to be show on console.
> 
> Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/entry-macro.S |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
> index a8fca9d..c88a4cb 100644
> --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> @@ -87,7 +87,26 @@
>  		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
>  		cmp	\irqnr, #0x0
>  2222:
> -		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +#if defined(CONFIG_ARCH_OMAP34XX)
> +		mov	\tmp, \irqnr
> +#endif
> + 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +#if defined(CONFIG_ARCH_OMAP34XX)
> +		mov	\irqstat, \irqnr
> +		bic	\irqstat, \irqstat, #0x7f /* check for spurious flag */

According to Table 10-14 in the TRM, the spurious flag field is 25 bits 
wide, but the patch only checks for 7 bits.  This should probably be 
extended?

> +		cmp	\irqstat, #0x0
> +		beq	2223f
> +		mov	\irqstat, #0x1 /* Ack the spurious irq, this lets it
> +					* generate a bad irq error message,
> +					* but prevents infinitely repeating
> +					* irq.
> +					*/
> +		str	\irqstat, [\base, #0x48] /* INTC_CONTROL register */
> +2223:
> +		cmp	\tmp, #0x0 /* set conditional back to what it was
> +				    * before spurious test
> +				    */
> +#endif
>  
>  		.endm
>  

- Paul
