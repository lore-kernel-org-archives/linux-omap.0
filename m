From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
Date: Wed, 18 Jun 2014 18:23:27 -0500
Message-ID: <20140618232327.GC9855@saruman.home>
References: <1403106200-777-1-git-send-email-balbi@ti.com>
 <1403106200-777-3-git-send-email-balbi@ti.com>
 <53A1BADD.7050309@ti.com>
 <20140618193113.GC4570@saruman.home>
 <53A20A7D.3060508@ti.com>
 <20140618231923.GA9855@saruman.home>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140618231923.GA9855-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Josh Elliot <jelliott-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, r.sricharan-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(side note)

On Wed, Jun 18, 2014 at 06:19:23PM -0500, Felipe Balbi wrote:
> > >>>+		interrupt-controller;
> > >>>+		#interrupt-cells =3D <2>;
> > >>>+
> > >>>+		dcdc1: regulator-dcdc1 {
> > >>>+			compatible =3D "ti,tps65218-dcdc1";
> > >>>+			/* VDD_CORE limits min of OPP50 and max of OPP100 */
> > >>>+			regulator-name =3D "vdd_core";
> > >>>+			regulator-min-microvolt =3D <912000>;
> > >>>+			regulator-max-microvolt =3D <1144000>;
> > >>>+			regulator-boot-on;
> > >>>+			regulator-always-on;
> > >>>+		};
> > >>>+
> > >>>+		dcdc2: regulator-dcdc2 {
> > >>>+			compatible =3D "ti,tps65218-dcdc2";
> > >>>+			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
> > >>>+			regulator-name =3D "vdd_mpu";
> > >>>+			regulator-min-microvolt =3D <912000>;
> > >>>+			regulator-max-microvolt =3D <1378000>;
> > >>>+			regulator-boot-on;
> > >>>+			regulator-always-on;
> > >>>+		};
> > >>>+
> > >>>+		dcdc3: regulator-dcdc3 {
> > >>>+			compatible =3D "ti,tps65218-dcdc3";
> > >>>+			regulator-name =3D "vdds_ddr";
> > >>no voltage ?
> > >
> > >has no users in kernel. Also, it comes out with default, and correct,
> > >voltage.
> >=20
> > Device tree is description of hardware, not just who uses what in OS
> > of interest.
>=20
> then we should start "fixing" every single DTS in the kernel because I'm
> sure even LEDs and keypads are tied to some sort of supply, as is the
> case with this board. No driver will use it though.
>=20
> Also, I couldn't find anywhere which voltage is dcdc3 outputing and
> there's no shunt anywhere (other than a 0 ohm resistor) to measure
> voltage. So I kinda have my hands tied here.
>=20
> (goes review schematics)
>=20
> actually there's 0.05 ohm sense resistor. Hopefully it's easy to access.

1.35v

--=20
balbi

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToh9vAAoJEIaOsuA1yqREIvwP+wZd5LlwXyKmBkl3lSk7dbv+
JCuWUYRO2TrpTIZiTrf+fs0eBcd0rjnNa3cah3Tvba9tl0l3pspgs1arxQMI892c
kU45fyFUFmvDezvdndVuuaXAiNG0NiUieTdcOj2vR+hVts9YnzTbvnlMWVOraDFz
JqLRieof8/mQBDAYd7oesnTZgwvK/JmeQAIA9W012Ajko5DmpZfxODntudB3HNtK
Y6ZqXNWCLPAfeOnUgF0/mjfNT69YZLo1pvSxqsT9F1jUv0nLmjFk+4Dgx+G4Xi3Q
UVhBV2O7647aFyxczJE9LnmNfhPX1LCPntKj5l5IDbqXt7m/Q6SSf/3TaXIYEWPZ
dnXjVgRELhx06JMyd8pH1di/X/qncgXDW92RGjdj38fq6MudBsfhHWIGNJJD5aR0
r+YXfI9Ivm8Qz/FCgeSjoUpFtFYDzzgXnlcsOyVvRMJrJer84/gUIlI1Lofo8xsB
iHChrUM3BYCVg4q0mm8VJyb2UtD1A9h3xoOQsE924q5yBr4IHcAtep9uR77z6dXs
MkXX76YoWEHgO1IrAALDaFEL+2hn7hKs/JWOk4OgPTz5nEluax1usNqJZbCUYTYB
vYNDaDvIo2MqFqj9zXIEdEptFnnAP0zhA6RXAHuReM4kPqXtGzP7dP6MUpbtaOVu
7IbhazpGcHYgDpCrMouL
=5O9P
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
