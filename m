From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/7] OMAPDSS: DISPC: Move burst_size and buffer_size to
 dispc_features
Date: Thu, 29 Nov 2012 14:01:23 +0200
Message-ID: <50B74E93.6040602@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <c40e58eec3b2100368c696db05a68d49d49f1f0d.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44569E23CB47718FD1090BCB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab2K2MB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 07:01:26 -0500
In-Reply-To: <c40e58eec3b2100368c696db05a68d49d49f1f0d.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig44569E23CB47718FD1090BCB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
> The burst_size and buffer_size being local data to DISPC are moved to
> dispc_features and so removed from struct omap_dss_features. The functi=
ons
> referring to burst and buffer size are also removed from dss_features.c=
 as they
> are now accessed locally in dispc.c.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   21 +++++++++++++++++----
>  drivers/video/omap2/dss/dss_features.c |   29 ------------------------=
-----
>  drivers/video/omap2/dss/dss_features.h |    3 ---
>  3 files changed, 17 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index 3d0ff5b..9f259ba 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -104,6 +104,9 @@ struct dispc_features {
> =20
>  	/* swap GFX & WB fifos */
>  	bool gfx_fifo_workaround:1;
> +
> +	u32 buffer_size_unit;
> +	u32 burst_size_unit;

Can you add the comments "in bytes" to these. Otherwise this looks good.

 Tomi



--------------enig44569E23CB47718FD1090BCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt06TAAoJEPo9qoy8lh71HBUP/08FEcoYw9SnRyVOSiwtlkzN
wumvHVQhM0IcqbacILLH6OWvqMeKPGx2po0IVWKI+fxFm+EKEAukiY4DZwtHhyMV
G3pNjWc3m+8kyJCagllfKPra/xGJ97Dgo6zERoFtaCaBcdz92YxE7mCokPL395D6
RRa+tQseLEJoUAjTO0kTYAYAcpek8X/jLLm3fBZhraf5swHI8w5NBqUNAFMmuSz0
ytp4zX+O9wkEKViHusVoVzxK8oWQnpOgHlLjYabKKIHm6LTmIgd1XSMNglcFWsBj
+gOCaeHCoIbp5+R62Bw9XETnFNp1uifaUUXGXPpaMlYgX94NVGuZEVcqpEXJbiHA
kJkozgDv/VpYPeQeQvAciEYJTpUfcrUyo9Bq6zKwY1VzPlFQvyYnYiKXXyHWEoJ6
jsu1gQYA1trHXS725/WX87WzZoXwKXm5APEXTMrksTCdBitNL42f5Mq5YuQ5VH3w
YECbWouoVBuaOVVIM9oIvNv0F3qIZuHLq7YaT03iaVE537TyvgSDUZJSrYOXCoTn
ZMKDJsjorBea0HPswwVAjC7SKjEkBj49RveuHCQ71GW8Opq2OMJVqkz8YA4JjlGg
owpqEwNiF2j/cDFjlCL61CR/xD9wXivKAP8DOw/Xhnp5SP3ss/gyErA+F05AAsSt
yVDnlXl1Tty5tywbbJ5p
=d8jO
-----END PGP SIGNATURE-----

--------------enig44569E23CB47718FD1090BCB--
