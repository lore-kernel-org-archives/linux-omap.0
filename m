From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Wed, 9 Jul 2014 02:08:51 -0700
Message-ID: <20140709090851.GI28884@atomide.com>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37554 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaGIJIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 05:08:51 -0400
Content-Disposition: inline
In-Reply-To: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Praveen Rao <prao@ti.com>

Hi,

Can you please check the comments below so we don't have to
add duplicate data just to remove it later on.

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140708 11:43]:
> +
> +static struct omap_hwmod_irq_info dra7xx_gmac_irqs[] = {
> +	{ .name = "c0_rx_thresh_pend", .irq = 50 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_rx_pend", .irq = 51 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_tx_pend", .irq = 52 + DRA7XX_IRQ_GIC_START, },
> +	{ .name = "c0_misc_pend", .irq = 53 + DRA7XX_IRQ_GIC_START, },
> +	{ .irq = -1 },
> +};

Why do we need the interrupts here? They should be coming
from the .dts files? Is this numbering with or without
the crossbar?

> +static struct omap_hwmod_addr_space dra7xx_gmac_addr_space[] = {
> +	/* cpsw ss */
> +	{
> +		.pa_start	= 0x48484000,
> +		.pa_end	= 0x48484000 + SZ_2K - 1,
> +	},
> +	/* cpsw wr */
> +	{
> +		.pa_start	= 0x48485200,
> +		.pa_end	= 0x48485200 + SZ_256 - 1,
> +		.flags	= ADDR_TYPE_RT,
> +	},
> +	{ }
> +};

Also for the IO range, this should be coming from the .dts
files now?

> +static struct omap_hwmod_addr_space dra7xx_mdio_addr_space[] = {
> +	{
> +		.pa_start	= 0x48485000,
> +		.pa_end		= 0x48485000 + SZ_256 - 1,
> +	},
> +	{ }
> +};

Here too?

Regards,

Tony
