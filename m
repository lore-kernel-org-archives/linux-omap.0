From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP build now completely broken in latest arm-soc
Date: Mon, 26 Nov 2012 10:30:03 +0200
Message-ID: <50B3288B.2080609@ti.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk> <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com> <20121125140701.GW3332@n2100.arm.linux.org.uk> <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD53D076C3645E79FEDF29125"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab2KZIaX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 03:30:23 -0500
In-Reply-To: <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

--------------enigD53D076C3645E79FEDF29125
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-26 08:00, Olof Johansson wrote:

> Tony, Tomi,
>=20
> I've taken a stab at resolving these conflicts. They seem to come from
> the cleanups combined with fixes that went upstream, and it seems like
> we want to stick to the arm-soc versions for most of the conflicts.
>=20
> I've pushed a merge of 3.7-rc7 into next/cleanup (and for-next) of
> arm-soc, can you please check and see if this is the correct
> resolution? As far as I can tell it is, but a double-check would be
> appreciated.
>=20
> Conflicts were in:
>=20
>         arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>         arch/arm/plat-omap/i2c.c
>         drivers/video/omap2/dss/dss.c
>=20
> The hwmod data was trivial (include files). i2c was a little hairier,
> a revert in mainline -- I presumed we're still good with our arm-soc
> contents so I stuck close to what we had there. The DSS change seems
> to be done completely differently in mainline, i.e. the surrounding
> code is different to what we have in arm-soc today, and it looks like
> the bugfix (3630-specific stuff) is taken care of in the version we
> had. So I stuck to that.
>=20
> But, please speak up ASAP if the above doesn't look correct, since we
> want to fix it up before we merge much on top.

The dss.c is resolved correctly.

 Tomi



--------------enigD53D076C3645E79FEDF29125
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQsyiPAAoJEPo9qoy8lh71NN8QAKtuy38m35y3kLw3T8kQEVnM
IrSfVhO/p/NcSwFxKX+6BNSaqinXXooacUGieVo346y+yR97gFXOERT84HVuL1rA
rmsdABTtEm7UJvKtA9/zzhjGk5pV294qxaiOjGgz1qpk89NL3web2Jp1hsFPKKdL
fQkUTXKExl+IvdmgRtoiD5FqvcbejfL/zyqwdPFQmgtB6CNNJfCxDXXoX7XbBQFD
no3EY6L/Ifp3OoY+I3isuz6T8YudmChwJHACbtGjjAh95e0G9VUIGTlsAHpOx8HG
7UhLMSbMjWGiGBdkbyQgHbX+wm1t91y/ThmlJiK22dgi+gPNM4+vQLm5pr7/+n0t
/krPYDTxAfqEfPkwSsj1Q0pQ1XFiRzgvvmuAdA1PbmvzoVQV6MHl/u+RP/tmBLN8
+SlklYF4W7ySvjmFbcBBPi4zF2kXI9zIEQqiPyPQMLwWbMkwWUU/i1Oc3jSAFE41
AmUuUgf4hkpO98/WqNA/f6wONaS5t2sRvyWVhevuxBoqAFN9jaxPJDbKwDu+d2XC
14LU7CL8OPmAwvNfHg+6eh7fOISXc66OTuxDtNIzAucW/zcD4PR5FfupKtc8kLcX
S+TxYxB8c5M0tdkMvwDmimk6B/H904Q+Tk7oC6efdY3IzJUg4IlL5IvFois1A5s3
exBFV0Aan1WEP7U8FfBO
=O1ID
-----END PGP SIGNATURE-----

--------------enigD53D076C3645E79FEDF29125--
