From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v1 4/9] OMAP2430: hwmod data: add system DMA
Date: Tue, 14 Dec 2010 19:27:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141925300.15971@utopia.booyaka.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com> <1291434246-30716-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53554 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0LOC1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 21:27:34 -0500
In-Reply-To: <1291434246-30716-5-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:

> Add OMAP2430 DMA hwmod data and also add required
> DMA device attributes.

...

> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
> +	.master		= &omap2430_dma_system_hwmod,
> +	.slave		= &omap2430_l3_main_hwmod,
> +	.clk		= "l3_div_ck",

This clock does not exist on OMAP2430.  Did you test this on OMAP2430?

> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
> +	.master		= &omap2430_l4_core_hwmod,
> +	.slave		= &omap2430_dma_system_hwmod,
> +	.clk		= "l4_div_ck",

This clock also does not exist on OMAP2430.

> +static struct omap_hwmod omap2430_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap2430_dma_hwmod_class,
> +	.mpu_irqs	= omap2430_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",

Nor does this one.

Please fix these and test on OMAP2430 before resending.


- Paul
