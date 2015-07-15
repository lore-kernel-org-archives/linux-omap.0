From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] Input: tsc2005 - convert to gpiod
Date: Thu, 16 Jul 2015 00:09:41 +0200
Message-ID: <20150715220940.GD2591@earth>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-5-git-send-email-sre@kernel.org>
 <20150715213404.GC24393@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715213404.GC24393@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 15, 2015 at 02:34:04PM -0700, Dmitry Torokhov wrote:
> [...]
> >  	if (np) {
> > -		ts->reset_gpio =3D of_get_named_gpio(np, "reset-gpios", 0);
> > -		if (ts->reset_gpio =3D=3D -EPROBE_DEFER)
> > -			return ts->reset_gpio;
> > -		if (ts->reset_gpio < 0) {
> > +		ts->reset_gpio =3D devm_gpiod_get(&spi->dev, "reset",
> > +						GPIOD_OUT_HIGH);
>=20
> I think we should treat the gpio as optional and try to get the
> descriptor event on non-OF boards.

As I wrote in the cover letter, I suggest to change this once the
Nokia N900 board code has been removed. At that point changing the
board code API is much easier, since it won't affect multiple trees.

> [...]

-- Sebastian

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVptokAAoJENju1/PIO/qaPJYP/3Ec9XR8hPzjinwwuthM2w4A
tKCjjR08aZEKq5zv/QnbnbOL1lGMj+YCjrwFcAg8HFY45C4Ke/8opp8iQHl5x/Z9
7vXIrMEnJAZQacF9uzJtNVkIGqGAoexvxcUgoltDCpqhdXse+PdemyAX/nsU2CUH
NFfDwcAxmJE6lyYIktd/Z6rq3INxPRlF1ZWFMMM8SNbxumtlpIcLJnpzQvpLoxiR
TPiR4Ze4p2jKNXkdfxEEVziI6/WzSOMOp9XsqG1TI9sLL0Fwm+SZQnDfg1VSOM8N
fU5XWEEG8godGi/VENNrQDMXKZKM9ckRvJ7lWofXcK4afPD+2E/vPbzE8lhZP0Zq
rP6BVaHvkSlEf0ohtlIW9YEZKpAg6k5/6f1ap5XEBwMYsKI7e1Rf9H6WkTlZlFFe
PI7n2ly9K1BpizoO7NVBvSK68onSOfhAOPVHRily92MNw55/tCVNivXINqeC7fFC
PzqPM5+8Hto9s0IfxlLvN2QgmEcmAaFf9POwvvGCz1Yhlk7E35wCa0IMhMGRY/IL
0JyModAjkWVA6Y8uEc6t4EtdYcve1rKafQOkzfLZAvh8KWZo4UtsPQvv1S2T7Snn
E3VApklVIDFNkI9sH39to3vCMk9QpHTxyUHJPo9rPkJPfFDIiHr7BU9fXXx6h+20
TKbRUvYo57jsIodt9Vj1
=ItoP
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
