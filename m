From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Fri, 3 Feb 2017 16:23:51 -0800
Message-ID: <CAKvHMgRV=mm2XBtrNjQCvGXuAQY6n6xEKerP4eVw2izkS9C7ww@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com> <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
 <20170203185408.GB3721@atomide.com> <CAKvHMgQs3YYtyMApYvdRAyzuzii_xA=ZKRfqG-zpFzrMef_qdg@mail.gmail.com>
 <20170203211707.GC3721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170203211707.GC3721@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 3, 2017 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:

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
>  drivers/power/supply/bq24190_charger.c | 155 ++++++++++++++++++++++++---------
>  1 file changed, 113 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
>
> @@ -1430,14 +1475,20 @@ static int bq24190_probe(struct i2c_client *client,
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
> +       pm_runtime_put_sync(bdi->dev);
> +       pm_runtime_dont_use_autosuspend(bdi->dev);
>         pm_runtime_disable(bdi->dev);

I think you addressed this, but should the above be

if (!error)
  pm_runtime_put_sync(bdi->dev);
