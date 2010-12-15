From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v1 3/9] OMAP2420: hwmod data: add system DMA
Date: Tue, 14 Dec 2010 19:25:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com> <1291434246-30716-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab0LOCZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 21:25:24 -0500
In-Reply-To: <1291434246-30716-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manju

On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:

> Add OMAP2420 DMA hwmod data and also add required
> DMA device attributes.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> +/* dma_system -> L3 */
> +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> +	.master		= &omap2420_dma_system_hwmod,
> +	.slave		= &omap2420_l3_main_hwmod,
> +	.clk		= "l3_div_ck",

This clock does not exist on OMAP2420.  Did you test this patch on 2420?

> +/* l4_cfg -> dma_system */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_dma_system_hwmod,
> +	.clk		= "l4_div_ck",

Nor does this clock exist on OMAP2420.

> +static struct omap_hwmod omap2420_dma_system_hwmod = {
> +	.name		= "dma",
> +	.class		= &omap2420_dma_hwmod_class,
> +	.mpu_irqs	= omap2420_dma_system_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dma_system_irqs),
> +	.main_clk	= "l3_div_ck",

And neither does this one.

Please fix these and test on OMAP2420 before sending the fixed patches.


- Paul
