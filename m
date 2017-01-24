From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Mon, 23 Jan 2017 19:34:20 -0800
Message-ID: <CAKvHMgTvdEz=YRxB-sd-FHws+DH9DJTnVst3Tc=9HoaKMq--Ow@mail.gmail.com>
References: <20170120220440.1971-1-tony@atomide.com> <20170120220440.1971-3-tony@atomide.com>
 <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com> <20170124012702.GA7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170124012702.GA7403@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 20 Jan 2017 09:58:51 -0800
> Subject: [PATCH] power: bq24190_charger: Use PM runtime autosuspend
>
> We can get quite a few interrupts when the battery is trickle charging.
> Let's enable PM runtime autosuspend to avoid constantly toggling device
> driver PM runtime state.
>
> Let's use a 600 ms timeout as that's how long the USB chager detection
> might take.
>
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 147 ++++++++++++++++++++++-----------
>  1 file changed, 101 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
...
> @@ -1431,13 +1474,17 @@ static int bq24190_remove(struct i2c_client *client)
>  {
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>
> -       pm_runtime_get_sync(bdi->dev);
> -       bq24190_register_reset(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +       if (!pm_runtime_get_sync(bdi->dev)) {
> +               bq24190_register_reset(bdi);
> +               pm_runtime_put_sync(bdi->dev);
> +       } else {
> +               dev_warn(bdi->dev, "pm_runtime_get failed\n");
> +       }

If we skip the register_reset, things may break.
Only the other pm_runtime_* calls should be skipped if get_sync() fails.


>         bq24190_sysfs_remove_group(bdi);
>         power_supply_unregister(bdi->battery);
>         power_supply_unregister(bdi->charger);
> +       pm_runtime_dont_use_autosuspend(bdi->dev);
>         pm_runtime_disable(bdi->dev);
>
>         if (bdi->gpio_int)
> @@ -1481,9 +1528,13 @@ static int bq24190_pm_suspend(struct device *dev)
>         struct i2c_client *client = to_i2c_client(dev);
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>
> -       pm_runtime_get_sync(bdi->dev);
> -       bq24190_register_reset(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +       if (!pm_runtime_get_sync(bdi->dev)) {
> +               bq24190_register_reset(bdi);
> +               pm_runtime_mark_last_busy(bdi->dev);
> +               pm_runtime_put_autosuspend(bdi->dev);
> +       } else {
> +               dev_warn(bdi->dev, "pm_runtime_get failed\n");
> +       }

Only the other pm_runtime_* calls should be skipped.


>         return 0;
>  }
> @@ -1496,11 +1547,15 @@ static int bq24190_pm_resume(struct device *dev)
>         bdi->f_reg = 0;
>         bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
>
> -       pm_runtime_get_sync(bdi->dev);
> -       bq24190_register_reset(bdi);
> -       bq24190_set_mode_host(bdi);
> -       bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> -       pm_runtime_put_sync(bdi->dev);
> +       if (!pm_runtime_get_sync(bdi->dev)) {
> +               bq24190_register_reset(bdi);
> +               bq24190_set_mode_host(bdi);
> +               bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> +               pm_runtime_mark_last_busy(bdi->dev);
> +               pm_runtime_put_autosuspend(bdi->dev);
> +       } else {
> +               dev_warn(bdi->dev, "pm_runtime_get failed\n");
> +       }

Only the other pm_runtime_* calls should be skipped.


>         /* Things may have changed while suspended so alert upper layer */
>         power_supply_changed(bdi->charger);
> --
> 2.11.0
