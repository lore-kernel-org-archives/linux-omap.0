From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Tue, 10 Jul 2018 15:30:40 +0200
Message-ID: <20180710133040.GA4391@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180710101147.lyu65ro4czvrs2da@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 12:11:47, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > Do you have vibrations on d4 working?
> > > > I believe I have required drivers enabled, but no luck:
> > > >=20
> > > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > > bind  uevent  unbind
> > > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > > bind  uevent  unbind
> > >=20
> > > Have you checked probe deferrals?
> >=20
> > Not really. Is there easier way to do that than adding printks in the
> > probe function? (I can go through dmesg tommorow).
>=20
> Option 1: https://lkml.org/lkml/2018/7/8/63

I tried this methodq, and no luck.

static int pwm_omap_dmtimer_probe(struct platform_device *pdev)

does not seem to be called.

Its parent is gpio@4805d000 , and that one seems to be present.

user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
driver				       driver_override  gpio
gpiochip5  modalias  of_node  power  subsystem  uevent

So I'm now confused.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEtQAACgkQMOfwapXb+vIgrwCeK6kvpDJt3t59+EQq3uaP5JSI
J04AnR+VSJy8R+0VMkQAVA/Uc0VgjkmP
=vCN0
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
