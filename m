From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DISPC: Remove boolean comparisons
Date: Tue, 24 Nov 2015 13:35:41 +0200
Message-ID: <56544B8D.3050700@ti.com>
References: <1444912178-15989-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MiktKm7JvouoUIqnsPTKfD4PL1pKElAjB"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444912178-15989-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: plagnioj@jcrosoft.com, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--MiktKm7JvouoUIqnsPTKfD4PL1pKElAjB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/10/15 15:29, Luis de Bethencourt wrote:
> Boolean tests do not need explicit comparison to true or false.
>=20
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>  drivers/video/fbdev/omap2/dss/dispc-compat.c | 6 +++---
>  drivers/video/fbdev/omap2/dss/dispc.c        | 6 +++---
>  drivers/video/fbdev/omap2/dss/manager.c      | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20

Thanks, queued for 4.5.

 Tomi


--MiktKm7JvouoUIqnsPTKfD4PL1pKElAjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVEuNAAoJEPo9qoy8lh71l94P/1UwJOyozQgLPBK0585V34+d
W5nJ9efwjEANvRZmDOexmbz+66QZj/20x7opHa7dv5Se1+xGdPTzWxiAol7Xo7f/
+CFWrJz1d4KF9rzlK0njgV+S2fVFCDnEolWcq8Zki8tNiUP+A9KNpxi/uaolGg0Q
aua8Ny/Fea3U/jwAHQqJTkFTJoKwYdxpQ416AtlAdj+qQJSbQ15LDAyPXYBx/IBa
9342CVY8F0Bh1ajXWRuDVp5AOy9NutbrZAMf+OR4u6tEgwqsqGl0o1oLG1h1tyGa
BI848UTfbsh/EYq9hQGUwrlGqowFUBUIN+wl/+GwRrBQzR/d6EFfl+CNzINQpCd/
ArIpSBuCuYvJCCQYGvqdGL7peYPZvnxzld7iTMwAut7TIEntQjgncXyPDMM8P4r2
rAc1R3jDdBRv0TINVUlT5fIWFgSLcCDwfoaxfNQ4ptt3coNAa7pg9NZjPHxwz5HS
U8Df6OmK5BoAt5u73Ti2LinQL5cNq1ckDxhl1T86k11kASkKf0uB3ua8+0MmKr4j
qxVO1mG40vD6jn9J/VMnop/y+cD+MFIIaswYcctTrJk/CItjilSaFHVZhOdRVgbn
ve30d7bqX27/I5ZrPcVuiHD+8Mi1gwPiJmusVv58TanujB2eCUiAHsWusyaPXs5y
1MqkK17tHtmbCq2QAthp
=KYjM
-----END PGP SIGNATURE-----

--MiktKm7JvouoUIqnsPTKfD4PL1pKElAjB--
