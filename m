From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for
 omap54xx
Date: Thu, 27 Jun 2013 13:06:21 +0300
Message-ID: <20130627100621.GA510@arwen.pp.htv.fi>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
 <1372322299-25046-3-git-send-email-t-kristo@ti.com>
 <20130627084434.GT15455@arwen.pp.htv.fi>
 <51CC04C9.3050801@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52301 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab3F0KG6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 06:06:58 -0400
Content-Disposition: inline
In-Reply-To: <51CC04C9.3050801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Thu, Jun 27, 2013 at 12:24:25PM +0300, Tero Kristo wrote:
> On 06/27/2013 11:44 AM, Felipe Balbi wrote:
> >Hi,
> >
> >On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
> >>+	rc =3D clk_set_parent(abe_dpll_ref, sys_32k_ck);
> >>+	abe_dpll =3D clk_get_sys(NULL, "dpll_abe_ck");
> >
> >should these two lines be swaped ?
>=20
> No, its a different clock. clk_set_parent is done for a clock that is
> a parent of dpll_abe_ck.

hah, just now I noticed clk_set_parent() has abe_dpll_ref, not abe_dpll
as argument :-p

> >>+	if (!rc)
> >>+		rc =3D clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
> >>+	if (rc)
> >>+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> >>+
> >>+	return 0;
> >
> >so even if (rc) you still return 0 ? Shouldn't you return rc instead ?
>=20
> Hmm yea, this could be improved. :) Same should be done for O4 / DRA7
> also. Seems like a long lasting feature actually.

I see... ;-)

--=20
balbi

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRzA6cAAoJEIaOsuA1yqREYykP/35KAYb+Umn/OA4dD9XAmHbI
DTnmFmHSS1C+kFqgNTFumyeYJY4Q7i3BWwxbQK/+zIul3hZ0QiCWSbf0DZ0zs7h2
yGdtP8S4B/hQnE7j5AtfW7ypHR+zJ/1mppI2fR1rla1Dk4wsEoGoO3fxKaAeub0Y
MVfg9Du/q0AEA0De8Fu0nMrPSnbtE8k1U9m48Mu65DLEpz8kzM2Bnjg0PQO5MVF9
KLaKP9cIdewtEb8T7ef498KGXFkr3uURm6Nj58wNpFvTLtTMahK4X+3H5ucu9kVV
DRYPYCpF6/u2iMhqYMWoq+Kz/rZ+2fdf9wUL25BSi2VrtwTmx8LuMI/KrN9Y2Eje
TBKLnPRwV8w/0NuZN2uBNQFtXU1TXTmFGB51wkbINSTbESz7vlksmS5ZxNIfrJB3
6QsGENEvGnAE1zZ9M5khdUz+kyRs+BKgGQemH6LyWzOciuFrDeUiNj5KpDinyEZx
RL2CILnDlDPbwBa8smPwnyxjK+qTkcE52aNA3OJ+c5PZMlkXqw+903wBIYVNJpoT
j8ZE0eS5qdT1+M6wJtgDKCt6EDcxERwEdNcYaRxzOm4PG7keU3ndtytKO/azRoaZ
jih7YbNtTBQhOxYardysUk6RAUr1bns8xdMEiL9YYVHo40zX8vmALi0PTrBxfwb8
AyT9RGUR+Z3uxPlSQdgY
=iUs5
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
