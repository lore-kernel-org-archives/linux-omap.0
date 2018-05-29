From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Tue, 29 May 2018 23:09:09 +0200
Message-ID: <20180529210909.7m4cyhh524xqipju@earth.universe>
References: <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
 <20180524094705.GA16705@amd>
 <20180529204517.GA6765@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qv3qza25bndfqsea"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529204517.GA6765@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qv3qza25bndfqsea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Tue, May 29, 2018 at 10:45:17PM +0200, Pavel Machek wrote:
> > > > still results in working touchscreen, removing any of the three fie=
lds
> > > > breaks it again.
> > >=20
> > > I bisected one regression down, see "omapdrm regression in v4.17-rc s=
eries"
> > > not sure if it covers all the issues being discussed here though.
> >=20
> > Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
> > strange dependency on tsc2005@0 is still there).
>=20
> Laurent, your patch looks pretty obvious, but unfortunately breaks
> display on Nokia N900.
>=20
> The patch is pretty big as is, perhaps you have version split to sdi
> =3D> *sdi and then static =3D> dynamic allocation?

There is a queued fix:

https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad745893=
17a260d583ed

-- Sebastian

--qv3qza25bndfqsea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsNwXIACgkQ2O7X88g7
+popWA//Yln4DdNWOjVanlPWqzzi6QOdAOi195LsPSJmXDssSaJjce6Sp56jH28n
KgQs+1wAXYG6AaqSqNkBeFut8VBCLOpXnQx4P6KlxtY1xIO3zvSqyQmTaE4/lTEN
W9PbQOQN272woEYwhz4MyucfpzqsXFlLO0nh3qK/mRJGqOge7aSFXSIcOdxX/fyR
dxTgLjhDZd7ApQefGKJinXRtD0qVc4S/Sw/HaZiVo3sU8HhxUKHWgh7//d87O6Ei
hUP0xslCkBenOnqf2/yg6r+KCcv54KeMCT7MoIQ+OlEUx6U1VCb/TdN7Y9yz1/A+
6yVYNhRFu6vdPDjWtU/dF+LSifRYfgJoV1Nf3RoqY0tL2pp02y+B5DrYj4wmfYoE
8Kn7D94EsAqPMREICZwtzHGlxcBgNpXxZHLJVxHI1O8KA9YWtphWyelyeHOX7b/L
oKBbG8Ixe+6qkgHn+/N4UDcQauvKdQgti/ispMSRlAKCL/Holnq+qGkyeD6HKFUD
jAyqB4a4uUf54G6alH54j0bCmUNxtCqs0oQLq2rJBifIQKVvxdRvD37OucTxdrF0
BmrjwXRSQtMT/qa+WVVEER7O6OlfsBlEEOhK0xUVwt3w7VzVT8J2skL4X8EAbbjM
3GSTF9VB4lNCz8djqfLt1TYy/1HnERImnRBKQahaCWBuoVgFmlA=
=5llM
-----END PGP SIGNATURE-----

--qv3qza25bndfqsea--
