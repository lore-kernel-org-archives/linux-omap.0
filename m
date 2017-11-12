From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] omap3-n900: enable autofocus
Date: Sun, 12 Nov 2017 15:29:18 +0100
Message-ID: <20171112142918.rqxd2uk7ljyhpctt@earth>
References: <20171112112528.GA21009@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmkpfguipaabyprz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171112112528.GA21009@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--kmkpfguipaabyprz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 12, 2017 at 12:25:29PM +0100, Pavel Machek wrote:
>=20
> Connect auto-focus coil to the camera sensor, so that it can be used
> by camera applications.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I think you should replace auto-focus with lens-focus. This is not
automatic. Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index 669c51c..59cc743 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -778,6 +778,8 @@
> =20
>  		reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
> =20
> +		lens-focus =3D <&ad5820>;
> +
>  		port {
>  			csi_cam1: endpoint {
>  				bus-type =3D <3>; /* CCP2 */
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--kmkpfguipaabyprz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloIWr0ACgkQ2O7X88g7
+po9AA/+OVyoEZvTJLJW+tnfBamyILH6995rHhYSND/atb9ssRDzjTPeOWosbihu
pgekEmm7Ih7SzDoMBsS006cFJGcUYnzHxGpsDpKMMsShbTgTomz0SBhqZ03wAPoz
VfSGGHNGJgEs488E41ptfUHZkNkF9FxzpZEhPd27ryeThjIb25gvQ4V1RPs5bcqs
kB3bo6gAmjLcPMpcPbUDbheC03GjeLXy29cXGu4LFpJ3kQqFWr9D62V2mrbuEeLg
XtNwqGqACcqUynWvj6ADHRn6R6YUeSEs9U1HeOi9FhU6mNCzYcX28xNFQaeAIMHJ
jsD8Wpi8IIIQelIRvc7zeBQ0C6U0/fUujEx0xK6EWJrPsqDbCBJd105J5gx2CQAO
W0mVjUXNI/2FhzhEF6ImcSwvNcKt8HeSvTTN4ZWBEiOCnHPTDmPN+u2lS3ZvNeL4
HAyankqh40w3ZnHOWadt/uHx6r/gzQCBLCNnxQ8+q+bfQZUJZ6lWN0U0CJVW6WV4
CFo87DvdlNZtg11UM2to8tMhuiQyEwAmqQleUD8XNCpse3YI+yNiMHZ+LN3w8MEz
KqE6Gj1+I+jpLbbUx+iUBpjIA13SNrEaNstrmKT+fKV7IMC3R1PNjipofYUPgRTy
1A0IehJp1odWscclk5UA457MR9zDoNrPBVsdUxljlQ+BMVfbGMM=
=xIBy
-----END PGP SIGNATURE-----

--kmkpfguipaabyprz--
