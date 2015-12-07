From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [patch] OMAPDSS: DSS: fix a warning message
Date: Mon, 7 Dec 2015 17:39:28 +0200
Message-ID: <5665A830.7030201@ti.com>
References: <20151204131458.GA12792@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="avLNdaKKQjiHN3xGdPNIu6SNnClK9hN1T"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151204131458.GA12792@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--avLNdaKKQjiHN3xGdPNIu6SNnClK9hN1T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/12/15 15:14, Dan Carpenter wrote:
> The WARN() macro has to take a condition.  The current code will just
> print the stack trace and the function name instead of the intended
> warning message.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/=
omap2/dss/dss.h
> index 2406bcd..da3a85a 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.h
> +++ b/drivers/video/fbdev/omap2/dss/dss.h
> @@ -343,7 +343,8 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_forma=
t fmt);
>  #else
>  static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt=
)
>  {
> -	WARN("%s: DSI not compiled in, returning pixel_size as 0\n", __func__=
);
> +	WARN(1, "%s: DSI not compiled in, returning pixel_size as 0\n",
> +	     __func__);
>  	return 0;
>  }
>  #endif
>=20

Thanks, queued for 4.5.

 Tomi


--avLNdaKKQjiHN3xGdPNIu6SNnClK9hN1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZagwAAoJEPo9qoy8lh71O5sQAJc+QbjCw0dOFWmG/WHYuis+
igpSLzJh5BGkJTkdukCmW5BFK1tFH91p3L6mLhrDGc00d7mRmBX6Adea4l48UtSg
7nN0jtg8YMHsMF4sGPZ6eNd7j2hcRhj4JuCsLGvnShqPI7juk5JycY81hpEe6NIk
pWbWJ0aVSc1w7O8zSr5zsJPtYTPI6z/NvVXz57UQstYFp/Rj73tmHrU7pVJxFLKG
82XQ3DZdp6L/sfVFaXXyVKPIzBklqUJnL2n2C8x00DqLTWBqO4rrj02GdvkxTWfR
CVL9tu/nHLYiDaIkV9NwI21BHTlGeHeTTs1aQoTUDJJ5z2xCtUNpsPGy1jR+uQAw
Ftw19xdwnTUVXQv252YOJdHNBt4dvmIPPAvHKftsXStqDYK0YjQPF+iUjocmgh2g
nGDIv0/mHyZwpM6jfKEhE0BVCthHBk2/WCofucbv8fALroBEHBPjcWPTC1SM8t4u
qLXffX2TNeTeqVUdD3ht19TfucqYT7ljoUg9vktuj1Ay9VJz6NWsKxdWHTdUBrNM
temHA5l1yzk/2Ka1IjSl+rXiP78IW2TShhFttHJlESh/3UtuymX0mpEE7+6elUnP
1Kiw6EsliOxCvrBr+/YD1CE7Mv5Hu9cc++VntjVqR1/mxcqn9mAstkBgRn2oCNuC
p9ObztLd6SaDPjt5bqCX
=Pe7h
-----END PGP SIGNATURE-----

--avLNdaKKQjiHN3xGdPNIu6SNnClK9hN1T--
