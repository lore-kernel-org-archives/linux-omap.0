From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt
	bits
Date: Thu, 23 Oct 2008 08:43:46 -0700
Message-ID: <20081023154346.GB2994@atomide.com>
References: <E1KsqtQ-0005Xb-EV@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62730 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbYJWPnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 11:43:50 -0400
Content-Disposition: inline
In-Reply-To: <E1KsqtQ-0005Xb-EV@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

* Rick Bronson <rick@efn.org> [081022 20:30]:
> Tony,
> 
>   Here is the patch against the latest git.  I'm a little concerned
> about masking the interrupt number so that the spurious bit are
> ignored.  Do you really want to turn a spurious interrupt into a
> normal (good) interrupt?

No, but having the spurious data mess up the irqnr really confuses
things :)

> > Also, AFAIK we don't have infinitely repeating irqs any longer, it's
> > just an occasional single spurious interrupt.
> 
>   That's correct.  And those disappeared when I applied the S-O patch.
> Without the S-O patch I was seeing one spurious interrupt in about 15
> reboots, after the patch I got zero in 350 reboots.

Yeah so let's update the comment below.

>   Rick
> 
> --- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-22 20:11:26.000000000 -0700
> @@ -67,6 +67,10 @@
>  
>  #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
>  #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> +#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits */
> +#define INTCPS_PENDING_IRQ_1	0x0098		/* IRQ pending reg 1 */
> +#define INTCPS_PENDING_IRQ_2	0x00b8		/* IRQ pending reg 2 */
> +#define INTCPS_PENDING_IRQ_3	0x00d8		/* IRQ pending reg 3 */
>  
>  		.macro	disable_fiq
>  		.endm
> @@ -79,18 +83,20 @@

Are these defines above still needed?


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
> +		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +		cmp	\irqnr, #0  /* check for negative */
> +		movmi	\tmp, #0x1 /* Ack the spurious irq, this lets it
> +					* generate a bad irq error message,
> +					* but prevents infinitely repeating
> +					* irq.
> +					*/
> +		strmi	\tmp, [\base, #INTCPS_CONTROL]
>  		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */

How about remove the comment for movmi above, and have just a comment
like /* ack spurious irq */ for the strmi instead?

Tony
