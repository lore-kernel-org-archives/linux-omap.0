From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: da8xx-fb: fix videomodes of lcd panels
Date: Mon, 29 Feb 2016 18:30:19 +0200
Message-ID: <56D4721B.3010508@ti.com>
References: <1456751539-19298-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Vm68KgfWoMbFUaKH2tK2L3IJEdf03SCf"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456751539-19298-1-git-send-email-sushaanth.s@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sushaanth Srirangapathi <sushaanth.s@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--7Vm68KgfWoMbFUaKH2tK2L3IJEdf03SCf
Content-Type: multipart/mixed; boundary="MpxGvXDM7L0p4q79e7pwIsnv6RTaGw0OW"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sushaanth Srirangapathi <sushaanth.s@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Message-ID: <56D4721B.3010508@ti.com>
Subject: Re: [PATCH] fbdev: da8xx-fb: fix videomodes of lcd panels
References: <1456751539-19298-1-git-send-email-sushaanth.s@ti.com>
In-Reply-To: <1456751539-19298-1-git-send-email-sushaanth.s@ti.com>

--MpxGvXDM7L0p4q79e7pwIsnv6RTaGw0OW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/02/16 15:12, Sushaanth Srirangapathi wrote:
> Commit 028cd86b794f4a ("video: da8xx-fb: fix the polarities of the
> hsync/vsync pulse") fixes polarities of HSYNC/VSYNC pulse but
> forgot to update known_lcd_panels[] which had sync values
> according to old logic. This breaks LCD at least on DA850 EVM.
>=20
> This patch fixes this issue and I have tested this for panel
> "Sharp_LK043T1DG01" using DA850 EVM board.
>=20
> Fixes: 028cd86b794f4a ("video: da8xx-fb: fix the polarities of the
> hsync/vsync pulse")
> Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
> ---
>  drivers/video/fbdev/da8xx-fb.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks, queued for 4.6.

 Tomi


--MpxGvXDM7L0p4q79e7pwIsnv6RTaGw0OW--

--7Vm68KgfWoMbFUaKH2tK2L3IJEdf03SCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1HIcAAoJEPo9qoy8lh71MkkQAKKJCSQBGTaT9zSYSxwNL3gl
YPVIXKJnnTUAU5F+QSwGfU/lOkIJz8BkM5+z3BkQI5658avrozTozr1gaV1p7y6Z
rdEmkM5gPQ0focdkiA+ELMnylM0/CIAaifYCQ6bIzH5Z4fkimZjMktPzHnRPH/rX
looLXT+uz6yHgUPb3wVNE7wuCxjpPHjogy57B2oInLINeJsBU2sIR9qbXUSxlf/m
UH5eYja+Dh+FLGJVuXAGW3gGzj1ekBg00v3vcoYD8ahUa/YLUhjAYoSUYZUVXa/D
UCwiQ46L39wd2zpEy9+ylHHXz1l4WKCxsF38ZhQua9WBevraIweTFhkCNav1mXxR
s8WDEQ4GOaTZu08g1+0tTJnce0/q1soA4PyDmj5niew1IraUBnbfRIPHUpSY3xWn
ovAIMVnlHKaKYWUrcEoWwwHiGii5DXQCzUcQUf++hLwK7iU8SXj3PkHhoZjhcJ9r
bi6vesFds/daAn89svmy+XsSsVZYkZYxK4EdpqCWAaKKL709j7T1bCdmTGxaSKZ0
10Qt7iexSAK6R0SqTO3MJFj18c/xL5k9lXb1CmQqwr1zuD6yQd7lj+MscLxrOc+v
J4PShbDZ/dk+dA23BxZHx3X9GSNm5S9bk0RAk3yYBR/j1kqK0GnfvAl/k8kr15jA
ZYcJjVMBUks8wKeoeNd/
=/6yN
-----END PGP SIGNATURE-----

--7Vm68KgfWoMbFUaKH2tK2L3IJEdf03SCf--
