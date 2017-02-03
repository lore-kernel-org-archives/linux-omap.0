From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Fri, 3 Feb 2017 02:38:59 -0800
Message-ID: <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
References: <20170131000210.5442-1-tony@atomide.com> <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com> <20170131003632.GB7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170131003632.GB7403@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2017 at 4:36 PM, Tony Lindgren <tony@atomide.com> wrote:

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
>  drivers/power/supply/bq24190_charger.c | 153 ++++++++++++++++++++++++---------
>  1 file changed, 111 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> ...
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

OK get_sync() failure should return error to userspace callers, and
abort probe(), makes sense.

But should the interrupt handler (above) emit a warning and continue
as in resume() and suspend()?

If not is ret the right value to return in lieu of irq_handled?
