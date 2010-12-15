From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
Date: Tue, 14 Dec 2010 16:55:49 -0800
Message-ID: <87aak7onvu.fsf@deeprootsystems.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-8-git-send-email-manjugk@ti.com>
	<87d3p3q35h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:51081 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760271Ab0LOAzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 19:55:55 -0500
Received: by gwb20 with SMTP id 20so1051587gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 16:55:54 -0800 (PST)
In-Reply-To: <87d3p3q35h.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Tue, 14 Dec 2010 16:40:42 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

[...]

>
> Using the patch below which fixes up the interrupt numbers to match the
> original code, the memory-to-memory test is now working on OSK.

Tony, if you prefer just to fold this into the original, feel free to
add

[khilman@deeprootsystems.com]: fixed IRQ numbers to match original code
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>


> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 17814e0..d855934 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -121,58 +121,58 @@ static struct resource res[] __initdata = {
>  	/* Handled in lcd_dma.c */
>  	[7] = {
>  		.name   = "6",
> -		.start  = INT_DMA_LCD,
> +		.start  = INT_1610_DMA_CH6,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	/* irq's for omap16xx and omap7xx */
>  	[8] = {
>  		.name   = "7",
> -		.start  = 53 + IH2_BASE,
> +		.start  = INT_1610_DMA_CH7,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	[9] = {
>  		.name   = "8",
> -		.start  = 54 + IH2_BASE,
> +		.start  = INT_1610_DMA_CH8,
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  	[10] = {
>  		.name  = "9",
> -		.start = 55 + IH2_BASE,
> +		.start = INT_1610_DMA_CH9,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[11] = {
>  		.name  = "10",
> -		.start = 56 + IH2_BASE,
> +		.start = INT_1610_DMA_CH10,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[12] = {
>  		.name  = "11",
> -		.start = 57 + IH2_BASE,
> +		.start = INT_1610_DMA_CH11,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[13] = {
>  		.name  = "12",
> -		.start = 58 + IH2_BASE,
> +		.start = INT_1610_DMA_CH12,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[14] = {
>  		.name  = "13",
> -		.start = 59 + IH2_BASE,
> +		.start = INT_1610_DMA_CH13,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[15] = {
>  		.name  = "14",
> -		.start = 60 + IH2_BASE,
> +		.start = INT_1610_DMA_CH14,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[16] = {
>  		.name  = "15",
> -		.start = 61 + IH2_BASE,
> +		.start = INT_1610_DMA_CH15,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  	[17] = {
>  		.name  = "16",
> -		.start = 62 + IH2_BASE,
> +		.start = INT_DMA_LCD,
>  		.flags = IORESOURCE_IRQ,
>  	},
>  };
