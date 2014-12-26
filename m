From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] DT Binding for omap3 temperature sensor
Date: Sat, 27 Dec 2014 00:50:33 +0100
Message-ID: <20141226235032.GA29735@earth.universe>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-2-git-send-email-sre@kernel.org>
 <20141226171944.GA24756@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141226171944.GA24756@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Pali Rohar <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Fri, Dec 26, 2014 at 06:19:44PM +0100, Pavel Machek wrote:
> On Fri 2014-12-26 13:34:52, Sebastian Reichel wrote:
> > OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> > which can be used to determine the SoCs temperature. This provides a
> > DT binding specification for the temperature monitor.
> >=20
> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  .../bindings/hwmon/omap3-temperature.txt           | 25 ++++++++++++++=
++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-tempe=
rature.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/omap3-temperature.=
txt b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> > new file mode 100644
> > index 0000000..99631ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> > @@ -0,0 +1,25 @@
> > +* OMAP3 temperature sensor
> > +
> > +The OMAP34xx and OMAP36xx processors contain a register in the syscon =
area,
> > +which can be used to determine the SoCs temperature.
> > +
> > +Requires node properties:
> > +- compatible :	should contain one of
> > +	- "ti,omap34xx-temperature-sensor" for OMAP34xx
> > +	- "ti,omap36xx-temperature-sensor" for OMAP36xx
> > +- syscon :	Should be a phandle to system configuration node which
> > +		encompases the temperature register
> > +- clocks :	Should contain 32KHz fclk clock specifier
> > +- clock-names :	Should contain clock names
> > +	- "fck" for the 32KHz fclk clock specifier
>=20
> I don't quite get it. The temperature sensor is internal on the CPU,
> right? Why do we need device tree to describe it? As soon as we have
> CPU that is compatible to ti,omap3430, we know everything we need to
> know, no?

Lots of stuff is SoC internal and described in the DT (e.g. serial
controllers). Just have a look in omap3.dtsi or omap34xx.dtsi.

I put the temperature sensor into its own node for the following
reasons:

 * syscon reference
 * clock reference

I first thought about loading the driver from the syscon driver,
but omap uses a generic one, so that's not an option. Apart from
that one would still need the clock reference.

> > +Example for omap34xx:
> > +
> > +/ {
> > +	temperature-sensor {
> > +		compatible =3D "ti,omap34xx-temperature-sensor";
> > +		syscon =3D <&omap3_scm_general>;
> > +		clocks =3D <&ts_fck>;
> > +		clock-names =3D "fck";
> > +	};
> > +};
>=20
> Or is there something that depends on the board there? Or do we want
> to do it like this to be consistent with existing bindings?

This is SoC specific and should go into the omap34xx.dtsi and
omap36xx.dtsi files. See also PATCH 3/3.

-- Sebastian

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUnfRFAAoJENju1/PIO/qahdoP+wdNC4pbt8G2UmiQUb8Z9mde
EpLP0cJ9cAcGvG/W828PFZmdcdHeEsm6IsuSZUj9HYoCAndtbaeqsQ0xN1WossMF
wPZ+9A9KWdx+FswQVByJnpWDYd9y+yQN3Wo1C69g62+6eUe+kuSRZAab1mrnhU+M
/+ygbknk7OJpiJa+fYdCyjzcnV7Sq8xKfO8K79qpvuHEZuF0X8SsY3zO802L6BWm
YrFTA0jWPrwDwmpSOMGB1E3jQBgz7J4DjmZgt8O5R5uo7kB2KjaxHrd4hQFgF0Vn
ythh9TYImJFXGi4sZ7IVHf3ONzuNPRhNu+0WBmZXdg4b/CrJ+1ID8Zw9dWIUesQx
Zx80yABcUDmIZmlsLxosOONA2G4te8nCVFFZ49673D25pBRl5e0jE00pMHcUOTPI
WsMOQdNhQgJnsZSgd2NLr7NWa4Bnuz23VDK73vZ3vRVS4Rofr/IsYESpkhh+tMl6
bBJPzGX6kBlxjZK+2zjH+P/Ocrjkf1AGcJQKgQVOXbKi5j4qe1d10KOvVNXYnxRm
kbw/OE5fj8SHh57ePv4+qJK95ao5oqLOsCC4RbjwNe7et9iayC5VZEisVkbUUv4D
ct5kSmq625N90y3qf+JkYVjZtYVNBb1PGzWS+A5UV55gw1SHs1E1PBU4aqvzN8pK
pr+8j8+9xkLQD0z4EliB
=RrdN
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
