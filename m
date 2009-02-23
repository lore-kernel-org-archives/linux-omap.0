From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when resuming
Date: Mon, 23 Feb 2009 10:23:49 -0800
Message-ID: <200902231023.49653.david-b@pacbell.net>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <9c9fda240902230426s2003d208xebeb6630c61b3bec@mail.gmail.com> <49A2A8ED.20208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n13b.bullet.mail.mud.yahoo.com ([68.142.207.222]:27922 "HELO
	n13b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751618AbZBWSXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 13:23:54 -0500
In-Reply-To: <49A2A8ED.20208@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?q?=EA=B9=80=EA=B7=9C=EC=9B=90?= <q1.kim@samsung.com>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>

On Monday 23 February 2009, Adrian Hunter wrote:
> Also, you will need the following patch if you actually want the powe=
r
> to go off.

Current GIT already has a patch supporting power-off for
MMC2; tested on SDP and some custom hardware.  So this
patch won't apply.

Are you sure that's needed for MMC1?  The led showing MMC1
power did go off correctly (when using MMC2 for root), and
the MMC1 regulator entry in sysfs agreed MMC1 was off.  So
I thought this was only an issue for MMC2 (and presumably
MMC3, though I don't have a board using it.)

I agree that code removed by this patch is ugly and worth
removing if it's not actually needed for MMC1.

- Dave


> From: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Date: Fri, 30 Jan 2009 11:58:13 +0200
> Subject: [PATCH] OMAP: HSMMC: do not power up after powering off
>=20
> The power is configured when probing and when resuming
> so the bus voltage does not need changing after power
> off.
>=20
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 10 ----------
> =A01 files changed, 0 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 1e4a2e0..04e5a0c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -859,16 +859,6 @@ static void omap_mmc_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> =A0=A0=A0=A0=A0=A0=A0=A0switch (ios->power_mode) {
> =A0=A0=A0=A0=A0=A0=A0=A0case MMC_POWER_OFF:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_slot(host).set_po=
wer(host->dev, host->slot_id, 0, 0);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Reset bus voltage to=
 3V if it got set to 1.8V earlier.
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * REVISIT: If we are a=
ble to detect cards after unplugging
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * a 1.8V card, this co=
de should not be needed.
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!(OMAP_HSMMC_READ(h=
ost->base, HCTL) & SDVSDET)) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
int vdd =3D fls(host->mmc->ocr_avail) - 1;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if (omap_mmc_switch_opcond(host, vdd) !=3D 0)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0host->mmc->ios.vdd =3D vdd;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> =A0=A0=A0=A0=A0=A0=A0=A0case MMC_POWER_UP:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_slot(host).set_po=
wer(host->dev, host->slot_id, 1, ios->vdd);



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
