From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Fri, 18 Jan 2013 09:15:01 -0800
Message-ID: <20130118171500.GC15361@atomide.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33901 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424Ab3ARRPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 12:15:05 -0500
Content-Disposition: inline
In-Reply-To: <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

Hi,

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130118 07:30]:
> From: Benoit Cousson <b-cousson@ti.com>
> 
> Adding the hwmod data for OMAP54xx platforms.
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +/* bb2d */
> +static struct omap_hwmod_irq_info omap54xx_bb2d_irqs[] = {
> +	{ .irq = 125 + OMAP54XX_IRQ_GIC_START },
> +	{ .irq = -1 }
> +};
...

> +/* c2c */
> +static struct omap_hwmod_irq_info omap54xx_c2c_irqs[] = {
> +	{ .irq = 88 + OMAP54XX_IRQ_GIC_START },
> +	{ .irq = -1 }
> +};
...


> +static struct omap_hwmod_dma_info omap54xx_c2c_sdma_reqs[] = {
> +	{ .dma_req = 68 + OMAP54XX_DMA_REQ_START },
> +	{ .dma_req = -1 }
> +};



> +static struct omap_hwmod_addr_space omap54xx_elm_addrs[] = {
> +	{
> +		.pa_start	= 0x48078000,
> +		.pa_end		= 0x48078fff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{ }
> +};
...

> +static struct omap_hwmod_addr_space omap54xx_emif1_addrs[] = {
> +	{
> +		.pa_start	= 0x4c000000,
> +		.pa_end		= 0x4c0003ff,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{ }
> +};

As discussed earlier on this list, let's not duplicate the standard
resources here as they already are supposed to come from device tree.

Whatever issues prevent us from dropping the duplicate data here need
to be fixed. I believe Benoit already had some scripts/patches for
that and was just waiting for the DMA binding to get merged?

Regards,

Tony
