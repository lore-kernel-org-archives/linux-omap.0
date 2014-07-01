From: Stephen Warren <swarren@nvidia.com>
Subject: RE: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Tue, 1 Jul 2014 16:14:30 +0000
Message-ID: <5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com>
References: <53B284AE.3070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <53B284AE.3070302@ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

Sekhar Nori wrote at Tuesday, July 01, 2014 3:52 AM:
> Nick,
> 
> I have been using your for-next branch to base my development of
> touchscreen support on TI's DRA7x EVM. With the recent updates,
> it has worked out great and once I got the configuration right,
> it was just a question of adding DT data for the platform.
> 
> Now, there is one problem with Stephen's patch defaulting the irqflags
> to IRQF_TRIGGER_FALLING. The interrupt controller I am using (ARM GIC)
> does not seem to support that and the device fails to probe:

On the Tegra systems I have, IRQF_TRIGGER_FALLING is the correct (or at
least a valid) choice. That's probably because the Atmel IRQ signal is
routed to our GPIO controller, which is also an IRQ controller, and then
"forwarded" up the chain to the GIC, with the polarity the GIC expects.

If IRQ_TRIGGER_FALLING doesn't work everywhere, then we'll need to add
some kind of DT property to configure the polarity of the IRQ output.

> [    1.932798] genirq: Setting trigger mode 2 for irq 151 failed (gic_set_type+0x0/0xf0)
> [    1.941340] atmel_mxt_ts 0-004a: Failed to register interrupt
> [    1.947452] atmel_mxt_ts: probe of 0-004a failed with error -22
> 
> Attached patch does the trick for me:
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 71154c2..f2d3f72 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3155,9 +3155,6 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  	pdata->gpio_reset = of_get_named_gpio_flags(dev->of_node,
>  		"atmel,reset-gpio", 0, NULL);
> 
> -	/* Default to this. Properties can be added to configure it later */
> -	pdata->irqflags = IRQF_TRIGGER_FALLING;
> -
>  	of_property_read_string(dev->of_node, "atmel,cfg_name",
>  				&pdata->cfg_name);
> 
> Can you switch to leaving the platform to specify flags (at least for the DT case)?
> 
> Thanks,
> Sekhar

-- 
nvpublic

