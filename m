From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/12] ARM: DRA7: hwmod: Create initial DRA7XX SoC data
Date: Tue, 9 Jul 2013 01:31:53 -0700
Message-ID: <20130709083152.GC5523@atomide.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
 <1373355139-12487-10-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53175 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3GIIb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 04:31:57 -0400
Content-Disposition: inline
In-Reply-To: <1373355139-12487-10-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Tero Kristo <t-kristo@ti.com>

* Rajendra Nayak <rnayak@ti.com> [130709 00:39]:
> From: Ambresh K <ambresh@ti.com>

> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
...

> +/* dma_system */
> +static struct omap_hwmod_irq_info dra7xx_dma_system_irqs[] = {
> +	{ .name = "0", .irq = 12 + DRA7XX_IRQ_GIC_START },
> +	{ .name = "1", .irq = 13 + DRA7XX_IRQ_GIC_START },
> +	{ .name = "2", .irq = 14 + DRA7XX_IRQ_GIC_START },
> +	{ .name = "3", .irq = 15 + DRA7XX_IRQ_GIC_START },
> +	{ .irq = -1 }
> +};

I think these should no longer be needed?

In general, we must move the hwmod stuff to drivers/bus and start
parsing the data from device tree along the lines Tero is doing
for the clock data.

What's the plan for doing that?

Regards,

Tony
