From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] n900 device tree: cleanup
Date: Wed, 14 Dec 2016 13:28:27 +0100
Message-ID: <201612141328.27244@pali>
References: <20161011075416.GA22453@amd> <20161011081243.GA24580@amd> <20161207031048.pi7j4dms5uuco3yf@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3638040.DW2B4hSsXt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161207031048.pi7j4dms5uuco3yf@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart3638040.DW2B4hSsXt
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 December 2016 04:10:48 Sebastian Reichel wrote:
> Hi Tony,
>=20
> It looks like this fell through the cracks. Apart from inconsistent
> patch subject:
>=20
> Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

=46ine for me too. Reviewed-By: Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> -- Sebastian
>=20
> On Tue, Oct 11, 2016 at 10:12:43AM +0200, Pavel Machek wrote:
> > Fix GPIO comment to be consistent with rest of file and add comment
> > what tpa6130 is.
> >=20
> > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts
> > b/arch/arm/boot/dts/omap3-n900.dts index bfffd6c..ca9fe8c 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -47,7 +47,7 @@
> >=20
> >  		compatible =3D "gpio-leds";
> >  		heartbeat {
> >  	=09
> >  			label =3D "debug::sleep";
> >=20
> > -			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
> > +			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
> >=20
> >  			linux,default-trigger =3D "default-on";
> >  			pinctrl-names =3D "default";
> >  			pinctrl-0 =3D <&debug_leds>;
> >=20
> > @@ -637,6 +637,7 @@
> >=20
> >  		reg =3D <0x55>;
> >  =09
> >  	};
> >=20
> > +	/* Stereo headphone amplifier */
> >=20
> >  	tpa6130a2: tpa6130a2@60 {
> >  =09
> >  		compatible =3D "ti,tpa6130a2";
> >  		reg =3D <0x60>;

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart3638040.DW2B4hSsXt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhROusACgkQi/DJPQPkQ1KqIgCgpXmjSy8k78ZLYJOuhYALLbsN
Hk8An3Ol5j64MuvFtp3OJ0s1699hEmhu
=0Yiq
-----END PGP SIGNATURE-----

--nextPart3638040.DW2B4hSsXt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
