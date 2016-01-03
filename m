From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Sun, 03 Jan 2016 11:19:26 +0100
Message-ID: <1451816366.3428.4.camel@collins>
References: <568088B4.6090207@ti.com> <1451342963.14631.13.camel@collins>
	 <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
	 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
	 <20151230163307.GW16023@sirena.org.uk> <1451500639.14341.6.camel@collins>
	 <20151231214007.GC16023@sirena.org.uk> <1451599146.9673.2.camel@collins>
	 <20151231221407.GF16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Ebdf2CMHbKlKpNAmectL"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151231221407.GF16023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-Ebdf2CMHbKlKpNAmectL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 31 d=C3=A9cembre 2015 =C3=A0 22:14 +0000, Mark Brown a =C3=A9crit =
:
> On Thu, Dec 31, 2015 at 10:59:06PM +0100, Paul Kocialkowski wrote:
>=20
> > I understand, thanks for pointing this out. Well, for my use case, ther=
e
> > is no use in disabling the chip at any point as it powers the external
> > mmc.
>=20
> Presumably someone might decide not to use the MMC in some case (perhaps
> only mounting it when explicitly needed in order to save power for
> example, or the MMC subsystem might figure out a way to power down an
> idle MMC block device).

Makes sense, I'll keep that in mind.

> > Would you agree to have the enable pin handled directly (and by that, I
> > mean enabled once, when requested, as I first suggested in the patchset=
)
> > in the driver then?
>=20
> That's probably fine, or do it via runtime PM (the framework is fairly
> simple to use, I'll probably go add support in the core for it in the
> next day or two as this seems like a sensible use case).  I can't
> remember if this device is a MFD or not and I'm just on my way out the
> door.

Runtime PM seems like a good fit (though I hadn't heard about it before:
you can guess I'm fairly new to kernel development), please let me know
whether you end up implementing it so I can try to handle the GPIO this
way.

Thanks!

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-Ebdf2CMHbKlKpNAmectL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWiPWuAAoJEIT9weqP7pUMRN8P/2d9llXdsSJWu5YyqNxMZj/k
IPbrOWs34ZdMMAdmeRnqIDjuZxGL5j6KjpnjPnjAPLJjLxiBYEQgBbIOYp+rBERX
mNDUED/nKafPL70X87nDFPBztImimC/QVHSoxc9uua5Ojl/RdcJd1vs/7/ofTA7m
xxqNqTdXn38yKkJF0LBJIUesKikXf3d+fsHKHVAlxY/gAxsmoAcwEdXMGq2LB/Kz
cWptA1lhGLe3I0uuPqC04DjVhu77lGMrkfNP0xHzf8cgbeWMDeBuZfxid2r260Y+
gb5TlfsRodCDR9o9oD6ZokYC3B+j0ijBRVbD7x9Ck4L0xwkv7AanbMBm0G6+24iq
cBHMDHfTy39TNiLt4JvaWgR251MBeNyMSwjk7pMdru/95KnnLMHS/bfTT4PWj3vQ
XMAUoWX+6wbilQLsL76LqdEcsfL4hrCpJ7Ilar58JCU0nWgvKaaIjEo8WJOzw0XA
0F6ffgBbJV7zob7wVB6FwfXGLq2VXSf9Xrzq5FZWhPzOYDRwN/BoUPAmdRjCJR20
kLcTAtwrwoozm4iJ0B3BNbfzsgWJPtyyKTc/1NblJBuh+ffKT4GE9C7yMJ4fMh3c
Vvb0ufij8o6m+350460fG54PAYvY8jdHrWKM3TSFd2BdkCotEWwhZmzKRoh2taAb
b4XW9nHqogSNq8MnvvVf
=jY/K
-----END PGP SIGNATURE-----

--=-Ebdf2CMHbKlKpNAmectL--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
