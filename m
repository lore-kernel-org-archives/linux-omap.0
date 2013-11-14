From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in TSC/ADC
 DT binding
Date: Thu, 14 Nov 2013 09:54:04 -0600
Message-ID: <20131114155404.GE15835@saruman.home>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
 <1382386404-6659-2-git-send-email-balbi@ti.com>
 <52663A58.9070706@linutronix.de>
 <20131022120253.GD9340@gimli>
 <20131114111958.GG16396@e106331-lin.cambridge.arm.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37618 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3KNPyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 10:54:51 -0500
Content-Disposition: inline
In-Reply-To: <20131114111958.GG16396@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "rob@landley.net" <rob@landley.net>, "bcousson@baylibre.com" <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Thu, Nov 14, 2013 at 11:19:59AM +0000, Mark Rutland wrote:
> > On Tue, Oct 22, 2013 at 10:42:00AM +0200, Sebastian Andrzej Siewior wro=
te:
> > > On 10/21/2013 10:13 PM, Felipe Balbi wrote:
> > > > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/in=
put/touchscreen/ti_am335x_tsc.c
> > > > index e1c5300..b61df9d 100644
> > > > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_devi=
ce *pdev,
> > > >  	if (err < 0)
> > > >  		return err;
> > > > =20
> > > > -	err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > > > +	/*
> > > > +	 * try with new binding first. If it fails, still try with
> > > > +	 * bogus, miss-spelled version.
> > > > +	 */
> > > > +	err =3D of_property_read_u32(node, "ti,coordinate-readouts",
> > > >  			&ts_dev->coordinate_readouts);
> > > >  	if (err < 0)
> > > > +		err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > > > +				&ts_dev->coordinate_readouts);
> > > > +	if (err < 0)
> > > >  		return err;
> > >=20
> > > Thanks, very good. Do we keep this fallback for ever or just for a ye=
ar
> > > or two?
> >=20
> > That's for DT maintainers to decide but considering DT is an ABI, I
> > guess we need to keep for 30 years or so :-p
>=20
> We keep it as long as we have to. If no-one's relying on the typo by the
> next merge window, I see no reason we'd have to keep support for the

and how could you know that ? considering it's an ABI, how could you
ever know that ?

--=20
balbi

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJShPIcAAoJEIaOsuA1yqREB9sP/1MPk+MC4xlmxzCLOg9tUjYw
wOeCmLX4UR/iJOMG/GZ/tOJlq7fs/J66lLOdQTs+Ytg/Oi8kRnJdMXWlGnCdmb1f
lrYZHCpyBQ0bfjcFGt3s9LWywMHrHvVXg0bOt96VRC46l5O7BY4kKNtnsH6UwPuG
bbVGftI3w14qZiBOn5OYpYtluQLwZ2Oqi3j803VttITXKx+QekOjP/z/7SZWi6iV
/UFmdUDTeNxhdhMjKETCJ+DO6stJrM0yxrOgfBkMCmrGDJ5PTZ6G44h2KuYCFsGO
wbBPn9wwak49/ljdHzYVAuWUXz/+l6Y1jPPCv7sn8PwgiFZiOJzd7Ulpnx73PYBl
ULvUw66hOrRoBXFXCHHUgbwDHZeByqtltUT1hN4YfoqFn31UEKx4O+lYh8+NZe/x
XpiWzQsys2ko8NnEtZLa6kZdIhHCRzRRz3G+gFq2MGiYknrqqPmHfeJBghMqsG5j
fb0ny9CnpUBubSuNcQMbOk49JGpHgArM+3QlLxBwjAd44qnKmW4KgKJOO1BIKfIn
TrybWupSxuZxW5WKzaKX4E6PaRaM6HHqqRxDkzjFn19m95L/yGAqG7Omde6a3mne
U1qkd9eJpga5w1hg+cazep4sbMPKW6+EGxbKk3heaKCr4/JQPVdCN3+Z7/Sms6AU
ZsnmrioLprUpTqiDiqc5
=Cstf
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
