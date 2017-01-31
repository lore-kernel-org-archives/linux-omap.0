From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Mon, 30 Jan 2017 16:14:09 -0800
Message-ID: <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170131000210.5442-3-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi, these emails are missing v2 in subject line.


On Mon, Jan 30, 2017 at 4:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> We can get quite a few interrupts when the battery is trickle charging.
> Let's enable PM runtime autosuspend to avoid constantly toggling device
> driver PM runtime state.
>
> Let's use a 600 ms timeout as that's how long the USB chager detection
> might take.
>
> Cc: Liam Breck <kernel@networkimprov.net>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
> Acked-by: Liam Breck <kernel@networkimprov.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 153 ++++++++++++++++++++++++---------
>  1 file changed, 111 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> ...
> @@ -1364,12 +1394,16 @@ static int bq24190_probe(struct i2c_client *client,
>         }
>
>         pm_runtime_enable(dev);
> -       pm_runtime_resume(dev);
> +       pm_runtime_set_autosuspend_delay(dev, 600);
> +       pm_runtime_use_autosuspend(dev);
> +       ret = pm_runtime_get_sync(dev);
> +       if (ret < 0)
> +               goto out1;

Call get_sync() before set_autosuspend() ?

>         ret = bq24190_hw_init(bdi);
>         if (ret < 0) {
>                 dev_err(dev, "Hardware init failed\n");
> -               goto out1;
> +               goto out2;
>         }
>
>         charger_cfg.drv_data = bdi;
> @@ -1380,7 +1414,7 @@ static int bq24190_probe(struct i2c_client *client,
>         if (IS_ERR(bdi->charger)) {
>                 dev_err(dev, "Can't register charger\n");
>                 ret = PTR_ERR(bdi->charger);
> -               goto out1;
> +               goto out2;
>         }
>
>         battery_cfg.drv_data = bdi;
> @@ -1389,13 +1423,13 @@ static int bq24190_probe(struct i2c_client *client,
>         if (IS_ERR(bdi->battery)) {
>                 dev_err(dev, "Can't register battery\n");
>                 ret = PTR_ERR(bdi->battery);
> -               goto out2;
> +               goto out3;
>         }
>
>         ret = bq24190_sysfs_create_group(bdi);
>         if (ret) {
>                 dev_err(dev, "Can't create sysfs entries\n");
> -               goto out3;
> +               goto out4;
>         }
>
>         bdi->initialized = true;
> @@ -1406,21 +1440,30 @@ static int bq24190_probe(struct i2c_client *client,
>                         "bq24190-charger", bdi);
>         if (ret < 0) {
>                 dev_err(dev, "Can't set up irq handler\n");
> -               goto out4;
> +               goto out5;
>         }
>
> +       enable_irq_wake(bdi->irq);
> +
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
> +
>         return 0;
>
> -out4:
> +out5:
>         bq24190_sysfs_remove_group(bdi);
>
> -out3:
> +out4:
>         power_supply_unregister(bdi->battery);
>
> -out2:
> +out3:
>         power_supply_unregister(bdi->charger);
>
> +out2:
> +       pm_runtime_put_sync(dev);
> +
>  out1:
> +       pm_runtime_dont_use_autosuspend(dev);

Change order of above two if my prev comment is right.

>         pm_runtime_disable(dev);
>         if (bdi->gpio_int)
>                 gpio_free(bdi->gpio_int);
> @@ -1430,14 +1473,20 @@ static int bq24190_probe(struct i2c_client *client,
>  static int bq24190_remove(struct i2c_client *client)
>  {
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> +       int error;
>
> -       pm_runtime_get_sync(bdi->dev);
> -       bq24190_register_reset(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +       error = pm_runtime_get_sync(bdi->dev);
> +       if (error < 0) {
> +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +               pm_runtime_put_noidle(bdi->dev);
> +       }
>
> +       bq24190_register_reset(bdi);
>         bq24190_sysfs_remove_group(bdi);
>         power_supply_unregister(bdi->battery);
>         power_supply_unregister(bdi->charger);
> +       pm_runtime_dont_use_autosuspend(bdi->dev);
> +       pm_runtime_put_sync(bdi->dev);

Alternatively, switch order of above two.

>         pm_runtime_disable(bdi->dev);
>
>         if (bdi->gpio_int)

Apologies if I'm nitpicking!

~.~
