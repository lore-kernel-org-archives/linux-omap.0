From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers
	when resuming
Date: Fri, 27 Feb 2009 14:08:12 -0800
Message-ID: <20090227220812.GM11594@atomide.com>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <200902231023.49653.david-b@pacbell.net> <49A3EF96.3090603@nokia.com> <200902241410.19132.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51297 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515AbZB0WIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 17:08:21 -0500
Content-Disposition: inline
In-Reply-To: <200902241410.19132.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?B?77+977+977+91L/vv70=?= <q1.kim@samsung.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>

* David Brownell <david-b@pacbell.net> [090224 14:14]:
> On Tuesday 24 February 2009, Adrian Hunter wrote:
> > > I agree that code removed by this patch is ugly and worth
> > > removing if it's not actually needed for MMC1.
> >=20
> > Here is a patch against current OMAP tree.
> >=20
> > From: Adrian Hunter <ext-adrian.hunter@nokia.com>
> > Date: Tue, 24 Feb 2009 14:48:16 +0200
> > Subject: [PATCH] OMAP: HSMMC: do not re-power when powering off MMC
> >=20
> > Remove code that turns MMC1 power back on after it
> > has been powered off (when the voltage is 1.8V).
> >=20
> > The offending code is not necessary because the
> > host controller bus voltage is initialized to
> > 3V when probing or resuming. =A0Note that MMC powers up
> > with the highest voltage available (see mmc_power_up())
> > which will be 3V also.
> >=20
> > Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
>=20
> Looks OK to me -- ack.  Safe to merge through the MMC
> tree right away, but it'll be a NOP until the glue
> actually supports 1.8V correctly for MMC1 ... so IMO
> no rush to merge for 2.6.29-final.

Good to hear we get rid of that REVISIT part.. My ack here too.

Acked-by: Tony Lindgren <tony@atomide.com>
=20
> > ---
> > =A0drivers/mmc/host/omap_hsmmc.c | =A0 17 -----------------
> > =A01 files changed, 0 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
> > index c0d5420..43cec98 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -486,9 +486,6 @@ static int omap_mmc_switch_opcond(struct mmc_om=
ap_host *host, int vdd)
> > =A0=A0=A0=A0=A0=A0=A0=A0u32 reg_val =3D 0;
> > =A0=A0=A0=A0=A0=A0=A0=A0int ret;
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0if (host->id !=3D OMAP_MMC1_DEVID)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > -
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Disable the clocks */
> > =A0=A0=A0=A0=A0=A0=A0=A0clk_disable(host->fclk);
> > =A0=A0=A0=A0=A0=A0=A0=A0clk_disable(host->iclk);
> > @@ -787,20 +784,6 @@ static void omap_mmc_set_ios(struct mmc_host *=
mmc, struct mmc_ios *ios)
> > =A0=A0=A0=A0=A0=A0=A0=A0switch (ios->power_mode) {
> > =A0=A0=A0=A0=A0=A0=A0=A0case MMC_POWER_OFF:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_slot(host).set_=
power(host->dev, host->slot_id, 0, 0);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Reset interface vo=
ltage to 3V if it's 1.8V now;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * only relevant on M=
MC-1, the others always use 1.8V.
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * REVISIT: If we are=
 able to detect cards after unplugging
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * a 1.8V card, this =
code should not be needed.
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (host->id !=3D OMA=
P_MMC1_DEVID)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0break;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(OMAP_HSMMC_READ=
(host->base, HCTL) & SDVSDET)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0int vdd =3D fls(host->mmc->ocr_avail) - 1;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (omap_mmc_switch_opcond(host, vdd) !=3D 0)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0host->mmc->ios.vdd =3D vdd;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > =A0=A0=A0=A0=A0=A0=A0=A0case MMC_POWER_UP:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_slot(host).set_=
power(host->dev, host->slot_id, 1, ios->vdd);
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
