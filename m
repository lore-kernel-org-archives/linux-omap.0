From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v5 1/3] omap: dma: Fix buffering disable bit setting for
 omap24xx
Date: Tue, 5 Oct 2010 15:11:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB9FE7F9@dbde02.ent.ti.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286261141-1039-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54355 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535Ab0JEJlj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 05:41:39 -0400
In-Reply-To: <1286261141-1039-2-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Tuesday, October 05, 2010 12:16 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel@lists.infradead.org; Russell King
> Subject: [PATCH v5 1/3] omap: dma: Fix buffering disable bit 
> setting for omap24xx
> 
> From: Jarkko Nikula <jhnikula@gmail.com>
...
>  
>  	/*
> -	 * Errata: On ES2.0 BUFFERING disable must be set.
> -	 * This will always fail on ES1.0
> +	 * Errata: Inter Frame DMA buffering issue (All OMAP2420 and
> +	 * OMAP2430ES1.0): DMA will wrongly buffer elements if 
> packing and
> +	 * bursting is enabled. This might result in data gets 
> stalled in
> +	 * FIFO at the end of the block.
> +	 * Workaround: DMA channels must have 
> BUFFERING_DISABLED bit set to
> +	 * guarantee no data will stay in the DMA FIFO in case 
> inter frame
> +	 * buffering occurs.
>  	 */
> -	if (cpu_is_omap24xx())
> -		l |= OMAP_DMA_CCR_EN;
> +	if (cpu_is_omap2420() ||
> +	    (cpu_is_omap2430() && (omap_type() == OMAP2430_REV_ES1_0)))
> +		l |= OMAP_DMA_CCR_BUFFERING_DISABLE;

Acked-by: G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath