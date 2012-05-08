From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: HDMI: Fix register dump of CORE registers
Date: Tue, 08 May 2012 15:04:44 +0300
Message-ID: <1336478684.5761.30.camel@deskari>
References: <1336396828-29311-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-UZsfdHRUzLf4YIDKpogW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55927 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab2EHMEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 08:04:48 -0400
Received: by lags15 with SMTP id s15so2351623lag.34
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 05:04:46 -0700 (PDT)
In-Reply-To: <1336396828-29311-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-UZsfdHRUzLf4YIDKpogW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-07 at 18:50 +0530, Archit Taneja wrote:
> The HDMI CORE registers are dumped incorrectly due to incorrect register =
offset
> calculations. They are also dumped in a random order, with some of the re=
gisters
> repeated. This series fixes these issues.
>=20
> The patches apply over:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git dev
>=20
> Tested on OMAP4 SDP.
>=20
> Archit Taneja (2):
>   OMAPDSS: HDMI: Fix ti_hdmi_4xxx_core_dump
>   OMAPDSS: HDMI: define and dump CORE registers in correct order
>=20
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  163 +++++++++++++++--------=
------
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   57 +++++------
>  2 files changed, 109 insertions(+), 111 deletions(-)

Thanks, applying these.

 Tomi


--=-UZsfdHRUzLf4YIDKpogW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAABAgAGBQJPqQvcAAoJEPo9qoy8lh71YXwP91pvYWwXquqxnhHZlmFUfy2m
ij8n7H1vFWaa5gsWol/mhfP7ObK6I/p1gV9dVdqo2wZSRfPahn5fcbLVTJtjoz3n
zQjvzGxSSP9S0FhAyUCfIx3FAMglVZkUDvJrYsERDwMBH1IcnlwxLPmVoU+wfi7B
tVUhdgHO2Lh+zL+onEUV0Ghho8R3nJLxPTeX91SzGiX2xblz0L5NiM8f4PBXjcFl
VVjstTUwNfFHC/8M3/2+/t+MY/Z7Ax+O3PkUi5PVtWwg7ZmHUvoRYOLOAR8Nwu+r
0oRcc1acJHQmnnLJzC+WksLqHzBukw5BLUHjfw5CQn3U7On7t5t1zsKwchZTwrs5
E2XJwrDy+KdW0KDWCNuthsYfLbuogvYxEczMzunJcO43mpov55dioskOIRkdRHAK
GpLelGlaaDuULnuKpGuEWLMNr7CqrKLtUenM+m+UtQzkKDgNYTcJN7VRkP0nYcC/
9mozw5dEHxYtXcLvg8QVqPtxpxPa97D9dvbto8QF1NvmjwLYIJ0LADsmPLtFzfcM
oCDe0sbVWJ6Ze5FsSWS2xmTepTPVVq1K5cJUQed0oT6p1ou/oI/uwtDpACd8T33c
CqP62Q+9UA3R7j990l9be3Ycs68auWhr1O2AnMkZHSR5cdQ3+yfeVrMuOx4CB2xw
i4txbEtGZgfDxcfIBbU=
=9wiq
-----END PGP SIGNATURE-----

--=-UZsfdHRUzLf4YIDKpogW--

