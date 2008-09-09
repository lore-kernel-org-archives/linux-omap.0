From: Tony Lindgren <tony@atomide.com>
Subject: Re: Changes which shouldn't be in OMAP tree
Date: Tue, 9 Sep 2008 08:25:44 -0700
Message-ID: <20080909152543.GN29054@atomide.com>
References: <20080909081213.GD9104@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49985 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbYIIPZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 11:25:56 -0400
Content-Disposition: inline
In-Reply-To: <20080909081213.GD9104@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080909 01:12]:
> Tony (and whoever looks after the omapzoom tree),
> 
> While reviewing the omapzoom tree, I came across these three changes.
> They all shouldn't be there - I think they're all merge errors.
> 
> The last one was fixed by a patch which added line 272 with the comment
> "relocate the stack".
> 
> Please take a look and revert these.

Thanks, reverted in l-o tree.

Tony

> 
> diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> index ce1c5ff..bbe9905 100644
> --- a/arch/arm/boot/.gitignore
> +++ b/arch/arm/boot/.gitignore
> @@ -1,5 +1,5 @@
>  Image
>  zImage
> +uImage
>  xipImage
>  bootpImage
> -uImage
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 3c2c8f2..32be061 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -55,7 +55,7 @@
>  #elif defined(CONFIG_ARCH_S3C2410)
>  		.macro loadsp, rb
>  		mov	\rb, #0x50000000
> -		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
> +		add	\rb, \rb, #0x4000 * CONFIG_S3C2410_LOWLEVEL_UART_PORT
>  		.endm
>  #else
>  		.macro	loadsp,	rb
> @@ -782,6 +782,7 @@ __armv7_mmu_cache_flush:
>  		mcr	p15, 0, r10, c7, c14, 0	@ clean+invalidate D
>  		b	iflush
>  hierarchical:
> +		adr	sp, no_cache_id		@ non-v7 code is temp stack
>  		stmfd	sp!, {r0-r5, r7, r9-r11}
>  		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
>  		ands	r3, r0, #0x7000000	@ extract loc from clidr
> 
