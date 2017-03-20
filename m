From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
Date: Mon, 20 Mar 2017 13:29:35 +0200
Message-ID: <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324245522=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170304235021.27055-1-sre@kernel.org>
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

--===============1324245522==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Kg7LOib4e4U9mpItmG5GWOripGj7gBAR"

--2Kg7LOib4e4U9mpItmG5GWOripGj7gBAR
Content-Type: multipart/mixed; boundary="IGaF6ArE7kxPGPDIxl3R9IRm8HP48ID2F";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
References: <20170304235021.27055-1-sre@kernel.org>
In-Reply-To: <20170304235021.27055-1-sre@kernel.org>

--IGaF6ArE7kxPGPDIxl3R9IRm8HP48ID2F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/03/17 01:50, Sebastian Reichel wrote:
> Hi,
>=20
> Some of you may remember, that I sent a series for the N950 display
> some time ago. N950 has command mode DSI panel, so the main part of
> the patchset takes care of adding manual display update support in
> omapdrm.
>=20
> The N950 also requires display rotation (the panel is mounted verticall=
y
> and bottom-up) and offset. The required bits will be sent separately.
>=20
> The patchset is based on 2d62e0768d3c, which is the current commit
> torvald's master branch points to. I tested the patches on N950
> with kernel console (fbcon), Tomi's kmstest and Xorg from Debian sid.
>=20
> Rough changelog, most of that work was done by Tony (thanks!)
>=20
>  * lots of patches dropped for now
>  * rebased to current omapdrm interface
>  * added OMAP4 support
>  * misc. cleanup

I haven't been able to go through this series with time, but looking at
the patches, there were multiple places where I felt quite uneasy with
the changes. It didn't help that many of the patches did not have
descriptions.

So as an RFC series, it's quite nice and shows that the manual update
can be gotten to work. But I'm not ready to apply this until the patches
touching the omapdrm enable, disable and commit sequences are split up
into smaller patches with proper descriptions.

Also, a minor note that rotating the display on N950 will cause tearing.
Probably not a huge issue, though.

 Tomi


--IGaF6ArE7kxPGPDIxl3R9IRm8HP48ID2F--

--2Kg7LOib4e4U9mpItmG5GWOripGj7gBAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz70fAAoJEPo9qoy8lh719osP/jNAkbHVqvp0k+WpvYpai20R
2z6o8Oq+zWS2S5IrlDLLE6YyNxFgC8Ka9pydDjE4Z8Knr+Xld2TJCJwJQnGEsOu7
lHaL/4l7TyZrPMInoMLJvg8SmbLpbsIDZ5kFlv2OJwXTKLFVEAVr3J1WAb6PYPPq
Vkdsuxz1GtHFSp+bJm0yKrocchhZfLvnVjk1VcyJBkdq6JXbxEMXBV/uVPQmQMB7
dVAY07xz1fJNTEdlLL5UoywuqkZ5zTq3Xo6bmoTQtg8mnlGZUJCLYZIM444pKXDl
h5XXsZDI0GPXkZtfad+FQCOiiu2CrzlAPJZ/24fYldjBrScpFoeEEGmAkdwTKeKK
uVOS1+Ea23cX64e0Dy+dyalOPhzzzo9eLJHLrEOP4ewPaPYuOBke0/gpAdSiNPyy
AkJRET4Fu16hBWryC9S8FOYvo6bYeGBnykUmPni0rM/7yWSfve3Sk6bjkVoMaT7/
rtl5vH7SzKT53gXwhXJmOPeGVDGvKSaPTq+OsiogJCgz2t1spjyjfPFNDLIhxnwR
Jk95zh/HM19Qu16UhPcTtKNCqNzqh/bY5D1FF1/Woq5j2+xJKBBOSGDxT752w5eC
a2bL3d/ftgdS7hxnYRdhFjvzXEheRsIhlWURP7oxjxUBoAn9vCd0E6v3xwbjyuh0
vWpC+uGvr6i6xNxiW9kK
=u9Tj
-----END PGP SIGNATURE-----

--2Kg7LOib4e4U9mpItmG5GWOripGj7gBAR--

--===============1324245522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1324245522==--
