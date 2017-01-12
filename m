From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 4/6] power: bq24190_charger: Don't read fault register
 outside irq_handle_thread()
Date: Wed, 11 Jan 2017 18:11:53 -0800
Message-ID: <CAKvHMgQ3=7xwG=QW7-04RE8Y2bW4vZabW9aYazHsO3D3Zfd0cw@mail.gmail.com>
References: <20170112004154.31568-1-tony@atomide.com> <20170112004154.31568-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-5-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> Caching the fault register after a single read may not keep an accurate
> value.
>
> Fix the issue by doing two reads of the fault register as specified in the
> data sheet. And let's do this only irq_handle_thread() to avoid accidentally
> clearing the fault status as specified in the data sheet:
>
> "When a fault occurs, the charger device sends out INT
>  and keeps the fault state in REG09 until the host reads the fault register.
>  Before the host reads REG09 and all the faults are cleared, the charger
>  device would not send any INT upon new faults. In order to read the
>  current fault status, the host has to read REG09 two times consecutively.
>  The 1st reads fault register status from the last read [1] and the 2nd reads
>  the current fault register status."
>
> [1] presumably a typo; should be "last fault"
>
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery
> Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> [tony@atomide.com: cleaned up a bit]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 99 ++++++++++------------------------
>  1 file changed, 29 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -144,10 +144,7 @@
>   * so the first read after a fault returns the latched value and subsequent
>   * reads return the current value.  In order to return the fault status
>   * to the user, have the interrupt handler save the reg's value and retrieve
> - * it in the appropriate health/status routine.  Each routine has its own
> - * flag indicating whether it should use the value stored by the last run
> - * of the interrupt handler or do an actual reg read.  That way each routine
> - * can report back whatever fault may have occured.
> + * it in the appropriate health/status routine.
>   */
>  struct bq24190_dev_info {
>         struct i2c_client               *client;
> @@ -159,9 +156,6 @@ struct bq24190_dev_info {
>         unsigned int                    gpio_int;
>         unsigned int                    irq;
>         struct mutex                    f_reg_lock;
> -       bool                            charger_health_valid;
> -       bool                            battery_health_valid;
> -       bool                            battery_status_valid;
>         u8                              f_reg;
>         u8                              ss_reg;
>         u8                              watchdog;
> @@ -635,21 +629,11 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
>                 union power_supply_propval *val)
>  {
>         u8 v;
> -       int health, ret;
> +       int health;
>
>         mutex_lock(&bdi->f_reg_lock);
> -
> -       if (bdi->charger_health_valid) {
> -               v = bdi->f_reg;
> -               bdi->charger_health_valid = false;
> -               mutex_unlock(&bdi->f_reg_lock);
> -       } else {
> -               mutex_unlock(&bdi->f_reg_lock);
> -
> -               ret = bq24190_read(bdi, BQ24190_REG_F, &v);
> -               if (ret < 0)
> -                       return ret;
> -       }
> +       v = bdi->f_reg;
> +       mutex_unlock(&bdi->f_reg_lock);

bdi->f_reg is the only thing protected by the mutex, and is only ever
set or read. Is it OK to use an atomic type here?
