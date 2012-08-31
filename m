From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] omap-i2c: fix incorrect log message when using a device
 tree
Date: Fri, 31 Aug 2012 14:36:28 +0200
Message-ID: <5040AFCC.5060004@ti.com>
References: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45852 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2HaMg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 08:36:56 -0400
In-Reply-To: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>

On 08/31/2012 01:02 PM, Florian Vaussard wrote:
> When booting using a device tree, the adapter number is dynamically
> assigned after the log message is sent.
> This patch modifies the log message to get a correct adapter id.
> 
> Applies on 3.6-rc3. Tested on OMAP3 (Gumstix Overo).

Thanks for the fix. Tested successfully on OMAP4 SDP DT boot as well.

[    0.000000] Linux version 3.6.0-rc3-00030-g491038d (bcousson@lnwes3201) (gcc version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #6 SMP Fri Aug 31 13:50:48 CEST 2012
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model: TI OMAP4 SDP board
...
[    0.667205] omap_i2c i2c.15: bus 0 rev2.4.0 at 400 kHz
...
[    0.768341] omap_i2c i2c.16: bus 1 rev2.4.0 at 400 kHz
[    0.783905] omap_i2c i2c.17: bus 2 rev2.4.0 at 400 kHz
[    0.799530] omap_i2c i2c.18: bus 3 rev2.4.0 at 400 kHz


> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Tested-by: Benoit Cousson <b-cousson@ti.com>
and
Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit


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
> 

