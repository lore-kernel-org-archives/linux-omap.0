From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-omap: Fix incorrect adapter id when booting from
 a device tree
Date: Fri, 31 Aug 2012 11:14:20 +0200
Message-ID: <5040806C.9080003@ti.com>
References: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch> <1346399575-7285-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346399575-7285-2-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, =?ISO-8859-1?Q?Philippe_R=E9torn?= =?ISO-8859-1?Q?az?= <philippe.retornaz-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Florian,

On 08/31/2012 09:52 AM, Florian Vaussard wrote:
> When booting from a device tree, the omap driver is using pdev->id,
> which is incorrect. 

Not really, see below...

> The proposed patch uses aliases, as done in omap-serial.

Mmm, but is it really needed?
In the case of serial the id is important because of the tty number used
as device interface.
In the case of I2C, the id is mostly irrelevant.

In fact, using the pdev->id = -1 was used on purpose to have a dynamic
assignment:

int i2c_add_numbered_adapter(struct i2c_adapter *adap)
...
        if (adap->nr == -1) /* -1 means dynamically assign bus id */
                return i2c_add_adapter(adap);

> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d19a49..9445d1f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1064,9 +1064,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> -	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
> -		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> -

[    0.658843] omap_i2c i2c.15: bus -1 rev2.4.0 at 400 kHz
[    0.760192] omap_i2c i2c.16: bus -1 rev2.4.0 at 400 kHz
[    0.775817] omap_i2c i2c.17: bus -1 rev2.4.0 at 400 kHz
[    0.791442] omap_i2c i2c.18: bus -1 rev2.4.0 at 400 kHz

OK, it is true that the current log is not that nice with bus -1, but
maybe we should just remove that.

Or we can potentially retrieve the i2c adapter number assign later, and
delay the log.

>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(dev->dev, "failure adding adapter\n");


Regards,
Benoit


>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> @@ -1076,8 +1073,22 @@ omap_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  
> +	if (adap->dev.of_node)
> +		adap->nr = of_alias_get_id(adap->dev.of_node, "i2c");
> +	else
> +		adap->nr = pdev->id;
> +
> +	if (adap->nr < 0) {
> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
> +				adap->nr);
> +		r = -ENODEV;
> +		goto err_free_irq;
> +	}
> +
> +	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> +		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
> +
>  	/* i2c device drivers may be active on return from add_adapter() */
> -	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(dev->dev, "failure adding adapter\n");
> 
