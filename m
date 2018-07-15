From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Sun, 15 Jul 2018 22:17:29 +0200
Message-ID: <20180715201729.GB19675@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711132739.GL99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-07-11 06:27:39, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180711 08:05]:
> > Hi!
> >=20
> > > > Its parent is gpio@4805d000 , and that one seems to be present.
> > > >=20
> > > > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > > > driver				       driver_override  gpio
> > > > gpiochip5  modalias  of_node  power  subsystem  uevent
> > >=20
> > > Sorry, something went wrong with merging this. The parent
> > > of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> > > not gpio6.
> >=20
> > Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
> > driver.
> ..
> > --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > @@ -159,13 +159,7 @@
> > =20
> >  		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
> >  	};
> > -};
> > -
> > -&dss {
> > -	status =3D "okay";
> > -};
> > =20
> > -&gpio6 {
> >  	pwm8: dmtimer-pwm-8 {
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&vibrator_direction_pin>;
> > @@ -192,7 +186,10 @@
> >  		pwm-names =3D "enable", "direction";
> >  		direction-duty-cycle-ns =3D <10000000>;
> >  	};
> > +};
> > =20
> > +&dss {
> > +	status =3D "okay";
> >  };
> > =20
> >  &dsi1 {
>=20
> Hmm sorry if I did a mismerge on the above. A note to
> myself to stop applying patches that apply with fuzz,
> that is clearly dangerous with dts files with lots
> of similar named properties.

Yep, so I have two patches that make the device appear, but vibrations
still do not work for me.

a) any ideas how to debug that / get them to work?

b) do you want the patches anyway?

Regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLq9kACgkQMOfwapXb+vImRwCgpccOZdn3aiVOwbbDd9pgzxkE
KpAAoJXA5B2v9flnKShBMWyr8DEpALqx
=eoy2
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
