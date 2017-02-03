From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Fri, 3 Feb 2017 13:00:51 -0800
Message-ID: <CAKvHMgQs3YYtyMApYvdRAyzuzii_xA=ZKRfqG-zpFzrMef_qdg@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com> <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
 <20170203185408.GB3721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170203185408.GB3721@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 3, 2017 at 10:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> ...
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 30 Jan 2017 07:10:31 -0800
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
> Acked-by: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 156 ++++++++++++++++++++++++---------
>  1 file changed, 114 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
>
> @@ -1234,11 +1267,18 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>  {
>         struct bq24190_dev_info *bdi = data;
> +       int ret;
>
>         bdi->irq_event = true;
> -       pm_runtime_get_sync(bdi->dev);
> +       ret = pm_runtime_get_sync(bdi->dev);
> +       if (ret < 0) {
> +               dev_err(bdi->dev, "Runtime PM failed in %s: %i\n",
> +                       __func__, ret);
> +               return IRQ_NONE;
> +       }

Now this is a nitpick... Error msg should be consistent with suspend/resume:

> @@ -1480,10 +1532,20 @@ static int bq24190_pm_suspend(struct device *dev)
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

Like here.

> @@ -1492,15 +1554,25 @@ static int bq24190_pm_resume(struct device *dev)
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

And here.
