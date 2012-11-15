From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Thu, 15 Nov 2012 09:22:42 +0000
Message-ID: <20121115092242.GF3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk> <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com> <20121114222159.GB6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42723 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946038Ab2KOJXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 04:23:00 -0500
Content-Disposition: inline
In-Reply-To: <20121114222159.GB6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robherring2@gmail.com>, Dave Martin <dave.martin@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 14, 2012 at 02:21:59PM -0800, Tony Lindgren wrote:
> No idea if assuming that zero value for the diagnostic register
> is safe.. What's the default value of the diagnostic register supposed
> to be?

No, that's not safe.  What if your pre-kernel code has asked the secure
monitor to set the work-around bit already?

>  #if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
>  	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
>  	ALT_UP_B(1f)
> -	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
> -	orrlt	r10, r10, #1 << 11		@ set bit #11
> -	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
> +	bge	1f				@ not needed for r3p0 and later
> +	mrc	p15, 0, r10, c15, c0, 1		@ read diagnostic register
> +	teq	r10, #0				@ zero for secure mode?
> +	beq	1f				@ bail out for secure mode

This test for zero is pointless.  What if some other work-around has
been enabled but not this one?

> +	tst	r10, #1 << 11			@ bit #11 already set?
> +	orreq	r10, r10, #1 << 11		@ set bit #11 if not set
> +	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
>  1:
>  #endif
>  
