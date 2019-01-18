From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Fri, 18 Jan 2019 16:09:07 +0100
Message-ID: <CAPDyKFo=m50jiQ639xzP9tzn+=Bn0CXXwO6p0_jPH0EnSc0UQg@mail.gmail.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org>
 <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de> <CAPDyKFoqfyvQRnSBRvPVxrL-nmf1YoSzxRkPfGwr==L3LOwgaw@mail.gmail.com>
 <5bf8514a-eb15-b098-1857-835b36d4a67c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5bf8514a-eb15-b098-1857-835b36d4a67c-S0/GAf8tV78@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 18 Jan 2019 at 13:09, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
>
> On 17.01.19 10:54, Ulf Hansson wrote:
> > On Wed, 16 Jan 2019 at 21:26, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
> >>
> >> On 16.01.19 12:37, Ulf Hansson wrote:
> >>> During "wlan-up", we are programming the FW into the WiFi-chip. However,
> >>> re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> >>> is made in-between the programmings.
> >>>
> >>> To conform to this requirement and to fix the regression in a simple way,
> >>> let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> >>> (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> >>> current code is to treat this scenario as an error, but unfortunate this
> >>> doesn't work as expected, so let's fix this.
> >>>
> >>> The other part is to guarantee that a power cycle of the SDIO card has been
> >>> completed when wl12xx_sdio_power_on() returns, as to allow the FW
> >>> programming to succeed. However, relying solely on runtime PM to deal with
> >>> this isn't sufficient. For example, userspace may prevent runtime suspend
> >>> via sysfs for the device that represents the SDIO card, leading to that the
> >>> mmc core also keeps it powered on. For this reason, let's instead do a
> >>> brute force power cycle in wl12xx_sdio_power_on().
> >>>
> >>> Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> >>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>        - Keep the SDIO host claimed when calling mmc_hw_reset().
> >>>        - Add a fixes tag.
> >>> ---
> >>>    drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
> >>>    1 file changed, 7 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> >>> index bd10165d7eec..4d4b07701149 100644
> >>> --- a/drivers/net/wireless/ti/wlcore/sdio.c
> >>> +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> >>> @@ -164,6 +164,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
> >>>        }
> >>>
> >>>        sdio_claim_host(func);
> >>> +     /*
> >>> +      * To guarantee that the SDIO card is power cycled, as required to make
> >>> +      * the FW programming to succeed, let's do a brute force HW reset.
> >>> +      */
> >>> +     mmc_hw_reset(card->host);
> >>> +
> >>>        sdio_enable_func(func);
> >>>        sdio_release_host(func);
> >>>
> >>> @@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
> >>>    {
> >>>        struct sdio_func *func = dev_to_sdio_func(glue->dev);
> >>>        struct mmc_card *card = func->card;
> >>> -     int error;
> >>>
> >>>        sdio_claim_host(func);
> >>>        sdio_disable_func(func);
> >>>        sdio_release_host(func);
> >>>
> >>>        /* Let runtime PM know the card is powered off */
> >>> -     error = pm_runtime_put(&card->dev);
> >>> -     if (error < 0 && error != -EBUSY) {
> >>> -             dev_err(&card->dev, "%s failed: %i\n", __func__, error);
> >>> -
> >>> -             return error;
> >>> -     }
> >>> -
> >>> +     pm_runtime_put(&card->dev);
> >>>        return 0;
> >>>    }
> >>>
> >>>
> >>
> >> Just tested on both HiKey (620) and Ultra96 but it fails to fix the issue on
> >> both. I'm getting
> >>
> >> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> >>
> >> during boot again, and the interface is not available.
> >
> > Okay, sounds like this may be a different problem then. Can you share
> > the complete log and the kernel config?
>
> You can find the config here [1], log from the HiKey boot attached.
>
> > I can prepare a debug patch as well, if you are willing to re-run the test?
>
> Sure, send it over, I can run it.

Alright, sounds great. However, I need to defer that to Monday/Tuesday
next week.

>
> >
> > Adding a post-power-on-delay-ms of 1 ms as you suggested [1], doesn't
> > sounds like the correct solution to me, unless I am overlooking some
> > things. The point is, since the mmc core succeeds to detect and
> > initialize the SDIO card, the power sequence seems to be correct.
>
> Yeah, I'm not claiming at all I know what I'm doing there, just that it happens
> to work.

I see. Good to know, thanks!

>
> Jan
>
> [1]
> https://github.com/siemens/jailhouse-images/blob/next/recipes-kernel/linux/files/arm64_defconfig_4.19

I have looked through the log and the defconfig. No obvious things
found at this point. Thanks for sharing them!

Kind regards
Uffe
