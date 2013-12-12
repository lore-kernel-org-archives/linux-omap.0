From: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 11:05:28 +0100
Message-ID: <20131212100527.GA860@earth.universe>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com>
 <37483030.ghHfzYFSnL@avalon>
 <10507960.9DXH4TSv2E@avalon>
 <52A968BD.20304@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52A968BD.20304-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 09:41:49AM +0200, Tomi Valkeinen wrote:
> > A label property is still an option.
>=20
> Hmm, what do you mean? Label as in:
>=20
> foo : node {
> };
>=20
> Isn't that 'foo' label only visible in DT itself, as a shortcut?

Some driver use a "label" property like this:

foo : node {
    label =3D "lcd";

    ...
};

See for example

Documentation/devicetree/bindings/leds/common.txt
Documentation/devicetree/bindings/mtd/partition.txt

-- Sebastian

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSqYpnAAoJENju1/PIO/qaqe8P/2OoKAQ6jjpZ2Nmj8vIEQzYI
Hxc+sKN05/IH/Qr8nkBIM9syFWZZEXPYrlRUh8VvlHeAVEYPSgL1J/7h12losPkj
6bO+StU7T46dpUUvE8XUjmVeYkbPmX/+XLydKXlsfB8umBOE7eQ2QLyMHmR0oLlw
sbwIvkMkOEZTNJNvnI3GOFc6i8L1dsKdhmzwnKPsDX4rUU/n0B276VZ6RzoPsFnP
mzwlouTMQTFHdutR5AfLpEDNIKNfZN7SxfsFepMKo5dzI5ED/6vBXkpJ7bRT5Lmw
Hx8crPFf93BtgKlAVEpL9pHcvOjtslduijg451ZsRTJrt+8ugPW1zTMzhj8+CErQ
sMYh5afSX57fY+2cGehpOHGSVYEt7Fm/5qJ0y21DZA7qimtWrV/WpLeEPZl52BTx
TZy5up/OZm5OaikKcTTOVUGz5slYtsS6OO4rJddTv1xAynnh/S5HO1PmhnfG+ngR
kn20slG0cIhvqAlGI4HbjeFEjRJWVaics58yr6QkfR4L/xDtXKNPQAXj5Ju6jhX9
47Pibgy900mn1X/jdOBledZy7d/VvhhrS/lzTGx8pJ4o6juJz0Udby79S32XGBaa
StFtKR8xibbauJi6y4E9QuRg9yxLFHmAOQCJiIYO/p/20x+oYrVsacc7kpHhAMRr
z9hYoP+J8enmRhDkSI8W
=kfza
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
