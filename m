From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 14 Feb 2011 10:00:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102140950580.14920@xanadu.home>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org> <87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44062 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab1BNPA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 10:00:27 -0500
Received: by vxb37 with SMTP id 37so2664840vxb.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 07:00:26 -0800 (PST)
In-Reply-To: <20110214131750.GA2869@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

On Mon, 14 Feb 2011, Dave Martin wrote:

> @@ -289,8 +297,20 @@ clean_l2:
>  	 *  - should be faster and will change with kernel
>  	 *  - 'might' have to copy address, load and jump to it
>  	 */
> +#ifdef CONFIG_THUMB2_KERNEL
> +	/* kernel is non-interworking : must do this from Thumb */
> +	adr	r1, . + 1
> +	bx	r1
> +	.thumb
> +#endif
>  	ldr	r1, kernel_flush

Didn't you mean this instead:

	/* kernel is non-interworking : must do this from Thumb */
	adr	r1, 1f + 1
	bx	r1
	.thumb
1:	ldr	r1, kernel_flush
	...

?

>  	blx	r1
> +#ifdef CONFIG_THUMB2_KERNEL
> +	.align
> +	bx	pc
> +	nop
> +	.arm

Also here, the .align has the potential to introduce a zero halfword in 
the instruction stream before the bx.  What about:

	adr	r3, 1f
	bx	r3
	.align
	.arm
1:	...


Nicolas
