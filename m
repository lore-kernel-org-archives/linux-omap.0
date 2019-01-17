From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Thu, 17 Jan 2019 10:54:32 +0100
Message-ID: <CAPDyKFoqfyvQRnSBRvPVxrL-nmf1YoSzxRkPfGwr==L3LOwgaw@mail.gmail.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org> <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <258ecb6b-c2b2-c8b8-9804-4df69002d9f5@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Kalle Valo <kvalo@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org, Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Jan 2019 at 21:26, Jan Kiszka <jan.kiszka@web.de> wrote:
>
> On 16.01.19 12:37, Ulf Hansson wrote:
> > During "wlan-up", we are programming the FW into the WiFi-chip. However,
> > re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> > is made in-between the programmings.
> >
> > To conform to this requirement and to fix the regression in a simple way,
> > let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> > (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> > current code is to treat this scenario as an error, but unfortunate this
> > doesn't work as expected, so let's fix this.
> >
> > The other part is to guarantee that a power cycle of the SDIO card has been
> > completed when wl12xx_sdio_power_on() returns, as to allow the FW
> > programming to succeed. However, relying solely on runtime PM to deal with
> > this isn't sufficient. For example, userspace may prevent runtime suspend
> > via sysfs for the device that represents the SDIO card, leading to that the
> > mmc core also keeps it powered on. For this reason, let's instead do a
> > brute force power cycle in wl12xx_sdio_power_on().
> >
> > Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Keep the SDIO host claimed when calling mmc_hw_reset().
> >       - Add a fixes tag.
> > ---
> >   drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
> >   1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> > index bd10165d7eec..4d4b07701149 100644
> > --- a/drivers/net/wireless/ti/wlcore/sdio.c
> > +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> > @@ -164,6 +164,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
> >       }
> >
> >       sdio_claim_host(func);
> > +     /*
> > +      * To guarantee that the SDIO card is power cycled, as required to make
> > +      * the FW programming to succeed, let's do a brute force HW reset.
> > +      */
> > +     mmc_hw_reset(card->host);
> > +
> >       sdio_enable_func(func);
> >       sdio_release_host(func);
> >
> > @@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
> >   {
> >       struct sdio_func *func = dev_to_sdio_func(glue->dev);
> >       struct mmc_card *card = func->card;
> > -     int error;
> >
> >       sdio_claim_host(func);
> >       sdio_disable_func(func);
> >       sdio_release_host(func);
> >
> >       /* Let runtime PM know the card is powered off */
> > -     error = pm_runtime_put(&card->dev);
> > -     if (error < 0 && error != -EBUSY) {
> > -             dev_err(&card->dev, "%s failed: %i\n", __func__, error);
> > -
> > -             return error;
> > -     }
> > -
> > +     pm_runtime_put(&card->dev);
> >       return 0;
> >   }
> >
> >
>
> Just tested on both HiKey (620) and Ultra96 but it fails to fix the issue on
> both. I'm getting
>
> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
>
> during boot again, and the interface is not available.

Okay, sounds like this may be a different problem then. Can you share
the complete log and the kernel config?
I can prepare a debug patch as well, if you are willing to re-run the test?

Adding a post-power-on-delay-ms of 1 ms as you suggested [1], doesn't
sounds like the correct solution to me, unless I am overlooking some
things. The point is, since the mmc core succeeds to detect and
initialize the SDIO card, the power sequence seems to be correct.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/10745075/
