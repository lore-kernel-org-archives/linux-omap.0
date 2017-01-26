From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Thu, 26 Jan 2017 15:56:36 -0800
Message-ID: <CAKvHMgSs-2Rg8sL5o9cfv1UuWWxfQ+g_O4y07JuMtU3f3UGfMQ@mail.gmail.com>
References: <20170120220440.1971-1-tony@atomide.com> <20170120220440.1971-3-tony@atomide.com>
 <CAKvHMgQKPZcdBPMUH-3_e-M4sHPijEH59019bygmi+o2y4B+Rw@mail.gmail.com>
 <20170124012702.GA7403@atomide.com> <CAKvHMgTvdEz=YRxB-sd-FHws+DH9DJTnVst3Tc=9HoaKMq--Ow@mail.gmail.com>
 <20170124182925.GF7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170124182925.GF7403@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 24, 2017 at 10:29 AM, Tony Lindgren <tony@atomide.com> wrote:

>> If we skip the register_reset, things may break.
>> Only the other pm_runtime_* calls should be skipped if get_sync() fails.
>
> Hmm yeah I guess the pm_runtime_get() could fail and yet we still could
> have i2c access working. I've added handling with pm_runtime_put_noidle()
> on error. Also replaced int ret with int error as we're not returning
> anything. Updated patch below.
>
> Regards,
>
> Tony
>
> 8< -----------------------------------------
> From tony Mon Sep 17 00:00:00 2001
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

Assuming resolution of my 2 comments below,

Acked-by: Liam Breck <kernel@networkimprov.net>

> ---
>  drivers/power/supply/bq24190_charger.c | 155 ++++++++++++++++++++++++---------
>  1 file changed, 114 insertions(+), 41 deletions(-)
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
>
> -       return scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
> +
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
> @@ -1106,7 +1135,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
>
>         dev_dbg(bdi->dev, "prop: %d\n", psp);
>
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_ONLINE:
> @@ -1119,7 +1150,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
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
> @@ -1234,11 +1267,15 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>  {
>         struct bq24190_dev_info *bdi = data;
> +       int ret;
>
>         bdi->irq_event = true;
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0)
> +               return ret;
>         bq24190_check_status(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_mark_last_busy(bdi->dev);
> +       pm_runtime_put_autosuspend(bdi->dev);
>         bdi->irq_event = false;
>
>         return IRQ_HANDLED;
> @@ -1249,33 +1286,26 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>         u8 v;
>         int ret;
>
> -       pm_runtime_get_sync(bdi->dev);
> -
>         /* First check that the device really is what its supposed to be */
>         ret = bq24190_read_mask(bdi, BQ24190_REG_VPRS,
>                         BQ24190_REG_VPRS_PN_MASK,
>                         BQ24190_REG_VPRS_PN_SHIFT,
>                         &v);
>         if (ret < 0)
> -               goto out;
> +               return ret;
>
> -       if (v != bdi->model) {
> -               ret = -ENODEV;
> -               goto out;
> -       }
> +       if (v != bdi->model)
> +               return -ENODEV;
>
>         ret = bq24190_register_reset(bdi);
>         if (ret < 0)
> -               goto out;
> +               return ret;
>
>         ret = bq24190_set_mode_host(bdi);
>         if (ret < 0)
> -               goto out;
> +               return ret;
>
> -       ret = bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> -out:
> -       pm_runtime_put_sync(bdi->dev);
> -       return ret;
> +       return bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
>  }
>
>  #ifdef CONFIG_OF
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
>
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
>         pm_runtime_disable(dev);
>         if (bdi->gpio_int)
>                 gpio_free(bdi->gpio_int);
> @@ -1430,10 +1473,20 @@ static int bq24190_probe(struct i2c_client *client,
>  static int bq24190_remove(struct i2c_client *client)
>  {
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> +       int error;
> +
> +       error = pm_runtime_get_sync(bdi->dev);
> +       if (error < 0) {
> +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +               pm_runtime_put_noidle(bdi->dev);
> +       }
>
> -       pm_runtime_get_sync(bdi->dev);
>         bq24190_register_reset(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +
> +       if (!error) {
> +               pm_runtime_dont_use_autosuspend(bdi->dev);
> +               pm_runtime_put_sync(bdi->dev);
> +       }

Should put_sync() be called before dont_use_autosuspend(), as in probe()?

Should the pm_runtime_disable() further on in remove() go inside the
above block?

>         bq24190_sysfs_remove_group(bdi);
>         power_supply_unregister(bdi->battery);
> @@ -1480,10 +1533,20 @@ static int bq24190_pm_suspend(struct device *dev)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> +       int error;
> +
> +       error = pm_runtime_get_sync(bdi->dev);
> +       if (error < 0) {
> +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +               pm_runtime_put_noidle(bdi->dev);
> +       }
>
> -       pm_runtime_get_sync(bdi->dev);
>         bq24190_register_reset(bdi);
> -       pm_runtime_put_sync(bdi->dev);
> +
> +       if (!error) {
> +               pm_runtime_mark_last_busy(bdi->dev);
> +               pm_runtime_put_autosuspend(bdi->dev);
> +       }
>
>         return 0;
>  }
> @@ -1492,15 +1555,25 @@ static int bq24190_pm_resume(struct device *dev)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
>         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> +       int error;
>
>         bdi->f_reg = 0;
>         bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
>
> -       pm_runtime_get_sync(bdi->dev);
> +       error = pm_runtime_get_sync(bdi->dev);
> +       if (error < 0) {
> +               pm_runtime_put_noidle(bdi->dev);
> +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +       }
> +
>         bq24190_register_reset(bdi);
>         bq24190_set_mode_host(bdi);
>         bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
> -       pm_runtime_put_sync(bdi->dev);
> +
> +       if (!error) {
> +               pm_runtime_mark_last_busy(bdi->dev);
> +               pm_runtime_put_autosuspend(bdi->dev);
> +       }
>
>         /* Things may have changed while suspended so alert upper layer */
>         power_supply_changed(bdi->charger);
> --
> 2.11.0
