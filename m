From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] Add support for bq27521 battery monitor
Date: Thu, 9 Nov 2017 22:45:40 +0100
Message-ID: <20171109214540.GB23376@amd>
References: <20171109210615.GA27638@amd>
 <20171109212945.2sgu56zkse7nbzo3@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171109212945.2sgu56zkse7nbzo3@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, afd-l0cyMroinI0@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-11-09 22:29:45, Pali Roh=E1r wrote:
> On Thursday 09 November 2017 22:06:15 Pavel Machek wrote:
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
> > index ed44439..ee2851a 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -381,6 +381,30 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] =3D {
> >  		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
> >  		BQ27XXX_DM_REG_ROWS,
> >  	},
> > +	[BQ27521] =3D {				/* FIXME */
> > +		[BQ27XXX_REG_CTRL] =3D 0x02,
> > +		[BQ27XXX_REG_TEMP] =3D 0x0a,
> > +		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_VOLT] =3D 0x0c,
> > +		[BQ27XXX_REG_AI] =3D 0x0e,
> > +		[BQ27XXX_REG_FLAGS] =3D 0x08,
> > +		[BQ27XXX_REG_TTE] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_TTF] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_FCC] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_SOC] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_DCAP] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_AP] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_DM_CTRL] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_DM_CLASS] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_DM_BLOCK] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_DM_DATA] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_DM_CKSUM] =3D INVALID_REG_ADDR,
> > +	},
> >  	[BQ27530] =3D {
> >  		[BQ27XXX_REG_CTRL] =3D 0x00,
> >  		[BQ27XXX_REG_TEMP] =3D 0x06,
>=20
> Hi! IIRC those registers are valid only for sn27521 chip in revision 14
> (or new). For older revision is used different register map. And
> detection of chip revision is somehow possible via some registers.

Yes, I know.. I even had this, but as I can't test it, and early N950
samples should be very very rare, I'd prefer the patch as is.

@@ -1905,6 +1940,23 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info=
 *di)
=20
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
=20
+	if (di->chip =3D=3D BQ27521) {
+		int val;
+		val =3D di->bus.read(di, 0x32, false);
+		if (val =3D=3D 0x2100) {
+			printk("rev. 13 chip detected; add support\n");
+			/* https://elinux.org/N950 has details */
+			return PTR_ERR(ENODEV);
+		}
+
+		val =3D di->bus.read(di, 0x34, false);
+		if ((val & 0xff00) !=3D 0x2100) {
+			printk("rev. 14 chip not detected?!\n");
+			return PTR_ERR(EINVAL);
+		}
+		printk("verified chip rev. 14\n");
+	}
+
 	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloEzIQACgkQMOfwapXb+vIF1ACePywsr0HPpSouo7JlVuc5ncVo
gtoAnR31A63h5i+bKEvX0pJrenGzGjjc
=aMzX
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
