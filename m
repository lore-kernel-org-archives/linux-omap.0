From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] n900 device tree: cleanup, add camera flash
Date: Tue, 11 Oct 2016 10:10:00 +0200
Message-ID: <20161011081000.GA24476@amd>
References: <20161011075416.GA22453@amd>
 <20161011080139.GK4467@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1723112543337434929=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161011080139.GK4467@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============1723112543337434929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-10-11 10:01:39, Pali Roh=E1r wrote:
> On Tuesday 11 October 2016 09:54:17 Pavel Machek wrote:
> > @@ -669,6 +670,22 @@
> > =20
> >  		ti,usb-charger-detection =3D <&isp1707>;
> >  	};
> > +
> > +	adp1653: led-controller@30 {
> > +		compatible =3D "adi,adp1653";
> > +		reg =3D <0x30>;
> > +		gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> > +
> > +		flash {
> > +			flash-timeout-us =3D <500000>;
> > +			flash-max-microamp =3D <320000>;
> > +			max-microamp =3D <50000>;
> > +		};
> > +
> > +		indicator {
> > +			max-microamp =3D <17500>;
> > +		};
> > +	};
> >  };
> > =20
> >  &i2c3 {
> >=20
>=20
> This part of patch is already in mainline kernel, isn't?

Oops, sorry about that. Disregard the patch.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf8nlgACgkQMOfwapXb+vLo6gCeP96VYgrW4ECELHyL4qthcNO+
2sEAn35t8JlRJeqwF06LdkrZmtdVbcHr
=Dvfk
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--


--===============1723112543337434929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1723112543337434929==--
