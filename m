From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] fb/drm: omapdss: Clean up the headers and separate
 the two stack
Date: Mon, 30 May 2016 17:26:38 +0300
Message-ID: <574C4D9E.6030307@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0175713008=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jsarha@ti.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

--===============0175713008==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="viUgpHTEQX7FEJ4BMikMmvSeD3u3tidkk"

--viUgpHTEQX7FEJ4BMikMmvSeD3u3tidkk
Content-Type: multipart/mixed; boundary="QVhhHDTb5eShAhXmW3lNkjxldWiBK4DRV"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com,
 robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 jsarha@ti.com, dri-devel@lists.freedesktop.org
Message-ID: <574C4D9E.6030307@ti.com>
Subject: Re: [PATCH 00/26] fb/drm: omapdss: Clean up the headers and separate
 the two stack
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>

--QVhhHDTb5eShAhXmW3lNkjxldWiBK4DRV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter, Tony,

On 30/05/16 14:42, Peter Ujfalusi wrote:
> Hi,
>=20
> omapfb is deprecated. It will not receive new features, only bug fixes.=
 On the.
> other hand omapdrm is in active development and the fact that both
> implementation (omapfb and omapdrm) is using the same header file
> (video/omapdss.h) makes implementing new features or doing bigger clean=
 ups in
> omapdrm harder and hared as the change should not break omapfb.
>=20
> To overcome this issue we need to separate the two implementation. This=
 is the
> aim of this series:
> Create platform_data header for omapdss,
> clean up the header usage and dependencies,
> new header file for omapfb stack (video/omapfb_dss.h)
> local omapdss.h header file for omapdrm.
>=20
> To generate the set I have used:
> git format-patch -C20 --find-copies-harder

Yeah, you need to drop -C20 to get a bit saner "renames" in the patches =3D=
).

But otherwise, looks good.

One thing which is not strictly required, but I think should be added,
is cleaning up the omap-panel-data.h from the drm side. There are many
panels including the file, but not using it.

I don't think there's any sane way to split this series into different
subsystems. So I think we should merge this via drm tree.

Tony, can we get acks from you for the mach-omap2 patches? Do you think
there's anything there that could cause bigger conflicts?

 Tomi


--QVhhHDTb5eShAhXmW3lNkjxldWiBK4DRV--

--viUgpHTEQX7FEJ4BMikMmvSeD3u3tidkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXTE2eAAoJEPo9qoy8lh71OhQP/is9y4WQ6gkhxQH3nf4uztM5
S4wg4A/4lFALmeq7l3nICtP/O/2LYlrt4cFYGC3m3O78fnysuioIqfFRIOAJKx3L
vH+ofjXl8Q0F6KFXfw5Oei3zyWEWehOX2zy82fzcI4DMMXXQQBD94D0JldkKr68z
N4zPwu6/aH72+zdSIe/VgbiWLFA9EHveOpYrx2ehDwvafYJdo+4vONq+eLndwFRJ
Dzpbv7Ev/nfwNeqYoZp2uPiTItB9zbmll/uCkicOwUJO+LDd+nE9Akcvqh7QDOKt
SUJbekGtTyfBRGKEHW77Vazj+IQEaCY+a9rMmrXOODFZKTTjDkN5Y9G/A+I5RMxa
Oi9TQAJGOmRuBviChogCJowIS6mjG9IMuXr+jctUxLEgZy9A0gqM2u8T5NKTgq+j
ZNH258eJveXbHPzuWBjC8PWZawDtYzNqHaVIFEV83bge2mZuwOLI+0PO3Bs7A9Xw
tDNWeIZviGAEcJmo2jNehMtgScS7iFpSJFteVxaT5hWhBmvcXYgmrhZkIFhKy6ad
E9WDXnxsjEsumGeEveqRl+1cdQZOzMe5jeMgNtryFRgCI3zhyMR2wenGAAtnvbTP
TAxAwtJx8jZjVcCWGpIiiC6tYms5uueRU/oR6w/UWXBXvq/QNg+WUjAqUFgoZYpl
ydBopm4q3h2ruqFQnQ7I
=mv8g
-----END PGP SIGNATURE-----

--viUgpHTEQX7FEJ4BMikMmvSeD3u3tidkk--

--===============0175713008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0175713008==--
