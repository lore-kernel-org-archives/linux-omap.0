From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
Date: Thu, 2 Jun 2016 15:26:03 +0300
Message-ID: <575025DB.9020800@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1435483408=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, jsarha@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, plagnioj@jcrosoft.com
List-Id: linux-omap@vger.kernel.org

--===============1435483408==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HrVL7sObGAUl0w2B9PkUAaV7o01gaPWGc"

--HrVL7sObGAUl0w2B9PkUAaV7o01gaPWGc
Content-Type: multipart/mixed; boundary="d4hbppl4GQDFmfJTs1PjWVCv9DpKTl9Ui"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: tony@atomide.com
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com,
 robdclark@gmail.com, airlied@linux.ie, linux-fbdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jsarha@ti.com,
 dri-devel@lists.freedesktop.org
Message-ID: <575025DB.9020800@ti.com>
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and
 separate the two stack
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>

--d4hbppl4GQDFmfJTs1PjWVCv9DpKTl9Ui
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 01/06/16 11:35, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v1:
> - patches (2) added to remove the inclusion of video/omap-panel-data.h =
when it
>   is not needed
> - Transitional patch to create the video/omapfb_dss.h has been changed =
to copy
>   the content of the omapdss.h in one step.
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

Tony, can you have a look at the arch/arm parts here and give your ack
if they're fine? They should be quite small and display specific, so I
don't see much chance for conflict there.

 Tomi


--d4hbppl4GQDFmfJTs1PjWVCv9DpKTl9Ui--

--HrVL7sObGAUl0w2B9PkUAaV7o01gaPWGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXUCXcAAoJEPo9qoy8lh71N1oP/1Ng9eRePPz3yRiFn5iozYOi
omNN+HjzJA0zj5Kx59sfDlvYJVTQoZuYGzAcMjFICWvK6nFoog36Yvgz2fPz6tUl
xPFyRKn9QzrpTBmeDNa4LH88TtQBqVM8BacwcgbHyzuLP2nKfdi3kLr7Fhvjj8e0
LTlyJpdN3KCI90Da6wDi5dGkwLOx8Sn4i3TRAA4ZaGYeko3K/nSlQGmAxExNtDR4
3F5SCQaRyILpUxzi9IE8lNf/W846mIpBnWrRgTYf3/J2rwMOnl0Y+d7jggjOr2Gr
qeLsXP2nffcIrScDwE28xWUTI+N/QjUyCBhfMH7nBrAXWqQvozjfNp18xevUDT4o
J6kWErpzfWHo+uGQoq5nMDljbeFHzqDi8/yKCCGqnysBZbSUUJtgFKTTmu7uCGF1
Pm5/AjwHTNlhjjE3yURqu22tWexCbU7BPH4xDZ50aTDGHA6xr4f1d00XemGA9GVT
mCrMyB7oFlub3pf5YRN2MVeamkcK3Hd0oBNuvv5ksrKnIuqohhOnaFn9ZAOIemLR
2TNgBBqqXUAhiW9xcFgpVQcJHRueDMSKki4MYtnnyod9k7vChriq/GGoaKhkKfUq
QIouj7gSzVJ3kjwRu/0XBt+yZG9tf11IOaOQo28fcjjIiUfe3klH2qFL+hOp2SwR
YaKVhCE9wKCS/Ol8XYJo
=ShwU
-----END PGP SIGNATURE-----

--HrVL7sObGAUl0w2B9PkUAaV7o01gaPWGc--

--===============1435483408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1435483408==--
