From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] regulator: lp873x: Add support for lp873x PMIC
 regulators
Date: Fri, 6 May 2016 13:02:06 +0100
Message-ID: <20160506120206.GO6292@sirena.org.uk>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
 <1462425040-18566-4-git-send-email-j-keerthy@ti.com>
 <20160505153820.GF6292@sirena.org.uk>
 <572C20EC.7000706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FJOUHINv8uyEJFmS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <572C20EC.7000706-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--FJOUHINv8uyEJFmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2016 at 10:13:24AM +0530, Keerthy wrote:

> I am using of_platform_populate function in the mfd driver to create
> platform devices for the child nodes, in my case regulators.

> of_platform_populate in turn calls on to of_platform_bus_create which
> mandates compatible properties. It quietly skips device creation if there
> are no compatible properties.

You shouldn't be using that, you should just have a table of subdevices
in the MFD.

--FJOUHINv8uyEJFmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLIe8AAoJECTWi3JdVIfQnYgH/0zkEQttYknwp7FqjTE3Cj5+
omdo8zs00wgBBIFUxzAJWol9/8nW31Iq81LQyNYZkbnCpy07uh13+v7Hikpxum6G
mqmCAbTdCTtq/MkKIwLmQ160PfRf0O4oSJoJVfeq+RXdvvyXiFs5/of76LJQj1hB
1kK5j4M3n4im34DNuUTThrvTZxJwP7hecIpH1nZxucS8Ivlorew40IuZYVHD/DHy
lS6b8ndEP65hsNXqGWkJKYEx/AV8dPvJ1Ao21Vh1sS1F8HH7BSFFrHMtvdAH2Q9u
PwhnHCvO5uxrsE6UutkGHKyRTzWBEApsgTIt6Es/qCpRzsMlzU8bdI51biN8fCM=
=8Ta2
-----END PGP SIGNATURE-----

--FJOUHINv8uyEJFmS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
