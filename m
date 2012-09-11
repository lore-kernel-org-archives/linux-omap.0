From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] omap-i2c: fix incorrect log message when using a device
 tree
Date: Tue, 11 Sep 2012 14:58:00 +0530
Message-ID: <504F0420.1020005@ti.com>
References: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:43029 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756668Ab2IKJ2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:28:07 -0400
Received: by obbuo13 with SMTP id uo13so405139obb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 02:28:06 -0700 (PDT)
In-Reply-To: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Benoit Cousson <b-cousson@ti.com>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>

On Friday 31 August 2012 04:32 PM, Florian Vaussard wrote:
> When booting using a device tree, the adapter number is dynamically
> assigned after the log message is sent.
> This patch modifies the log message to get a correct adapter id.
>
> Applies on 3.6-rc3. Tested on OMAP3 (Gumstix Overo).
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Looks good to me.

Acked-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d19a49..136b4fe 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1064,9 +1064,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> -	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
> -		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> -
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> @@ -1084,6 +1081,9 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  	}
>  
> +	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> +		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> +
>  	of_i2c_register_devices(adap);
>  
>  	pm_runtime_put(dev->dev);

