From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init function
Date: Wed, 13 Jul 2011 22:56:08 -0700
Message-ID: <20110714055608.GA22467@google.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
 <1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:20503 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab1GNF42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 01:56:28 -0400
Content-Disposition: inline
In-Reply-To: <1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Wed, Jul 13, 2011 at 07:24:12PM +0530, Tarun Kanti DebBarma wrote:
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().
> 
...
> -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> +		pdev = omap16xx_gpio_dev[i];
> +		pdata = pdev->dev.platform_data;
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		base = ioremap(res->start, resource_size(res));


Should check platform_get_resource and ioremap error returns.

> +
> +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);


Todd
