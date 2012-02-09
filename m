From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3 v5] usb: musb: Add support for ti81xx platform
Date: Thu, 9 Feb 2012 10:08:23 +0200
Message-ID: <20120209080822.GR1121@legolas.emea.dhcp.ti.com>
References: <1328675212-29693-1-git-send-email-ajay.gupta@ti.com>
 <4F321320.8010709@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v6YRErhBvjoBjrPV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48713 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756586Ab2BIII2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 03:08:28 -0500
Content-Disposition: inline
In-Reply-To: <4F321320.8010709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi Babu <ravibabu@ti.com>


--v6YRErhBvjoBjrPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2012 at 11:46:00AM +0530, Shubhrajyoti wrote:
> On Wednesday 08 February 2012 09:56 AM, Ajay Kumar Gupta wrote:
> > +static int dsps_musb_init(struct musb *musb)
> > +{
> > +	struct device *dev =3D musb->controller;
> > +	struct musb_hdrc_platform_data *plat =3D dev->platform_data;
> > +	struct platform_device *pdev =3D to_platform_device(dev->parent);
> > +	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> > +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> > +	struct omap_musb_board_data *data =3D plat->board_data;
> > +	void __iomem *reg_base =3D musb->ctrl_base;
> > +	u32 rev, val;
> > +	int status;
> > +
> > +	/* mentor core register starts at offset of 0x400 from musb base */
> > +	musb->mregs +=3D wrp->musb_core_offset;
> > +
> > +	/* NOP driver needs change if supporting dual instance */
> > +	usb_nop_xceiv_register();
> > +	musb->xceiv =3D otg_get_transceiver();
> > +	if (!musb->xceiv)
> > +		return -ENODEV;
> > +
> > +	status =3D pm_runtime_get_sync(dev);
> > +	if (status < 0) {
> > +		dev_err(dev, "pm_runtime_get_sync FAILED");
> > +		goto err0;
> > +	}
> So you are doing a get_sync at init and you cut the clocks at exit only.
> Any particular reason for that.

that's a very good question. We're just adding a brand new file, which
is clean and stuff... so we might as well start with good PM
capabilities.

--=20
balbi

--v6YRErhBvjoBjrPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM371AAoJEIaOsuA1yqRE1aIQAKlEbeDw/4bfbZh0Ip8XxaWU
tRVIxGdROUJjwFZEPCocjH9xm64G17lfKQ9QuEec/BCvCcExznPkCFR+vhIdT82x
FmbkaIMFCxAlfTYa5rJ0gd0cB9NxbfPFvnD/MQIvUHw62r+uwAj0r5yausdVvCIY
cm5JoMsqimGetZYt5H0DrwkfXASXGQ7xJ3fiI1V63m1KsrIC8fi9CMi/eRq36txp
fNUTiP3epBd9HuWB7wlIXpjc2M/lo0CVqQLzCJ3nqDc8ZbETc5vk+F3X+D40uANf
Vw6uhU8cuhsIPGY5gAAKaWUZ0cQqi4zLil2nnzo4mrxRHZguTb3P1nRaehZv737H
kSmFwEyQnaAx/pGe4WBAoHhYiTTYAABimy938CNAjfO8dX9iGAiEGJJVjqPgmEMU
89B+Tkzui9Y6KzGThcKOxmJrqsYmLvT/isPwqXmt62jBX+pX4ORwdqRRX93JG323
fOzYZGgn08o/OjKNzyLB6dmnyUc+p5PjRGzT2sESDJh7UoKo2HZsHXjdDoWcjrOx
TZnWsZDxYfHADW8JwvMO8tuZGafzs/z1Gco8TnHzf0vXfC/vyPbjKzoN9tCFPfYD
Jou8Lyy4gOEp8SnO2qfMIoudSOZ/XBWlFcfed9aBt4HrWSt10ugSgl2YsRK914Iu
UGNO2J3VGzuyNq+xIHYR
=EwhS
-----END PGP SIGNATURE-----

--v6YRErhBvjoBjrPV--
