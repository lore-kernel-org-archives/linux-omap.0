From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/10] omap: Use separate init_irq functions to avoid
	cpu_is_omap tests early
Date: Mon, 20 Jun 2011 10:54:45 +0100
Message-ID: <20110620095445.GB2082@n2100.arm.linux.org.uk>
References: <20110620091754.357.56441.stgit@kaulin> <20110620092327.357.92354.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37059 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab1FTJy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:54:59 -0400
Content-Disposition: inline
In-Reply-To: <20110620092327.357.92354.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Mon, Jun 20, 2011 at 02:23:28AM -0700, Tony Lindgren wrote:
>  void __init gic_init_irq(void)
>  {
> -	void __iomem *gic_cpu_base;
> -
>  	/* Static mapping, never released */
>  	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
>  	BUG_ON(!gic_dist_base_addr);
>  
>  	/* Static mapping, never released */
> -	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> -	BUG_ON(!gic_cpu_base);
> +	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> +	BUG_ON(!omap_irq_base);
>  
> -	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
> +	gic_init(0, 29, gic_dist_base_addr, omap_irq_base);

Why do you change this?  Nothing should be using 'omap_irq_base' directly
because it doesn't know what type of interrupt controller you have.

The GIC IRQ entry code should be using gic_cpu_base_addr provided by the
common gic driver rather than anything else.
