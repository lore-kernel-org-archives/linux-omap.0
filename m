From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update
 display support"
Date: Mon, 20 Mar 2017 13:07:45 +0200
Message-ID: <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-3-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1113128890=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170305004309.28259-3-sre@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1113128890==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9BNAm7wM6cNQixbQXt6WtSnrLCAQjO0f3"

--9BNAm7wM6cNQixbQXt6WtSnrLCAQjO0f3
Content-Type: multipart/mixed; boundary="okpEKepeJceuuox56sIFdnKJbaDVFTqOe";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
Subject: Re: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update
 display support"
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-3-sre@kernel.org>
In-Reply-To: <20170305004309.28259-3-sre@kernel.org>

--okpEKepeJceuuox56sIFdnKJbaDVFTqOe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/17 02:43, Sebastian Reichel wrote:
> This reverts commit 5a35876e2830511cb8110667fc426c6a6165a593.
>=20
> Revert the removal of manual update display support in
> preparation for DSI command mode panels.

I think it's much better to just add the manual update support from
scratch rather than first reverting this old cleanup commit and then
adding more bits and pieces.

 Tomi


--okpEKepeJceuuox56sIFdnKJbaDVFTqOe--

--9BNAm7wM6cNQixbQXt6WtSnrLCAQjO0f3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz7gBAAoJEPo9qoy8lh71TtYP/iHO7nYlYYoKpIaJ1E1Tey99
/fEihnGiGMnOvBjTHo46Yj5nisQBV7T+28G+zyvMJ6RfRL7dNELOyNSErQGWv0VI
cXpDD7dsV3UJv4KHT64VCYA7dPfdQ+IjQwS7ST9tlLgKlrcko44Rn5TG5QixNk2H
b/xUjkOLcmBjfzBiWz0BYiMVshSVqIeRwbCG5WkSMVqgGJH7AARnLdbBrnbvxT+A
AmDDn14dx2MqY/ARnvwoGwdpINAwrJqNt3Jcb5lTxzOrBnVWJcVSV+xYpW9/26Ww
TNq8QnfcqaXcbqLPE9oawowYQN/hXsI5Yjs4T1UGNi6NyM5LCS7XQTXmHmP2d/x+
u9Fh+NNTtqAno69yXVgK4sWMUk7GU99XiLLbJVFSrpmu9T7bKy8juG9xBPmXS5j8
URnv0tUkt6+1CxyxTij/9sVIMQtzwsK8S0KVN9pxomCxeqCb0/bD+7Bp4aYqzpBi
LxNwZQ4MJ1bVvH4DInYLqif3GGEBPZbeJgzIbv5+PAM+cKOubMWjHJjORTKPp0b0
bd4pnis696FHEXymZAZD+AwJ9TYJuzgpGplmpm3VYFuNy9cHwShegdMkKw2XaCTA
9g3FGVsJb2xxFNzRU5MV01AGtBtYixd8+WKp34thJQ3tRLzuBbTXjLEXcd2IMy56
bwJtXpKOOtzvzPq16rmb
=eSKz
-----END PGP SIGNATURE-----

--9BNAm7wM6cNQixbQXt6WtSnrLCAQjO0f3--

--===============1113128890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1113128890==--
