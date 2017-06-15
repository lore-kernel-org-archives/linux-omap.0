From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Thu, 15 Jun 2017 09:51:06 +0300
Message-ID: <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1972143450=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1972143450==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a4NbAVqqAHM6uHIL5sQP8I6GA6OMWqwUe"

--a4NbAVqqAHM6uHIL5sQP8I6GA6OMWqwUe
Content-Type: multipart/mixed; boundary="HFVJRO5FSJVqRlf8Lt5PhwpFhAcvMILks";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Message-ID: <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
In-Reply-To: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>

--HFVJRO5FSJVqRlf8Lt5PhwpFhAcvMILks
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/06/17 01:11, Aaro Koskinen wrote:
> Hi,
>=20
> When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
> is no display.

Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
check? If that's the case then this is easier to debug.

> Bisected to:
>=20
> a09d2bc1503508c17ef3a71c6b1905e3660f3029 is the first bad commit
> commit a09d2bc1503508c17ef3a71c6b1905e3660f3029
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Tue May 3 22:08:01 2016 +0300
>=20
>     drm/omap: Use omapdss_stack_is_ready() to check that the display st=
ack is up
>    =20
>     Instead of 'guessing' based on aliases of the status of the DSS dri=
vers,
>     use the new interface to check that all needed drivers are loaded.
>     In this way we can be sure that all needed drivers are loaded so it=
 is
>     safe to continue the probing of omapdrm.
>     This method will allow the omapdrm to be probed 'headless', without=

>     outputs.
>    =20
>     Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Reverting the commit seems to fix the issue.

This is probably "fixed" by adding the display aliases into the n900 dts
file. The aliases should not really be required, although they are
recommended. Without the aliases the order of the displays is random,
and n900 could end up using tv-out as the first display. But even then,
the displays should still work.

 Tomi


--HFVJRO5FSJVqRlf8Lt5PhwpFhAcvMILks--

--a4NbAVqqAHM6uHIL5sQP8I6GA6OMWqwUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQi5bAAoJEPo9qoy8lh71pq4QAJTreW/2CSpwAYBa6K7ESKG1
obPm7IQIhHOpy4PdnJSZ4wFKqNRFnMIZgIOfswTp1tJ1fJ7G53/otlJlRo/L10fC
iAfbot6omP375Jg2e52UJuFtUt+eJYldAnyVhNbtbDyyj/YEktUczni+y/PT7zLu
Puw3adriBZWmVkcERX8aNbia1CCgOy+h2nYpoVSBzSJWR9CT6Bjdg9knhF/8C285
Ce/kEsFu/aFbpcihjQGHN4wpvru+8k/CvY4k+hkQ2lTAE95jCSBPwBvewdGIbkbD
lp4Te2h1jzpj5Ui3oGVRB2svrpk0+NUOFbjOxnjGB9IItC+Lxzu55G+Arrt5ZCTj
QGjxKXScOb3om1/m/rJouHmEz8uf6L33+1UCRc2rHBIPlQtMkf2vy6kPYSS+6mnZ
WM+gOPkU+8jNBseVuVHLtp+y4N10uuIOopROmpxukq8T9tQgoovI1hGnrvltBeSH
DnFdqn3yUqnSPTLU0pWSJpkRqvgeGTy4dNOU4tZIC4rMdDEM8F+fy1ProiXlzlyR
+zlDStT4gAbaC4xARg/CmPMfQOnpi2OM4y08LT5bcxSCgJuZSNDBvLEV49tK/ECx
e1Sy3bVKhHB/kJO5sFYd00SivciXuns/gv61Nlo0T0N+8k7xvRHW0iyFgifSzYtT
UNTEHqK0rIQESlhGdNmU
=92pq
-----END PGP SIGNATURE-----

--a4NbAVqqAHM6uHIL5sQP8I6GA6OMWqwUe--

--===============1972143450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1972143450==--
