From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 5/6] power: bq24190_charger: Check the interrupt status on resume
Date: Wed, 11 Jan 2017 18:05:56 -0800
Message-ID: <CAKvHMgRbmAxHvJ3NoTs2JMkK3VN_mERtsmJxi7184KfbbnHkGg@mail.gmail.com>
References: <20170112004154.31568-1-tony@atomide.com> <20170112004154.31568-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-6-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> Some SoCs like omap3 can configure GPIO irqs to use Linux generic
> dedicated wakeirq support. If the dedicated wakeirq is configured,
> the SoC will use a always-on interrupt controller to produce wake-up
> events.
>
> If bq24190 is configured for dedicated wakeirq, we need to check the
> interrupt status on PM runtime resume. This is because the Linux
> generic wakeirq will call pm_runtime_resume() on the device on a
> wakeirq. And as the bq24190 interrupt is falling edge sensitive
> and only active for 250 us, there will be no device interrupt seen
> by the runtime SoC IRQ controller.
>
> Note that this can cause spurious interrupts on omap3 devices with
> bq24190 connected to gpio banks 2 - 5 as there's a glitch on those
> pins waking from off mode as listed in "Advisory 1.45". Devices
> with this issue should not configure the optional wakeirq interrupt
> in the dts file.
>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Liam Breck <kernel@networkimprov.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 58 ++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -156,6 +156,8 @@ struct bq24190_dev_info {
>         unsigned int                    gpio_int;
>         unsigned int                    irq;
>         struct mutex                    f_reg_lock;
> +       bool                            initialized;
> +       bool                            irq_event;
>         u8                              f_reg;
>         u8                              ss_reg;
>         u8                              watchdog;
> @@ -1157,9 +1159,8 @@ static const struct power_supply_desc bq24190_battery_desc = {
>         .property_is_writeable  = bq24190_battery_property_is_writeable,
>  };
>
> -static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> +static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  {
> -       struct bq24190_dev_info *bdi = data;
>         const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
>         const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK |
>                 BQ24190_REG_F_NTC_FAULT_MASK;
> @@ -1167,15 +1168,13 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>         u8 ss_reg = 0, f_reg = 0;
>         int i, ret;
>
> -       pm_runtime_get_sync(bdi->dev);
> -
>         /* We need to read f_reg twice if fault is set to get correct value */
>         i = 0;
>         do {
>                 ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
>                 if (ret < 0) {
>                         dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
> -                       goto out;
> +                       return;
>                 }
>         } while (f_reg && ++i < 2);
>
> @@ -1231,11 +1230,18 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>         if (alert_battery)
>                 power_supply_changed(bdi->battery);
>
> -out:
> -       pm_runtime_put_sync(bdi->dev);
> -
>         dev_dbg(bdi->dev, "ss_reg: 0x%02x, f_reg: 0x%02x\n", ss_reg, f_reg);
> +}
>
> +static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> +{
> +       struct bq24190_dev_info *bdi = data;
> +
> +       bdi->irq_event = true;
> +       pm_runtime_get_sync(bdi->dev);
> +       bq24190_check_status(bdi);
> +       pm_runtime_put_sync(bdi->dev);
> +       bdi->irq_event = false;
>         return IRQ_HANDLED;
>  }
>
> @@ -1404,6 +1410,7 @@ static int bq24190_probe(struct i2c_client *client,
>         }
>
>         enable_irq(bdi->irq);
> +       bdi->initialized = 1;

Should initialized be set before enable_irq()?
