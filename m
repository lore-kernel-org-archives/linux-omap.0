From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 26/28] ARM: OMAP2+: Remove unused omapdrm platform
 device
Date: Tue, 9 May 2017 14:49:59 +0300
Message-ID: <a45f9f5b-88ac-eec5-42c3-6b80de1f5283@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508113303.27521-27-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1335521281=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170508113303.27521-27-laurent.pinchart@ideasonboard.com>
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

--===============1335521281==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2hFhXU1nRnX012vESQSbogEt2nXnuBULg"

--2hFhXU1nRnX012vESQSbogEt2nXnuBULg
Content-Type: multipart/mixed; boundary="mAux0DU1osWJjDXC7LiNcf0VIlM4E0Ku2";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Message-ID: <a45f9f5b-88ac-eec5-42c3-6b80de1f5283@ti.com>
Subject: Re: [PATCH v2 26/28] ARM: OMAP2+: Remove unused omapdrm platform
 device
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <20170508113303.27521-27-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20170508113303.27521-27-laurent.pinchart@ideasonboard.com>

--mAux0DU1osWJjDXC7LiNcf0VIlM4E0Ku2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/17 14:33, Laurent Pinchart wrote:
> The omapdrm platform device is unused, as a replacement is now
> registered in the omapdss driver. Remove it.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/mach-omap2/Makefile  |  2 +-
>  arch/arm/mach-omap2/display.c |  7 ------
>  arch/arm/mach-omap2/display.h |  1 -
>  arch/arm/mach-omap2/drm.c     | 53 -----------------------------------=
--------
>  4 files changed, 1 insertion(+), 62 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/drm.c

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--mAux0DU1osWJjDXC7LiNcf0VIlM4E0Ku2--

--2hFhXU1nRnX012vESQSbogEt2nXnuBULg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEaznAAoJEPo9qoy8lh71+YIP/jYzSAPMzwZ9QeFK8kLRfYTn
w57MpqsvZlxM6JyF3D2LXylCanSPTi2UUTUdr0Umf9LVkyjlB6ebRpGb6HFYa8IM
F1HDyeu8JQ72DI0y6qIvc71vv3BRgxRjgYhx80LJH63S+Mka+XKPoivH5yr4lBjR
qjh9L48zcYVBJBDlfQV6wrMD46Y5MvmHc3VcDvkinuQPhAHApdo2Ua2AQozdRV/A
BJ9eWNT0noyXcZBNP0qDhoJfU5D3J7MLnVUtIbnKfZT04yojRGxvU/qI1D/44yEu
xpng/YpJCIGMMzMdWbcxRmATKcler5qcS4IzyHFVBaq+P/LyBrWSdgaXJs7d0kV/
GW+uOuRccyw8XJ1PPFqb/1Jjc8YIUtntoSynZA2WPCiW215ZDUKkys2xonmbGTou
1LXLslIWeWohAps3d49Y+YWPR4Tk/+m2DtkDnkDDEnmlma+iVih/rCcRZUuhw/Km
fYBIhyFSAubbi5LpHPsZJmet/4jQDOJdpguCJzzl4ZBAwMZ4+DeQn3kRl6CTitJS
6WLIrGUmUMR7dHVOKH1LfIeoaCEz4ipAVc9RGaBfkLSnidlwHzHBNzmnVyThn8An
0H7wxB0/wJ4s62FIZOkjWu2IHdfDw997OuJG8L24Kcc3dF6WWFPMBGAN1Yjd9THQ
zhPU3UWpN6bvNJiJnjqF
=GGRj
-----END PGP SIGNATURE-----

--2hFhXU1nRnX012vESQSbogEt2nXnuBULg--

--===============1335521281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1335521281==--
