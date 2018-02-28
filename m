From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [RFC PATCH 1/1] power: supply: bq27xxx: Call power_supply_changed
 on status change
Date: Tue, 27 Feb 2018 21:58:12 -0800
Message-ID: <CAJCx=gk5vw1R3HuxVdrKxHW9EY7hc01RDrhCxNWTeiT8TtpTHA@mail.gmail.com>
References: <20180228010452.1713-1-merlijn@wizzup.org> <20180228010452.1713-2-merlijn@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228010452.1713-2-merlijn@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit message please :)

On Tue, Feb 27, 2018 at 5:04 PM, Merlijn Wajer <merlijn@wizzup.org> wrote:
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---

Single patch changes usually don't have a cover letter. you put more
detail here in the cutoff section (aka after --- above)


>  drivers/power/supply/bq27xxx_battery.c | 59 +++++++++++++++++-----------------
>  include/linux/power/bq27xxx_battery.h  |  1 +
>  2 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 0a203672744c..218d153fb431 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1527,6 +1527,31 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>         return POWER_SUPPLY_HEALTH_GOOD;
>  }
>
> +static int bq27xxx_battery_read_status(struct bq27xxx_device_info *di)
> +{
> +       int status;
> +
> +       if (di->opts & BQ27XXX_O_ZERO) {
> +               if (di->cache.flags & BQ27000_FLAG_FC)
> +                       status = POWER_SUPPLY_STATUS_FULL;
> +               else if (di->cache.flags & BQ27000_FLAG_CHGS)
> +                       status = POWER_SUPPLY_STATUS_CHARGING;
> +               else if (power_supply_am_i_supplied(di->bat) > 0)
> +                       status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               else
> +                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> +       } else {
> +               if (di->cache.flags & BQ27XXX_FLAG_FC)
> +                       status = POWER_SUPPLY_STATUS_FULL;
> +               else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> +                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> +               else
> +                       status = POWER_SUPPLY_STATUS_CHARGING;
> +       }
> +
> +       return status;
> +}
> +
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  {
>         struct bq27xxx_reg_cache cache = {0, };
> @@ -1547,6 +1572,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         cache.time_to_full = -ENODATA;
>                         cache.charge_full = -ENODATA;
>                         cache.health = -ENODATA;
> +                       cache.status = bq27xxx_battery_read_status(di);
>                 } else {
>                         if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
>                                 cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> @@ -1559,6 +1585,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>                                 cache.energy = bq27xxx_battery_read_energy(di);
>                         cache.health = bq27xxx_battery_read_health(di);
> +                       cache.status = bq27xxx_battery_read_status(di);
>                 }
>                 if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>                         cache.cycle_count = bq27xxx_battery_read_cyct(di);
> @@ -1570,7 +1597,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         di->charge_design_full = bq27xxx_battery_read_dcap(di);
>         }
>
> -       if (di->cache.capacity != cache.capacity)
> +       if ((di->cache.capacity != cache.capacity) || (di->cache.status != cache.status))
>                 power_supply_changed(di->bat);
>
>         if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
> @@ -1625,34 +1652,6 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
>         return 0;
>  }
>
> -static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
> -                                 union power_supply_propval *val)
> -{
> -       int status;
> -
> -       if (di->opts & BQ27XXX_O_ZERO) {
> -               if (di->cache.flags & BQ27000_FLAG_FC)
> -                       status = POWER_SUPPLY_STATUS_FULL;
> -               else if (di->cache.flags & BQ27000_FLAG_CHGS)
> -                       status = POWER_SUPPLY_STATUS_CHARGING;
> -               else if (power_supply_am_i_supplied(di->bat) > 0)
> -                       status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -               else
> -                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> -       } else {
> -               if (di->cache.flags & BQ27XXX_FLAG_FC)
> -                       status = POWER_SUPPLY_STATUS_FULL;
> -               else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> -                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> -                       status = POWER_SUPPLY_STATUS_CHARGING;
> -       }
> -
> -       val->intval = status;
> -
> -       return 0;
> -}
> -
>  static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>                                           union power_supply_propval *val)
>  {
> @@ -1733,7 +1732,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
> -               ret = bq27xxx_battery_status(di, val);
> +               ret = bq27xxx_simple_value(di->cache.status, val);
>                 break;
>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>                 ret = bq27xxx_battery_voltage(di, val);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index e6187f524f2c..4f27656045fd 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -49,6 +49,7 @@ struct bq27xxx_reg_cache {
>         int flags;
>         int power_avg;
>         int health;
> +       int status;
>  };
>
>  struct bq27xxx_device_info {
> --
> 2.16.2
>
