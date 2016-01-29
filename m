From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omap dss: add missing includes
Date: Fri, 29 Jan 2016 13:30:42 +0200
Message-ID: <56AB4D62.8030906@ti.com>
References: <6010313.rYeAixWRHJ@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0628918394=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <6010313.rYeAixWRHJ@wuerfel>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0628918394==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MmRNF7NMGa8SfhK4hnabNc8UnFqnCO85d"

--MmRNF7NMGa8SfhK4hnabNc8UnFqnCO85d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/01/16 12:52, Arnd Bergmann wrote:
> The omapdrm dss driver currently fails to build in some configurations =
when
> the pinctrl and seq_print declarations are not visible:
>=20
> omapdrm/dss/dss.c:1268:2: error: implicit declaration of function 'pinc=
trl_pm_select_sleep_state' [-Werror=3Dimplicit-function-declaration]
> omapdrm/dss/dss.c:1277:2: error: implicit declaration of function 'pinc=
trl_pm_select_default_state' [-Werror=3Dimplicit-function-declaration]
> omapdrm/dss/hdmi_wp.c:26:2: error: implicit declaration of function 'se=
q_printf' [-Werror=3Dimplicit-function-declaration]
> omapdrm/dss/hdmi_pll.c:30:2: error: implicit declaration of function 's=
eq_printf' [-Werror=3Dimplicit-function-declaration]
> omapdrm/dss/hdmi_phy.c:34:2: error: implicit declaration of function 's=
eq_printf' [-Werror=3Dimplicit-function-declaration]
>=20
> This adds the appropriate include statements.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9960aa7cb58c ("drm/omap: move omapdss & displays under omapdrm")=


Thanks, I've picked this up for 4.5.

 Tomi


--MmRNF7NMGa8SfhK4hnabNc8UnFqnCO85d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq01iAAoJEPo9qoy8lh71HmoP/iMoq3V9CPOGivl53NWpEPJt
Po2B6MSBuB3VNmBVtpSUYABJn30spPqZl8ln7r8nLbmeAgSDNKR+pTH/R+6YT4SI
SkSiqZ2//6FcA6xC8zFQF2IQaYTKfnnCN611eTeT/0aD5bM5wAeYO1oF6ZeUEnUw
5EYS8hrVIXsb/lOs/J3j9Ww21iFSLeRjS0La9SXy+XXXLNYodCvENXV5vsJJun+I
I0T+ZZERgZ9lwyoO3poGTOcjFRhf9AklJ7i5kPnmhQWB2gU7stDtCWl5BMCTcIi+
bk25VG7/9SBK59nMfHf8DaQCEoC/srDD4Qan+4Qnt5vZGGTqzmO5JRYtNHdodw6Y
7BlAr7WsP6AmziYjwYd3G0lmp3Ty9zaIg0bojnlE+p3jV9i9WiEOZTvaBsggxP9w
8+Lw9ZnLRTFhDgSd2k1Qw5vCNGoFfQnWKC2K3tffvOEkOYTsCEageHTbBf7mzRwI
OEeZ46g9tZqg/LdgqKLnvGo6unBpDztCFpA0Wrwye69O6hwLtx4zATUghinCah8t
k+8+tQ1u8o11NJsr/CSUNhXZcKR7IeZW4BnBoQS9UKi3QfZBB9qxI51jfYYj4jsX
8Od3x+DOntTVRygLo0RcAT7cUhkqel+s9Ggb3OD1c6W9ZaLRWwBZ31od+R4DCx8a
1NEe0rxapu63vzqdRdI4
=PsnI
-----END PGP SIGNATURE-----

--MmRNF7NMGa8SfhK4hnabNc8UnFqnCO85d--

--===============0628918394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0628918394==--
