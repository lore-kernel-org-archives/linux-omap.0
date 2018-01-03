From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] nokia N9: Add support for magnetometer and touchscreen
Date: Wed, 3 Jan 2018 12:53:42 +0100
Message-ID: <20180103115342.wnrvbzvxc4dtixdm@earth.universe>
References: <20180102131722.GA20706@amd>
 <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
 <20180103102553.GA28083@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bsywoacsfxoermk6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180103102553.GA28083@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--bsywoacsfxoermk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 03, 2018 at 11:25:53AM +0100, Pavel Machek wrote:
> On Tue 2018-01-02 18:27:20, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
> > > This adds dts support for magnetometer and touchscreen on Nokia N9.
> >=20
> > I think it makes sense to have this splitted.
>=20
> Creating more work for everyone for little gain? Meh.

More work for everyone? Could you please read Documentation/process
and actually follow it? It has a section about patches containing a
single logical change and you add two completly unrelated devices to
the device tree.

Also I suggest, that you rework your git workflow if this makes
more work than writing two sentences.

> > > diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3=
-n9.dts
> > > index 39e35f8..57a6679 100644
> > > --- a/arch/arm/boot/dts/omap3-n9.dts
> > > +++ b/arch/arm/boot/dts/omap3-n9.dts
> > > @@ -36,6 +57,22 @@
> > >  			};
> > >  		};
> > >  	};
> > > +
> > > +	touch@4b {
> >=20
> > touchscreen@
>=20
> Ok.
>=20
> > > +		compatible =3D "atmel,maxtouch";
> > > +		reg =3D <0x4b>;
> > > +		interrupt-parent =3D <&gpio2>;
> > > +		interrupts =3D <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
> >=20
> > reset-gpios =3D <&gpio3 17 GPIO_ACTIVE_SOMETHING>;
> >=20
> > > +		vdd-supply =3D <&vio>;
> > > +		avdd-supply =3D <&vaux1>;
> >=20
> > Those two are not mentioned in the binding and not supported by the
> > driver as far as I can see?
>=20
> Driver will need to be fixed, AFAICT :-(.

Obviously. DTS is only updated when binding has been acknowledged,
though. To get this working ASAP you can add "always-enabled;" to
the regulator and remove it once the driver gained support for
enabling the regulators itself.

> > Touchscreen with the same settings is required for n950, so it
> > should be in the shared n950 + n9 file.
>=20
> In future, settings will be different for n9/n950: calibration matrix
> is different as panel is rotated in different way. Still it probably
> makes sense to share. Ok.

The differences can be specified in the specific files by doing
something like the following:

n9-n950.dtsi:
ts: touchscreen {
    shared-properties;
};

n9.dts:
&ts {
    only-for-n9;
};

n950.dts:
&ts {
    only-for-n950;
};

> > > +&i2c3 {
> > > +	ak8975@0f {
> > > +		compatible =3D "asahi-kasei,ak8975";
> > > +		reg =3D <0x0f>;
> > > +	};
> > >  };
> >=20
> > Looking at the N9 board file this is missing a rotation matrix. This
> > is supported by the binding:
> >=20
> > Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>=20
> Do you have an idea how the rotation matrix should look like? I don't
> currently have an userland software that could calibrate and test the
> sensor, so I'd prefer to merge basic binding now and do calibration
> later.

Well you take the values from sysfs, multiply it with the rotation
matrix and check if the values look ok. No special userspace tools
required except mount (for sysfs), ls & cat.

-- Sebastian

--bsywoacsfxoermk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpMxEMACgkQ2O7X88g7
+pp4ag//cyXjvWD7q6/D85CbBTVGXXbjXA6+CVaGBBB5rpMRE8k4AFiYZI9W87t6
uzlNTPsU1yDSiNjUUAhbcrSNROn4d7bPMeqm/tNLPkH0yMDULFigg42mB5pagt5+
b/fa/0t9APmqffemv/GTm4mTU7h7N2AgTFNcgj8d+kaEqCnWAm6a7HKuoOCdtI/o
QCiVX2uoHNmaYcCM4yyT0MxF/2Pb+wV8LuC0EwjJb38aIiY/C1OnEb37WkKVXAxI
qJ4tgOF0e7J896IO8HdsDXVZA0MP3vNbkKoPXewbkxB9ZuaWg1fTNsurlmK12HiL
GL7Njkid8Lh+OJR0dyP7MyXWRlcByXxdApDsz9ZsCGGEQ4oVFeKADALvMnouEVlT
XoPgQaA73cygTVPAUBT5u2lQdzMkZ0RL6EUdLVJvu15a5MWldhdVZ1xuaWzpeptC
d66Ep+qN+kE8KbwM6fW+1AAHPLSv2KoFiNPybMqA9IGdUuanrTmlYiXH3rEvYOut
SdQ//XxIP5I0pBSRbJLW1tIJRIrHHBO/e2FDmhU/UXci4rfBT9ltTUTr/CRxBVw7
4vbchl27qC3k2k2/2xRCyx32/rPFB1GjevEV6NpThhZmUg9nSRxm3hkOMnrOlz90
8qzbdpgZhf6L6UFVD6YOb+CW+1cjdIB6nwOalgl7O1SKnzgm2eE=
=FZGD
-----END PGP SIGNATURE-----

--bsywoacsfxoermk6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
