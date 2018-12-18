From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] wlcore: Fix bringing up wlan0 again if powered down briefly
Date: Tue, 18 Dec 2018 13:34:06 +0100
Message-ID: <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
References: <20181217164207.20081-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181217164207.20081-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 17 Dec 2018 at 17:42, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> At least HiKey board can fail to bring up wireless interface again
> if the interface is brought down and up with no delay inbetween.
>
> This can be done tested with:
>
> # while true; do ifconfig wlan0 down; ifconfig wlan0 up; done
>
> According to Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>, we need to
> wait between 30 - 40 ms on HiKey. This seems to happen when we
> get -EBUSY returned by pm_runtime_put() basedon the check in
> rpm_check_suspend_allowed(). But as it still unclear if part of
> the delay needed is because of capacitance, let's always do a
> at least 50 ms msleep even if no -EBUSY is returned.
>
> Cc: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reported-by: Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>
> Uffe, do you have some better ideas on how to fix this issue?
>
> ---
>  drivers/net/wireless/ti/wlcore/sdio.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> @@ -174,7 +174,7 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
>  {
>         struct sdio_func *func = dev_to_sdio_func(glue->dev);
>         struct mmc_card *card = func->card;
> -       int error;
> +       int error, retries = 5;
>
>         sdio_claim_host(func);
>         sdio_disable_func(func);
> @@ -188,6 +188,17 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
>                 return error;
>         }
>
> +       /* Wait a bit to ensure the card gets power off. Otherwise
> +        * bringing interface down and up again may not power off the
> +        * card inbetween. And then firmware load will fail on trying
> +        * to bring the card up again. We need to wait between 30 - 40
> +        * ms for this based on measurements on HiKey board.
> +        */
> +       do {
> +               msleep(50);
> +       } while (error == -EBUSY && !pm_runtime_suspended(&card->dev) &&
> +                retries--);
> +

To me, this looks wrong, let me explain why.

I assume wl12xx_sdio_power_off() is being called, at "ifconfig wlan0
down". Although, could wl12xx_sdio_power_off() also be called during
system suspend, or you have another function dealing with that path?

Anyway, the call to pm_runtime_put*() a few lines above the new code
added in $subject patch, doesn't guarantee that the device ever
becomes runtime suspended. During system suspend, that is for sure,
but even when the platform is up an running, as userspace may prevent
it via the device's sysfs nobs.

That said, checking the state of the device with
pm_runtime_suspended() here, doesn't really play well.

Instead, it looks like what you need, is a way to keep track of
whether the SDIO card, became power cycled or if it stayed powered on,
when "ifconfig wlan0 up" is done. In case of a power cycle, you need
to re-program the firmware, right?

Would it be possible to re-program the firmware, even if the SDIO card
stayed powered-on?

In regards to delays needed due to a capacitance. If that really is
the case, that shall be the managed by the mmc core, as it's there the
power cycle sequence is being done. As a matter of fact, you should be
able to use drivers/mmc/core/pwrseq_simple.c and extend
"power-off-delay-us" in the DTB for Hikey if that is needed.

Kind regards
Uffe
