From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver level
Date: Sat, 16 Jun 2012 15:27:22 +0200
Message-ID: <201206161527.22560.marek.vasut@gmail.com>
References: <zumeng.chen@gmail.com> <4FD8577B.1010408@windriver.com> <4FD867CC.30302@compulab.co.il>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4FD867CC.30302@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Zumeng Chen <zumeng.chen@windriver.com>, Zumeng Chen <zumeng.chen@gmail.com>, tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dear Igor Grinberg,

> On 06/13/12 12:03, Zumeng Chen wrote:
> > =E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 15:51, Igor Grinberg =
=E5=86=99=E9=81=93:
> >> On 06/13/12 04:44, Zumeng Chen wrote:
> >>> From: Zumeng Chen<zumeng.chen@windriver.com>
> >>>=20
> >>> If we don't set proper debouce time for ads7846, then there are
> >>> flooded interrupt counters of ads7846 responding to one time
> >>> touch on screen, so the driver couldn't work well.
> >>>=20
> >>> And since most OMAP3 series boards pass NULL pointer of board_pda=
ta
> >>> to omap_ads7846_init, so it's more proper to set it in driver lev=
el
> >>> after having gpio_request done.
> >>>=20
> >>> This patch has been validated on 3530evm.
> >>>=20
> >>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
> >>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
> >>> ---
> >>>=20
> >>>   drivers/input/touchscreen/ads7846.c |    4 ++++
> >>>   1 files changed, 4 insertions(+), 0 deletions(-)
> >>>=20
> >>> diff --git a/drivers/input/touchscreen/ads7846.c
> >>> b/drivers/input/touchscreen/ads7846.c index f02028e..459ff29 1006=
44
> >>> --- a/drivers/input/touchscreen/ads7846.c
> >>> +++ b/drivers/input/touchscreen/ads7846.c
> >>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(s=
truct
> >>> spi_device *spi, struct ads784
> >>>=20
> >>>           }
> >>>          =20
> >>>           ts->gpio_pendown =3D pdata->gpio_pendown;
> >>>=20
> >>> +#ifdef CONFIG_ARCH_OMAP3
> >>> +        /* 310 means about 10 microsecond for omap3 */
> >>> +        gpio_set_debounce(pdata->gpio_pendown, 310);
> >>> +#endif
> >>=20
> >> Unless this concerns many boards/archs/platforms,
> >=20
> > Yes, this is the case.
> >=20
> >> I'd suggest you to implement
> >> the get_pendown_state() method in the board file.
> >=20
> > it seems they are different way between gpio and
> > get_pendown_state, and gpio way is used for omap3
> > to drive ads7846, so I guess we may have to do like this.
>=20
> No, this is not (and does not have to be) OMAP wide.
> The decision for this is made on per-board basis.

+1 agreed

> > Regards,
> > Zumeng
> >=20
> >> If more users will need this, it can be facilitated in the driver.
> >> (and of course not with the ugly ifdefs...)
> >>=20
> >>>       } else {
> >>>      =20
> >>>           dev_err(&spi->dev, "no get_pendown_state nor
> >>>           gpio_pendown?\n");

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
