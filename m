From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drivers: video: omap2: dss: Use PTR_RET function
Date: Wed, 20 Mar 2013 13:56:00 +0200
Message-ID: <5149A3D0.2010902@ti.com>
References: <1363680194-10404-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2A615FFB74B551E607B9202"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36484 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806Ab3CTL4G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 07:56:06 -0400
In-Reply-To: <1363680194-10404-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

--------------enigC2A615FFB74B551E607B9202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-19 10:03, Alexandru Gheorghiu wrote:
> Use PTR_RET function instead of IS_ERR and PTR_ERR.
> Patch found using coccinelle.
>=20
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  drivers/video/omap2/dss/core.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/c=
ore.c
> index f8779d4..60cc6fe 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -181,10 +181,7 @@ int dss_debugfs_create_file(const char *name, void=
 (*write)(struct seq_file *))
>  	d =3D debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
>  			write, &dss_debug_fops);
> =20
> -	if (IS_ERR(d))
> -		return PTR_ERR(d);
> -
> -	return 0;
> +	return PTR_RET(d);
>  }
>  #else /* CONFIG_OMAP2_DSS_DEBUGFS */
>  static inline int dss_initialize_debugfs(void)
>=20

Thanks. I'll apply to omapdss tree.

 Tomi



--------------enigC2A615FFB74B551E607B9202
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSaPQAAoJEPo9qoy8lh71HgEP/jg9yn1N5Qn0sMyuhN5N81tB
lbPxI3b2yKjUmGafSA43VUu0FR0CjCR4kUCKYc3edkDLIpUdslEQE24JvoNC3FFJ
kh88vfDM5rQIfedOIpUfVeDqp1Wlo/KD14yYsap/HvE7piSa2NKd9laXRkxYduW4
42RffmCx2ZIGJkVRmP0/Aj8pCzihS+z1YPKfUiiqQGSJ6m+nmt35GcoPB7wSDoYl
o48U8ZpAYb0i44ye0w/ntLymH1FDgqwrNU0Jk9us9YrpHwy6BrosIHrusK4xaX2W
F+NZwsF05dprdeXUEctyF0vcUfdUECCo8fv7tXlWASjrbhODfkD2drF73ZhPf++O
QBNSup7MjU3EzmwM1TbGHTmE1KoTUjW/RglURrJfdrnA/+eWnjyhRMQYXAwHjEsL
n7N/coknvcmt7NF50e3kXq/nyTOKraWcxm04XAlGxy/Qd0gnqDHBOopzAgx2fYkA
GjyYz3RHaXT2tF2Nhwura+MSZ5Ge/yhHP+xxnwcwSsVlk5NrdPTvDJeYtSFT8yH2
mMkxqRvEEaXbmVcdH7963BApQImhRGQ8T8OB0wgXnGxmCa4ibYqgO/Cbl6e3v3Iy
bwRaOUprWyYeDO+qE+aaJHStCA6X/x7Um4zMPcZQwYnt8c4LLAtiOqDCiea7PgpZ
STSU8Mc1DMDyacEl/Qxv
=XfqW
-----END PGP SIGNATURE-----

--------------enigC2A615FFB74B551E607B9202--
