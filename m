From: Tony Lindgren <tony@atomide.com>
Subject: Re: ALSA sound on beagleboard
Date: Thu, 23 Oct 2008 10:48:52 -0700
Message-ID: <20081023174850.GL2994@atomide.com>
References: <E1Kt4A4-0003OH-R7@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57453 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYJWRsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 13:48:55 -0400
Content-Disposition: inline
In-Reply-To: <E1Kt4A4-0003OH-R7@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

* Rick Bronson <rick@efn.org> [081023 10:41]:
> Tony,
> 
>   I checked out some other ARM spurious interrupt handling and it
> seems that they ack the interrupt but left the macro with the Z bit
> set which means that asm_do_IRQ() does not get called.  Seems to me we
> should do the same, see the patch below.  Although, ideally, we should
> be logging these.  Is there a mechanism for doing this?

Well we should let the generic irq handler to do the logging.. But I
guess nothing will happen if adm_do_IRQ() does not get called.

We could have a dummy handler for some invented higher number that would
capture the spurious interrupts I guess.

BTW, ideally we would do the ldr conditionally rather than every time,
I guess that's the idea with the old way of doing things.

I think you could just move the old code after the spurious handling
to get the Z bit right? Or maybe there's some other way to optimize.

Tony

> 
> > Are these defines above still needed?
> 
>   Yes.
> 
>   BTW, I haven't checked this patch so don't do anything with it, just
> comment on it ;-)
> 
>  Rick
> 
> --- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-23 10:25:57.000000000 -0700
> @@ -66,7 +66,11 @@
>  #endif
>  
>  #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> -#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> +#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits offset */
> +#define INTCPS_CONTROL_NEWIRQAGR 0x0001		/* Reset IRQ output and enable new IRQ generation */
> +#define INTCPS_PENDING_IRQ_1	0x0098		/* IRQ pending reg 1 */
> +#define INTCPS_PENDING_IRQ_2	0x00b8		/* IRQ pending reg 2 */
> +#define INTCPS_PENDING_IRQ_3	0x00d8		/* IRQ pending reg 3 */
>  
>  		.macro	disable_fiq
>  		.endm
> @@ -79,18 +83,18 @@
>  
>  		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
>  		ldr	\base, =OMAP2_VA_IC_BASE
> -		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> -		cmp	\irqnr, #0x0
> -		bne	2222f
> -		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
> -		cmp	\irqnr, #0x0
> -		bne	2222f
> -		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
> -		cmp	\irqnr, #0x0
> -2222:
> -		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> -		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
> -
> +		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +		mvn	\tmp, \irqnr  /* flip MSBit */
> +		bics	\tmp, #0x80000000  /* test MSBit */
> +		moveq	\tmp, #INTCPS_CONTROL_NEWIRQAGR /* Ack the spurious irq */
> +		streq	\tmp, [\base, #INTCPS_CONTROL]
> +		beq	2223f  /* if we got a spurious interrupt, ignore it */
> +		ldr	\irqstat, [\base, #INTCPS_PENDING_IRQ_1] /* IRQ pending reg 1 */
> +		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_2] /* IRQ pending reg 2 */
> +		orr	\irqstat, \irqstat, \tmp  /* or them all together */
> +		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_3] /* IRQ pending reg 3 */
> +		orrs	\irqstat, \irqstat, \tmp  /* clear condition code Z if interrupt */
> +2223:
>  		.endm
>  
>  		.macro	irq_prio_table
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
