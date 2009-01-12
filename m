From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request line > 63, v2
Date: Mon, 12 Jan 2009 16:16:29 +0000
Message-ID: <20090112161629.GC6152@n2100.arm.linux.org.uk>
References: <20090112144453.24205.18451.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com> <20090112153526.GN9373@atomide.com> <20090112160114.GB6152@n2100.arm.linux.org.uk> <20090112161052.GO9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50650 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZALQQo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 11:16:44 -0500
Content-Disposition: inline
In-Reply-To: <20090112161052.GO9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 12, 2009 at 06:10:53PM +0200, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090112 18:01]:
> > On Mon, Jan 12, 2009 at 05:35:28PM +0200, Tony Lindgren wrote:
> > > Well at least you could remove some parens.
> > > How about (dma_trigger / 32) << 19 instead?
> > 
> > Oh, and further to my previous reply there is also the general principle
> > of writing what you mean.  So, if you mean to clear the least significant
> > 5 bits, write it as a mask with ~0x1f, not as a divide.
> > 
> > And no, you don't need ~(0x1f) - the parens there are pure noise.  ~0x1f
> > does just as well and isn't in any way confusing to the compiler.
> > To put it another way, parens around a single value are completely
> > meaningless.
> 
> Here's this one with the extra parens removed.

If you're concerned about useless parens, then...

> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 692d2b4..660a4eb 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -279,10 +279,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
>  
>  		val = dma_read(CCR(lch));
>  		val &= ~(3 << 19);
> -		if (dma_trigger > 63)
> -			val |= 1 << 20;
> -		if (dma_trigger > 31)
> -			val |= 1 << 19;
> +		val |= ((dma_trigger & ~0x1f) << 14);
>  
>  		val &= ~(0x1f);
>  		val |= (dma_trigger & 0x1f);

should change to:

		val = dma_read(CCR(lch));
		val &= ~(3 << 19);
		val |= (dma_trigger & ~0x1f) << 14;

		val &= ~0x1f;
		val |= dma_trigger & 0x1f;
