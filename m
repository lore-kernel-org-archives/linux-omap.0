From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] power: bq24190_charger: Call enable_irq() only at
 the end of probe()
Date: Thu, 12 Jan 2017 12:58:11 -0800
Message-ID: <20170112205811.GJ2630@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-2-tony@atomide.com>
 <20170112174435.fotlw2mrif4oubdt@earth>
 <CAKvHMgRq3r-6dFTXdJcrUD94BvMzq6w8RRQFgodwoBX3uAZUKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgRq3r-6dFTXdJcrUD94BvMzq6w8RRQFgodwoBX3uAZUKw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170112 12:25]:
> On Thu, Jan 12, 2017 at 9:44 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi Liam & Tony,
> >
> > On Wed, Jan 11, 2017 at 04:41:49PM -0800, Tony Lindgren wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> The device specific data is not fully initialized after
> >> request_threaded_irq().
> >>
> >> This causes problems when the IRQ handler tries to reference them.
> >> Fix the issue by enabling IRQ only at the end of the probe.
> >>
> >> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
> >> Battery Charger")
> >> Cc: Mark A. Greer <mgreer@animalcreek.com>
> >> Cc: Matt Ranostay <matt@ranostay.consulting>
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> [tony@atomide.com: cleaned up patch description a bit]
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  drivers/power/supply/bq24190_charger.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> >> --- a/drivers/power/supply/bq24190_charger.c
> >> +++ b/drivers/power/supply/bq24190_charger.c
> >> @@ -1392,6 +1392,7 @@ static int bq24190_probe(struct i2c_client *client,
> >>               return -EINVAL;
> >>       }
> >>
> >> +     irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
> >>       ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
> >>                       bq24190_irq_handler_thread,
> >>                       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> >> @@ -1436,6 +1437,8 @@ static int bq24190_probe(struct i2c_client *client,
> >>               goto out4;
> >>       }
> >>
> >> +     enable_irq(bdi->irq);
> >> +
> >>       return 0;
> >>
> >>  out4:
> >
> > Can't you just move the irq request towards the end of the probe?
> > That way it will also be released before the power-supply structure
> > is released.
> 
> I did that in a first draft I showed Tony. He suggested this way.
> Tony, rationale?

Both will work for me just fine as long as done in a single patch
with no other changes.

The first option is less changes if needed as a fix, up to Sebastian
depending on what he prefers.

Regards,

Tony

> It looks like this:

> diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
> index b51eac1..54c8952 100644
> --- a/drivers/power/bq24190_charger.c
> +++ b/drivers/power/bq24190_charger.c
> @@ -1366,22 +1366,13 @@ static int bq24190_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
> -			bq24190_irq_handler_thread,
> -			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -			"bq24190-charger", bdi);
> -	if (ret < 0) {
> -		dev_err(dev, "Can't set up irq handler\n");
> -		goto out1;
> -	}
> -
>  	pm_runtime_enable(dev);
>  	pm_runtime_resume(dev);
>  
>  	ret = bq24190_hw_init(bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Hardware init failed\n");
> -		goto out2;
> +		goto out1;
>  	}
>  
>  	charger_cfg.drv_data = bdi;
> @@ -1392,7 +1383,7 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (IS_ERR(bdi->charger)) {
>  		dev_err(dev, "Can't register charger\n");
>  		ret = PTR_ERR(bdi->charger);
> -		goto out2;
> +		goto out1;
>  	}
>  
>  	battery_cfg.drv_data = bdi;
> @@ -1401,24 +1392,34 @@ static int bq24190_probe(struct i2c_client *client,
>  	if (IS_ERR(bdi->battery)) {
>  		dev_err(dev, "Can't register battery\n");
>  		ret = PTR_ERR(bdi->battery);
> -		goto out3;
> +		goto out2;
>  	}
>  
>  	ret = bq24190_sysfs_create_group(bdi);
>  	if (ret) {
>  		dev_err(dev, "Can't create sysfs entries\n");
> +		goto out3;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
> +			bq24190_irq_handler_thread,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			"bq24190-charger", bdi);
> +	if (ret < 0) {
> +		dev_err(dev, "Can't set up irq handler\n");
>  		goto out4;
>  	}
>  
>  	return 0;
>  
>  out4:
> -	power_supply_unregister(bdi->battery);
> +	bq24190_sysfs_remove_group(bdi);
>  out3:
> -	power_supply_unregister(bdi->charger);
> +	power_supply_unregister(bdi->battery);
>  out2:
> -	pm_runtime_disable(dev);
> +	power_supply_unregister(bdi->charger);
>  out1:
> +	pm_runtime_disable(dev);
>  	if (bdi->gpio_int)
>  		gpio_free(bdi->gpio_int);

