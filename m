From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 6/6] power: bq24190_charger: Use PM runtime autosuspend
Date: Wed, 11 Jan 2017 18:02:28 -0800
Message-ID: <CAKvHMgTv8uXxRKXp6dnu9QGquB0o7hHXCzVHiKBdCf3ag=mmnQ@mail.gmail.com>
References: <20170112004154.31568-1-tony@atomide.com> <20170112004154.31568-7-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-7-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> We can get quite a few interrupts when the battery is trickle charging.
> Let's enable PM runtime autosuspend to avoid constantly toggling device
> state.
>
> Let's use a 600 ms timeout as that's how long the USB chager detection
> might take.
>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Liam Breck <kernel@networkimprov.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 101 ++++++++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -420,6 +420,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
>         struct power_supply *psy = dev_get_drvdata(dev);
>         struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
>         struct bq24190_sysfs_field_info *info;
> +       ssize_t count;
>         int ret;
>         u8 v;
>
> @@ -427,11 +428,20 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
>         if (!info)
>                 return -EINVAL;
>
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
> +
>         ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
>         if (ret)
> -               return ret;
> +               count = ret;
> +       else
> +               count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> +
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> +       return count;
>  }
>
>  static ssize_t bq24190_sysfs_store(struct device *dev,
> @@ -451,9 +461,16 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
>         if (ret < 0)
>                 return ret;
>
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
> +
>         ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
>         if (ret)
> -               return ret;
> +               count = ret;
> +
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
>
>         return count;
>  }
> @@ -795,7 +812,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
>
>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_CHARGE_TYPE:
> @@ -835,7 +854,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
>                 ret = -ENODATA;
>         }
>
> -       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
> +
>         return ret;
>  }
>
> @@ -848,7 +869,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
>
>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_CHARGE_TYPE:
> @@ -864,7 +887,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
>                 ret = -EINVAL;
>         }
>
> -       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
> +
>         return ret;
>  }
>
> @@ -1065,7 +1090,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
>
>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
> @@ -1093,7 +1120,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
>                 ret = -ENODATA;
>         }
>
> -       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
> +
>         return ret;
>  }
>
> @@ -1119,7 +1148,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
>                 ret = -EINVAL;
>         }

pm_runtime_get_sync() in this function needs its return value checked.


> -       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
> +
>         return ret;
>  }

Please submit this and #5 as a separate patchset after I resubmit 1-4.
