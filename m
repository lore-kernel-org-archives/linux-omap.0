From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
Date: Thu, 21 Jul 2011 11:52:36 -0700
Message-ID: <1311274356.8322.98.camel@vence>
References: <1311269976-4035-1-git-send-email-khilman@ti.com>
	 <20110721174306.GD32058@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:49010 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753212Ab1GUSwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 14:52:40 -0400
Received: by mail-iw0-f177.google.com with SMTP id 35so1329003iwn.8
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 11:52:39 -0700 (PDT)
In-Reply-To: <20110721174306.GD32058@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Thu, 2011-07-21 at 20:43 +0300, Felipe Balbi wrote:
> On Thu, Jul 21, 2011 at 10:39:36AM -0700, Kevin Hilman wrote:
> > For consistency in kernel printk output for devices, use dev_dbg(),
> > dev_warn(), dev_err() instead of pr_debug(), pr_warning() and
> > pr_err(), some of which currently use direct access of name from
> > platform_device and others of which use dev_name().  Using the dev_*
> > versions uses the standard device naming from the driver core.
> > 
> > Some pr_* prints were not converted with this patch since they are
> > used before the platform_device and struct device are created so
> > neither the dev_* prints or dev_name() is valid.
> > 
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> 
> FWIW:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks.

> BTW, I tried applying this to today's linus/master, but it fails
> (rejects below), are you depending on some other changes ?

Oops, I forgot to mention it applies on top of a bunch of stuff queued
for v3.1.  Specifically, it's on top of Paul's prcm-devel-3.1 branch[1],
which Arnd has merged into the arm-soc tree.

Kevin

[1] git://git.pwsan.com/linux-2.6 prcm-devel-3.1

> --- arch/arm/plat-omap/omap_device.c
> +++ arch/arm/plat-omap/omap_device.c
> @@ -242,28 +239,27 @@
>  	if (!clk_alias || !clk_name)
>  		return;
>  
> -	pr_debug("omap_device: %s: Creating %s -> %s\n",
> -		 dev_name(&od->pdev.dev), clk_alias, clk_name);
> +	dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias, clk_name);
>  
>  	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
>  	if (!IS_ERR(r)) {
> -		pr_warning("omap_device: %s: alias %s already exists\n",
> -			   dev_name(&od->pdev.dev), clk_alias);
> +		dev_warn(&od->pdev.dev,
> +			 "alias %s already exists\n", clk_alias);
>  		clk_put(r);
>  		return;
>  	}
>  
>  	r = omap_clk_get_by_name(clk_name);
>  	if (IS_ERR(r)) {
> -		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
> -		       dev_name(&od->pdev.dev), clk_name);
> +		dev_err(&od->pdev.dev,
> +			"omap_clk_get_by_name for %s failed\n", clk_name);
>  		return;
>  	}
>  
>  	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
>  	if (!l) {
> -		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
> -		       dev_name(&od->pdev.dev), clk_alias);
> +		dev_err(&od->pdev.dev,
> +			"clkdev_alloc for %s failed\n", clk_alias);
>  		return;
>  	}
>  
> 


