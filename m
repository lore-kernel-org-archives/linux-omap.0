From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Wed, 10 May 2017 10:23:37 +0300
Message-ID: <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0334437943=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170509150550.bi4bzadesmma6ntp@earth>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0334437943==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uS4b9ip4BsQo8tQqA8pS5REKouhm9FWDS"

--uS4b9ip4BsQo8tQqA8pS5REKouhm9FWDS
Content-Type: multipart/mixed; boundary="IHN1W6RHQpc6V3CH0peJa1uWWXdcwWsxJ";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>,
 linux-omap@vger.kernel.org
Message-ID: <989d9224-7f13-c091-7030-3ceb68a6c600@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
 <20170509150550.bi4bzadesmma6ntp@earth>
In-Reply-To: <20170509150550.bi4bzadesmma6ntp@earth>

--IHN1W6RHQpc6V3CH0peJa1uWWXdcwWsxJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/17 18:05, Sebastian Reichel wrote:

> patch 10:
> I think dsi pin muxing should be done by providing pinmux
> info via DT.

Unfortunately there's no pinmux driver for the kind of register we have
for DSI. At least this was the case not that long ago.

 Tomi


--IHN1W6RHQpc6V3CH0peJa1uWWXdcwWsxJ--

--uS4b9ip4BsQo8tQqA8pS5REKouhm9FWDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEr/5AAoJEPo9qoy8lh717LsQAJ86j7S+1IVJc/mULViVQg1E
jR1TAp37nB7m6KG7sYyxTEc7KuFsfFR/MmoquHDzaaO/tY2b4YUNatktFglLAGDj
3Z3W6LpwmwPxCtc1V1sJnjmN3LttZ4wZxK2qqVis6/VI3yv0vYCOS7kA1mRpDeXw
msbtM5/WIgK5m/NgfhFIre8MYC7PEoB5QNSSVbt9qjdTJ2CJcg0dov3sPsUR6LVq
olyBnPx6HVWPeUe2RWPcxWIl16yoqclN14Dy+pUV/uCVQ1q5TWLwAgAkVTOR6Zmb
lU8PZ1XOc2UtTE4+RGu9wO7GNBcZM7/8cROIfawD59CSYXq2Lvf5I4mEENn9GKDd
kgmrCW6vAd+M6sNIskockKud9HDcWx2hOEPAhh4a5CPpB1fr+FyS8NT6kDBQzDqA
As0f9IrAt6si2UtHwdpEmGlW5xeFStSztWQJqspW+fE1qAc2tcz0Pu3kGOAItaXS
QNyFIa0Vrh2GpJ85IG4Hcqnh1diayEBGedFMKSl42QKXZWnnMVRG7dcptbEYd4lW
u8XN2js8k0pRoR9DJxO3e0KlYMBPsPjef88tB9EOQV0/Xh+uq9fdXDiLAMw5uWvH
vTGesXitUTyYswnkR2ga2aza7/SHmiFmEfbpjebdPYjz9bmnXK8gp2fv8LG7W9pk
Zfm36omiYWfS4+EUE/4j
=ifs2
-----END PGP SIGNATURE-----

--uS4b9ip4BsQo8tQqA8pS5REKouhm9FWDS--

--===============0334437943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0334437943==--
