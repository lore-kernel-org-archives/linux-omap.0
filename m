From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/3] TI-SoC-thermal: Fine-tuning for two functions
Date: Thu, 27 Apr 2017 09:20:49 -0700
Message-ID: <20170427162047.GA18276@localhost.localdomain>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Keerthy <j-keerthy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 05:33:10PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 17:24:56 +0200
>=20
> Three update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (3):
>   Use devm_kcalloc() in ti_bandgap_build()
>   Delete error messages for failed memory allocations in ti_bandgap_build=
()
>   Fix a typo in a comment line
>=20

Keerthy,

Can you please give it a shot of this series on all supported OMAP chip
boards? I do not see any major issue with the series at all, but would
like to get it tested by you.

BR,

>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.12.2
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAhpYAAoJEA6VkvSQfF5TJqEP/RX/B4hM6Xuh9eEmF/6MFVPK
UGYLpYUxQ8ZklU5eUzeeGcwOXNvxqUdlyFMRUrK18QQYU9gPRdgmDjarl2npY3pD
a7n7Zx87rNB7o7gbfeBkU2Dh+EnFuLBMJW4KHmsSt0ff/KRibdPfUoUT2r6f7WIf
OclSp8oFMei5n5WBHrPzPOyG/SHiEcmiTsdNrghxcjhRUvPKkNJZ4fhChxJXh/xg
42J6xWOrkpKkC1T+jl+16AeVUyrMyhGuMiwvwS4qImp/CB2AgSdvcN8aRGkr627F
z5H0L/8cbYpNxFYqqtN2IIwyHCmaAv6kBhsuDMGLSc09fZ8CStSu0vZIhi/hv6ke
Qw6n7QVbNO80dLOkdEHIyMul1vTVztTV51bOnNZ0rd7z5jpOAl/bv64Ev3nn2ttZ
kUrGgL+JmO2n7ZSYQFXlgWgC3uLghl22JgH7FanLcIlwCeofkJ6slh97RnZxbynU
/dr1iA+/WOUkm7hBKkfuBXZqet6DhKZanWgaQgsMfU8Wc1LK6qEtZuUq1nr+BnQD
C3iEEt8tTpdL9igDyJeJHeQkQl2kdflDEFaWKPh8XQ+w5T+ah0dnFezmvR4F3dtk
yqYk6nXgj1FBZpo5huYvHfuOhfCZOI9ZkrTvnaCAfpSFd4DWp1PVbmgkWiwQXUF8
yDT5Mo8u4kaWQWzGHy/A
=3Luv
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
