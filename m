From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 14 Feb 2011 15:15:31 -0800
Message-ID: <87zkpyxl64.fsf@ti.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
	<87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
	<alpine.LFD.2.00.1102140950580.14920@xanadu.home>
	<20110214153726.GA20144@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60754 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab1BNXP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 18:15:58 -0500
Received: by pxi12 with SMTP id 12so1176333pxi.0
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 15:15:56 -0800 (PST)
In-Reply-To: <20110214153726.GA20144@arm.com> (Dave Martin's message of "Mon,
	14 Feb 2011 15:37:26 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

Hi Dave,

Dave Martin <dave.martin@linaro.org> writes:

> On Mon, Feb 14, 2011 at 10:00:23AM -0500, Nicolas Pitre wrote:
>> On Mon, 14 Feb 2011, Dave Martin wrote:
>> 
>> > @@ -289,8 +297,20 @@ clean_l2:
>> >  	 *  - should be faster and will change with kernel
>> >  	 *  - 'might' have to copy address, load and jump to it
>> >  	 */
>> > +#ifdef CONFIG_THUMB2_KERNEL
>> > +	/* kernel is non-interworking : must do this from Thumb */
>> > +	adr	r1, . + 1
>> > +	bx	r1
>> > +	.thumb
>> > +#endif
>> >  	ldr	r1, kernel_flush
>> 
>> Didn't you mean this instead:
>> 
>> 	/* kernel is non-interworking : must do this from Thumb */
>> 	adr	r1, 1f + 1
>> 	bx	r1
>> 	.thumb
>> 1:	ldr	r1, kernel_flush
>> 	...
>
> Note that this is intended as an experimental hack, not a real patch
> (apologies if I didn't make that clear...)
>
> Well, actually I meant "add r1, pc, #1" ... which means I was too
> busy trying to be clever... oops!
>
> That is of course exactly equivalent to your code...
>
>> 
>> ?
>> 
>> >  	blx	r1
>> > +#ifdef CONFIG_THUMB2_KERNEL
>> > +	.align
>> > +	bx	pc
>> > +	nop
>> > +	.arm
>> 
>> Also here, the .align has the potential to introduce a zero halfword in 
>> the instruction stream before the bx.  What about:
>> 
>> 	adr	r3, 1f
>> 	bx	r3
>> 	.align
>> 	.arm
>> 1:	...
>
> .align inserts a 16-bit nop when misaligned in Thumb in a text section,
> and a word-aligned bx pc is a specific architecturally allowed way
> to do an inline switch to ARM.  The linker uses this trick for PLT
> veneers etc.
>
> A nicer fix for doing this sort of call from low-level code which
> might be ARM is to convert arch/arm/mm/*-v7.S to use "bx lr" to return.
>
> Generally, we can do this for all arches >= v5, without any
> incompatibility.  However, since the need for it will be rare and it
> will generate patch noise for not much real benefit,
> I haven't proposed this.
>
> Updated patch below.

I tested the updated patch on top of your "dirty" branch I tested with
last week, and now see off-mode working just fine.

Kevin

> Cheers
> ---Dave
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index a204c78..6ae8a92 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -32,6 +32,14 @@
>  #include "sdrc.h"
>  #include "control.h"
>  
> +#undef ARM
> +#undef THUMB
> +#undef BSYM
> +#define ARM(x...) x
> +#define THUMB(x...)
> +#define BSYM(x) (x)
> +	.arm
> +
>  /*
>   * Registers access definitions
>   */
> @@ -289,8 +297,20 @@ clean_l2:
>  	 *  - should be faster and will change with kernel
>  	 *  - 'might' have to copy address, load and jump to it
>  	 */
> -	ldr	r1, kernel_flush
> +#ifdef CONFIG_THUMB2_KERNEL
> +	/* kernel is non-interworking : must do this from Thumb */
> +	adr	r1, 1f + 1
> +	bx	r1
> +	.thumb
> +#endif
> +1:	ldr	r1, kernel_flush
>  	blx	r1
> +#ifdef CONFIG_THUMB2_KERNEL
> +	.align
> +	bx	pc
> +	nop
> +	.arm
> +#endif
>  
>  omap3_do_wfi:
>  	ldr	r4, sdrc_power		@ read the SDRC_POWER register
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 829d235..64faab8 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -34,6 +34,14 @@
>  #include "sdrc.h"
>  #include "cm2xxx_3xxx.h"
>  
> +#undef ARM
> +#undef THUMB
> +#undef BSYM
> +#define ARM(x...) x
> +#define THUMB(x...)
> +#define BSYM(x) (x)
> +	.arm
> +
>  	.text
>  
>  /* r1 parameters */
