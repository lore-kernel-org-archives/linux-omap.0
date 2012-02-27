From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP PM constraint to disable OPP50
Date: Mon, 27 Feb 2012 19:41:11 +0200
Message-ID: <1330364471.2205.261.camel@deskari>
References: <1329982132.1820.24.camel@deskari>
	 <CAHu_vbqvXja0tGYyj4OgwvQEhfpgLq7BiK+f3mAGEExzbATksQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UPpzuAhG9xfs04hoHi6U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55984 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753217Ab2B0RlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 12:41:24 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so2229787laa.10
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 09:41:22 -0800 (PST)
In-Reply-To: <CAHu_vbqvXja0tGYyj4OgwvQEhfpgLq7BiK+f3mAGEExzbATksQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghu <raghavendra.kh@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-UPpzuAhG9xfs04hoHi6U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-27 at 11:32 -0600, Raghu wrote:
> On Thu, Feb 23, 2012 at 1:28 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> >
> > Hi,
> >
> > This is an old issue, and I've mentioned earlier, but I think we should
> > finally do something about this. Or perhaps this can already be done,
> > but I don't know the solution.
>=20
> I agree with you.
> We need to address the L3 bandwidth requirement for DSS as needed by
> high resolution panels.

That is a different problem. There are to PM constraints from DSS:

- L3 bandwidth, depending on the pixel clock, resolution, color format,
etc.
- Maximum DSS clock frequencies

The first one is not trivial, but it should be possible to implement it
inside omapdss driver. The second one is the problem case my email was
about.

 Tomi


--=-UPpzuAhG9xfs04hoHi6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPS8A3AAoJEPo9qoy8lh71i+IP/1MNyzLl1wnmGWDyZBjwXw8G
4IILr+JfvfkLJNHbsip8G+Xox+V+lZeLngeqguJ52HfB5S19dX9WPKosld7whPeh
Q+yl8SoE3exM5irj3fT7ldpmcOW+3zmHWYjobqgBrUoEXOsksaau4Du0S9PL4DOI
NXBBIj3u84V5VoQkkReaWh1b7XN+QbwDlLIvvFAVDZnV1oFJhvIg2DR0ISlqNbfl
xMPJyeKy7PNssYrwXDskiQgeXClHdEyezlOYkd2ZAeHtnPLscxxrf7tQ6hLUZUAO
Rj0lcbFiqict+r0UnBoa2IRp+mMg7mN5ac5FNUDsyVpZxcy4BIBgtunslrYibbB7
9RXu9PG18MzNdtaTqm64NiJCI8COCqGuV+RmiCBBzU+9s7IS9gfwZuYrvJJ/qFyO
fC8P0jodR7weh20k/Rn2NKOnLWsMQoYAZH+AGzYCbfQgg4Ha/Q2OdYYDR5eGf6iS
2s20L0B5+DgzR4yoycgnYfGdy3wwlMGG1a9CHr1slP2xT5evMnvC3xLwsPoM5F/l
5bt9lPn9/z+A6fHr7piI6GWTjWSPI/CVOARLND2gHZplUyhYxaMZcKCzaCI0B5GD
tXi5PHMP5AQjgdPc17krh0E6JLrL2bfMxs73zJcG07QcBJH4DZ9QOWOytRRjSoNa
ui1o0fWEoCPLZP9+cESE
=11hw
-----END PGP SIGNATURE-----

--=-UPpzuAhG9xfs04hoHi6U--

