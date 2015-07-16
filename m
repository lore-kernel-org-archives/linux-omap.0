From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] Input: tsc2005 - convert to gpiod
Date: Thu, 16 Jul 2015 11:14:58 +0200
Message-ID: <20150716091458.GA28629@earth>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-5-git-send-email-sre@kernel.org>
 <20150715213404.GC24393@dtor-ws>
 <20150715220940.GD2591@earth>
 <20150716002532.GF24393@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150716002532.GF24393@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2015 at 05:25:32PM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 16, 2015 at 12:09:41AM +0200, Sebastian Reichel wrote:
> > On Wed, Jul 15, 2015 at 02:34:04PM -0700, Dmitry Torokhov wrote:
> > > [...]
> > > >  	if (np) {
> > > > -		ts->reset_gpio =3D of_get_named_gpio(np, "reset-gpios", 0);
> > > > -		if (ts->reset_gpio =3D=3D -EPROBE_DEFER)
> > > > -			return ts->reset_gpio;
> > > > -		if (ts->reset_gpio < 0) {
> > > > +		ts->reset_gpio =3D devm_gpiod_get(&spi->dev, "reset",
> > > > +						GPIOD_OUT_HIGH);
> > >=20
> > > I think we should treat the gpio as optional and try to get the
> > > descriptor event on non-OF boards.
> >=20
> > As I wrote in the cover letter, I suggest to change this once the
> > Nokia N900 board code has been removed. At that point changing the
> > board code API is much easier, since it won't affect multiple trees.
>=20
> I do not see why it has be wait for Nokia board code. Just make it
> devm_gpiod_get_optional() and call it unconditionally and fall back onto
> custom reset function (if one is supplied).

Right. I guess the same could be done for vio regulator. I will
add this change in the next version of the patchset.

-- Sebastian

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVp3YPAAoJENju1/PIO/qaSUIQAJ9Gz6W3mFw9Jzd64V86DqSG
IWerOgqw1WhHTJE/TAPNqOW33ru5kMQeVh+jC1ONPjLOZVaX9WxjMVjPgz01+5bM
0MWoRlyiY/ebd+cQPKMPDWUQVySYVC6TxZNOsVegSc4qZFh2kE/LExC6axcrhUNB
ttsfKViTorDwRDIBCPO6El/HP9ALqeCCplicMDVy5b/rxSQHg785MncIlqmM6NLc
RiBtl67ANmPeBbkpX/cDRegRN9nW5Y0PKFccpuv9VEy5tpVWwDIMjkgH4KlU1aMr
L/vya49ahtGRnslwafRqq5D5h3hWUARch7LFL9wOUr66V6As9wVF4R6Civg2UkFX
e59HRYS3jTvMOx9Sz/Bxr2UONv8nlAsb8JIKmgIpN/VmXGcfpuB5hD969JouiNtd
MOT1v57e0zMXnRDl0Xylh+jl8M8tOllAwNiQO+5BkVqF5IrKc1R20PSqR4GfkdbK
CtNIGS9ndY3A29AKukh0KlATMHRC002yH3xOb9F/Wza6j/dJ7uBjPNluZOGz1OAJ
o12N36jbGAbAGAdCNdLgS38ulFbsP0e1q6x8t99LYSp20Gmb3gKRONS5Ig3EWGYm
JF0+qf8833fqzCTbF7cp3lEIspwxdVenjQcsEohZZQvkRkl7vPmkaMNfsaFt6plW
bUtsCZz1feSlXB/veo80
=2D4i
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
