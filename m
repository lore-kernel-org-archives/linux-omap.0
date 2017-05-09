From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 27/28] ARM: OMAP2+: Don't register omapdss device for
 omapdrm
Date: Tue, 9 May 2017 14:51:17 +0300
Message-ID: <712ed6d1-d20f-a778-425f-a00e2e8bf78a@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508113303.27521-28-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0942731977=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170508113303.27521-28-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0942731977==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UWBCHHJajXqensKaKntUd64F0KBpigs8b"

--UWBCHHJajXqensKaKntUd64F0KBpigs8b
Content-Type: multipart/mixed; boundary="e2JUGR9AK6bXbxsAe7p7m17W3CGiPUXxp";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Message-ID: <712ed6d1-d20f-a778-425f-a00e2e8bf78a@ti.com>
Subject: Re: [PATCH v2 27/28] ARM: OMAP2+: Don't register omapdss device for
 omapdrm
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508113303.27521-28-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20170508113303.27521-28-laurent.pinchart@ideasonboard.com>

--e2JUGR9AK6bXbxsAe7p7m17W3CGiPUXxp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/17 14:33, Laurent Pinchart wrote:
> The omapdrm driver doesn't need the omapdss device anymore. Although it=

> can't be removed completely as the fbdev driver still requires it, we
> can condition its registration to the usage of the omapfb driver.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-omap2/display.c | 111 +++++++++++++++++++++++-----------=
--------
>  1 file changed, 60 insertions(+), 51 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--e2JUGR9AK6bXbxsAe7p7m17W3CGiPUXxp--

--UWBCHHJajXqensKaKntUd64F0KBpigs8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEa01AAoJEPo9qoy8lh71VJwP/i48CGZKcnTqN/ypbXzxJzrS
hfN0KEcsZHTVu2psRtwlAMz3SyXLLCZbofV8A6YChcAk8XcHQb662HKah0Qa/Tnu
o/MuAt+pibhjAIULVfqY6hLXFW5+cVfvj0QIfS5POsOeAR1hbkHpia6095TE3D7v
xCEZhI0JEdqU9FSGSGNcefp9BNZUZ3Yc8cS/IZG0wwTV6aaIuB+X53r0Dp4RGNzW
j1Glkn5yMA1dMbQa3WmXWIwvFdZboxMlessmCEsjMQxfOFt9uKjC1gaqZQnmbXUJ
2sr5LnOAp6AfoDk7LYNEAzfQ+VF6lgHDogwOjqYP3yETVOvnsqVqiKJITYWkhEq/
93bcLBsVYGozxyXXEzTjai5Nv66pLJ1Gj4WOBDfMSH5nlal4+Grio9Jbf+Ipw++f
fQqTFoNGJJHlFR0IYv8dpg6djihhQ+6ug1FYtUMOePSypjDqnfuQFRA67dZQwHxX
lHatjgZnU7nof5IOf/yWBDdCEzEvwey4uMA72LVkwVG/x0DU6VRlzhMG2ZAiQvfZ
a7pbg/HLFc3bcE34/y7lSiyzLaQgzB75bBoTH2rzbLb6wK/hBAb7sHQp6VjH6Gqk
ZCrKAVolXRTpGRL2uQV5nrOz+5CbX/ADQpJCocdv3tf0YhoruBjYpupaeF+xQWiR
VdqD+ff8hIPLvcktr1+1
=Auix
-----END PGP SIGNATURE-----

--UWBCHHJajXqensKaKntUd64F0KBpigs8b--

--===============0942731977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0942731977==--
