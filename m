From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 24 Nov 2014 10:18:31 +0200
Message-ID: <5472E9D7.7000908@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk> <546F317B.9030004@ti.com> <20141121161435.GS3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5d8k6rOX1jHBdt6q3X0WKsFp7cdqJbFRp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbaKXISq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 03:18:46 -0500
In-Reply-To: <20141121161435.GS3815@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--5d8k6rOX1jHBdt6q3X0WKsFp7cdqJbFRp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21/11/14 18:14, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 02:35:07PM +0200, Jyri Sarha wrote:
>> On 11/21/2014 01:23 PM, Mark Brown wrote:
>=20
>>> With this specific series I also need to figure out what all the vide=
o
>>> side is about (like I said earlier a lot of the patches look like
>>> they're supposed to be simple fixes for the video code not terribly
>>> closely tied to the rest of the series but none of them are getting
>>> applied) and what the end goal is beyond mechanically moving code.
>=20
>> The end goal of this series is to fix OMAP HDMI audio, that got broken=

>> couple of releases ago. At the same time I cleaned up the old complex =
scheme
>> to make the connection between the video and audio parts and allow mul=
tiple
>> HDMI devices (DSS side is not ready for this yet, but audio side is).
>=20
> But in what way is it broken and how did this happen?  Why are none of

I don't have a clear answer, but it probably involves lack of use, and
buggy and hard to use implementation. Things have changed around the
original HDMI audio implementation, and it stopped working at some point.=


As the original implementation was found rather lacking, and with some
fundamental issues, it was deemed better to have a fresh approach.

> the patches which look like they're supposed to be bug fixes early on i=
n
> the series getting applied?  I had thought this was just a lack of
> interest on the video side but it seems there's some other problems
> since the series has apparently been discussed off-list and still it's
> just as big as it was initially.

The whole series is about HDMI audio, not video.

The main HDMI driver resides in the fbdev directory, as the video side
is the "master" here, and it contains the code to access the registers
(including audio related registers). The sound/ part in this series acts
as a logic between the asoc and the low level HDMI driver.

This series only touch the parts about HDMI audio, so the fixes early on
don't really fix anything without the rest of the series (as the current
HDMI audio doesn't work).

And in any case, I don't like applying individual patches from a series.
Usually that just complicates things. If I would apply some of the early
patches to fbdev, then this series would no longer work on plain
mainline kernel, and would instead depend on fbdev tree. The situation
would be ever worse if you'd also pick some of the audio patches to
sound tree, creating a dependency to two subsystem trees.

So if there's no particular important reason to pick patches from a
series, I rather keep it as a whole to simplify merging and testing.

 Tomi



--5d8k6rOX1jHBdt6q3X0WKsFp7cdqJbFRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcunXAAoJEPo9qoy8lh71d8EP/0WHc8cwEHiD9BzPBd2WgijN
eQNmfNrMbGBp4xQokJZGaLFpr7TtMFwhBk/bl1DKRE509wZZ3E+scD9YqYa3p+iW
z0iPJdbUmGggkzkGYK3Vn67LzegOBdwRUR87w4R9RYv4sgrkOb7AFvz0Hg+QpHOq
qu+kPH6MCGis6OMjHQIntAc/FppbAYEr6rA0fBvw+j3xhGG1zdctvsTFk5BCxaIF
Dd9fZrzYgC3Lig7tQkT/uvbROmfcIi/sy5EvSBS+GrMPlkhtD0CHXWeSP9HSJ5Bt
CCKaROj2L3CtGEkGZsO4edtf5X8EMI+DPyHN3wbQEhhOo8rUVy74Y92dBx/U/h9k
lEkX1pgUmkMEYVQ89A14jmOAzWwmK2HRQvnLB6slCzq3tgzmA5NcvNTFbU2r1K1R
4+0WJ5fj+lPv6c62b5kGWBE9OOta+ZcIRNUHLFZO61SbytHUqVMP0PnuWgAM9SeM
285Tbwq5ccs1Vugjbczf4QNqBOIEMqyL3ped/P4xfHBtTA+Gxqs5BWlR2lzVWGPM
gR/OB7hs1p2U9EOzJtxwORS95vD403UvfsWjMoAHsIfQxDvGp66ka8cSeKkQaJf7
bl1Gju4DAo9lUdbm6o0gww1uRADBJeQwUeVdnDDHZ9amg1q5calpB7mtpIebldK6
CSXddzXlBTcaum64sBl+
=Vwhp
-----END PGP SIGNATURE-----

--5d8k6rOX1jHBdt6q3X0WKsFp7cdqJbFRp--
