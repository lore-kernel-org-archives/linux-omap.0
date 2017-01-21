From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 1/2] power: bq24190_charger: Check the interrupt status on resume
Date: Sat, 21 Jan 2017 00:08:02 -0800
Message-ID: <CAKvHMgRipKyVAF6Y6Wr3t=McPouqfC2B9KuAnM+RFUtE-LRtuw@mail.gmail.com>
References: <20170120220440.1971-1-tony@atomide.com> <20170120220440.1971-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170120220440.1971-2-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 20, 2017 at 2:04 PM, Tony Lindgren <tony@atomide.com> wrote:
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
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Cc: Liam Breck <kernel@networkimprov.net>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 62 ++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -155,6 +155,8 @@ struct bq24190_dev_info {
>         kernel_ulong_t                  model;
>         unsigned int                    gpio_int;
>         unsigned int                    irq;
> +       bool                            initialized;
> +       bool                            irq_event;
>         struct mutex                    f_reg_lock;
>         u8                              f_reg;
>         u8                              ss_reg;
> @@ -1157,9 +1159,8 @@ static const struct power_supply_desc bq24190_battery_desc = {
>         .property_is_writeable  = bq24190_battery_property_is_writeable,
>  };
>
> -static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> +static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  {
> -       struct bq24190_dev_info *bdi = data;
>         const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
>         const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK
>                                 | BQ24190_REG_F_NTC_FAULT_MASK;
> @@ -1167,12 +1168,10 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>         u8 ss_reg = 0, f_reg = 0;
>         int i, ret;
>
> -       pm_runtime_get_sync(bdi->dev);
> -
>         ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
>         if (ret < 0) {
>                 dev_err(bdi->dev, "Can't read SS reg: %d\n", ret);
> -               goto out;
> +               return;
>         }
>
>         i = 0;
> @@ -1180,7 +1179,7 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>                 ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
>                 if (ret < 0) {
>                         dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
> -                       goto out;
> +                       return;
>                 }
>         } while (f_reg && ++i < 2);
>
> @@ -1229,10 +1228,18 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>         if (alert_battery)
>                 power_supply_changed(bdi->battery);
>
> -out:
> -       pm_runtime_put_sync(bdi->dev);
> -
>         dev_dbg(bdi->dev, "ss_reg: 0x%02x, f_reg: 0x%02x\n", ss_reg, f_reg);
> +}
> +
> +static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> +{
> +       struct bq24190_dev_info *bdi = data;
> +
> +       bdi->irq_event = true;
> +       pm_runtime_get_sync(bdi->dev);

Do we need to call pm_runtime_irq_safe() prior to the above?

> +       bq24190_check_status(bdi);
> +       pm_runtime_put_sync(bdi->dev);
> +       bdi->irq_event = false;
>
>         return IRQ_HANDLED;
>  }
> ...
