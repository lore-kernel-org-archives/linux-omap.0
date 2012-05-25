From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv9 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable and disable
Date: Fri, 25 May 2012 14:57:24 -0700
Message-ID: <87wr3zkjp7.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
	<1335969135-20858-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:60282 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755702Ab2EYV5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 17:57:25 -0400
Received: by pbbrq8 with SMTP id rq8so2745891pbb.21
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 14:57:24 -0700 (PDT)
In-Reply-To: <1335969135-20858-3-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Rajendra Nayak <rnayak@ti.com>

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the i2c driver calls the pm_runtime_enable and never
> the disable. This may cause a warning when pm_runtime_enable
> checks for the count match.Attempting to fix the same by calling
> pm_runtime_disable in the error and the remove path.

Looks right.

Can you be more specific in the changelog about when the errors/warning
happens?  e.g. why pm_runtime_enable() is called again?  Is this on
module unload/reload?

Other than that

Acked-by: Kevin Hilman <khilman@ti.com>


> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4f4188d..c851672 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1090,6 +1090,7 @@ err_unuse_clocks:
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  	pm_runtime_put(dev->dev);
>  	iounmap(dev->base);
> +	pm_runtime_disable(&pdev->dev);
>  err_free_mem:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(dev);
> @@ -1110,6 +1111,7 @@ omap_i2c_remove(struct platform_device *pdev)
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	pm_runtime_disable(&pdev->dev);
>  	iounmap(dev->base);
>  	kfree(dev);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
