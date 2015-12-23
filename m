From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
Date: Wed, 23 Dec 2015 12:50:20 +0100
Message-ID: <1450871420.2648.6.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-4-git-send-email-contact@paulk.fr>
	 <20151223114126.GR16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-oolTt1t7jRVfbHQ2ejdm"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151223114126.GR16023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-oolTt1t7jRVfbHQ2ejdm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 11:41 +0000, Mark Brown a =C3=A9cr=
it :
> On Wed, Dec 23, 2015 at 11:58:36AM +0100, Paul Kocialkowski wrote:
> > Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
> > In those cases, it is not a problem to have no DVS GPIO.
>=20
> I would expect the driver at least needs to know how the pins or
> strapped, or otherwise have configuration for ignoring the input on the
> pins.  This just deletes the warnings, it doesn't have any handling for
> this case that I can see.

When the DVS GPIO is invalid, lp872x_init_dvs jumps to the
set_default_dvs_mode label, which instructs the chip not to use the DVS
pin at all and do it all in software instead (by clearing the
LP8720_EXT_DVS_M bit in the LP872X_GENERAL_CFG register).

That is reflected later in the code, when setting the bucks (the DVS pin
only applies to the bucks) by checking for the LP8720_EXT_DVS_M bit on
the LP872X_GENERAL_CFG register (in lp872x_select_buck_vout_addr) to
decide whether to use software or hardware DVS selection.

As far as I understood, everything goes well when the GPIO is invalid.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-oolTt1t7jRVfbHQ2ejdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWeop8AAoJEIT9weqP7pUMFsIP/AvE8icTZDs8OExqYU5s8kUG
hgIbJyCGDnunYxzjoOcZTz77gBC0sCu9mg+LAdYIDhbdnWsrPToeqdES6ulC4gr3
mtY5Sf70EfJKuZE+LFaJRORrQQhtyVBq7uCanA4NdDB0wpUsAwE3gUiEnV2V5XEx
Gpy/Ba8BhOwvw3grPxogUKUhcCbl4nf7cvJfug6CMQcS0xnJp4LulFqbm0HC0zTU
5U7HITXA3HO68CvCN3jo8rD91KwiNDraxOtcN/3nJD+pwiU15iM4OTkUum+ArRaF
vzrYS15wbQSMdfzMJkIohn7PBucBGK3NoX3JKLDkBGjT57ET9UDYH/QbB+woFkx2
OigGju70buSZhReql9Q3dMr5PisztPTFDYa+iReGJ8ve1L/FRJPuAnDd58nrZrpj
BmX8MEQ5V66LZOTLOQtbPEyBlpVV6Y7xsjVIW1fGWhfGHaQXziouJb7beTPXvyqy
Rt0b6AELeVX9GZc2Vb/8/cUCZ+FKK321W2ErKPlsNXmV/2E+e6rrWDDJDhA87UVx
BraRgBxjVfac+19bVATI3YV7m4fAHLfFl2yB2TvAq0JV6j2UZkYciSKQS7U/apih
RzOoSk9RuEVYRu7btzOVufyMn5xaU5EyJ/5QIzPCX5z7ewkEWfha4Su0X5gIabrK
+BlyUrijrpbcZ0PgTJzP
=/rge
-----END PGP SIGNATURE-----

--=-oolTt1t7jRVfbHQ2ejdm--
