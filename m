From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Thu, 29 Nov 2012 14:18:20 +0200
Message-ID: <50B7528C.1090507@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4A499D2F9B334E4BB6422A2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab2K2MSW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 07:18:22 -0500
In-Reply-To: <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigB4A499D2F9B334E4BB6422A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
> The register fields in dss_reg_fields specific to DISPC are moved from =
struct
> omap_dss_features to corresponding dispc_reg_fields, initialized in str=
uct
> dispc_features, thereby enabling local access.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   87 ++++++++++++++++++++++++=
++++----
>  drivers/video/omap2/dss/dss.h          |    4 ++
>  drivers/video/omap2/dss/dss_features.c |   28 ----------
>  drivers/video/omap2/dss/dss_features.h |    7 ---
>  4 files changed, 80 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index 9f259ba..21fc522 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>  	unsigned irqs[32];
>  };
> =20
> +enum dispc_feat_reg_field {
> +	FEAT_REG_FIRHINC,
> +	FEAT_REG_FIRVINC,
> +	FEAT_REG_FIFOLOWTHRESHOLD,
> +	FEAT_REG_FIFOHIGHTHRESHOLD,
> +	FEAT_REG_FIFOSIZE,
> +	FEAT_REG_HORIZONTALACCU,
> +	FEAT_REG_VERTICALACCU,
> +};
> +
>  struct dispc_features {
>  	u8 sw_start;
>  	u8 fp_start;
> @@ -107,6 +117,8 @@ struct dispc_features {
> =20
>  	u32 buffer_size_unit;
>  	u32 burst_size_unit;
> +
> +	struct register_field *reg_fields;
>  };

Hmm, would it be simpler to have an explicit struct for the reg fields.
I mean something like:

struct dispc_reg_fields {
	struct register_field firhinc;
	struct register_field firvinc;
	struct register_field fifo_low_threshold;
	...
};

Then accessing it would be

dispc.feat->reg_fields.firhinc.start;

instead of

dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;

Not a big difference, but I don't see any benefit in having an array of
reg fields here.

 Tomi



--------------enigB4A499D2F9B334E4BB6422A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt1KMAAoJEPo9qoy8lh71fTMP/iYAgHtdt/ZIzWhEHl7rMXTB
bS0SImiLzhwy1ZiX5aYZW0gR/AJ3yggw0V+ZDJGaYQ77cFg1UzvPFgSau8BWuhN6
ppukIkOCaaQAZBb7JqTe6IgyQEYqFMBPHmsvMCR14r8lbdxU8d5MMJUHOV3t5dW2
IMKxN5WMr613+qb6krfvtyHjbUD41ZlpbV0j2gpV7sDy9SiEmVfg+kQ+N16Ft8ep
2IQKlH6jtvEXAs0mb5YPRtBitq8P9DISWbkf37NR8hPUA4/rI04oatle44gk74Bz
zbu7U5eb/t7mnQfBzMRMET4kR9tLvJVd9m+1TtjeGhoZ5etTnj7TfyQSH4ny3EDO
DDMbFRzleu9TUs3z4LEUXH74wtaDUGTifkpINXQtHU7nJ9gNB0pBmCxoTY1+KyLr
gtb2Ob1nCBCWnx5vzdYEbK306uW1pbLUuVKtcu5FWeygnKP33x1Bda7ItWI1QFcK
AhKIzLeuv+dc/ieOOIEqTz/1EK9oqrLFAohip+0/WMUCSEco0VvgqzOn8ZDgpMg3
kFkdsZcQ5Ixd9pISv6AP0M44KcZwsSHCrq8iHh+cU2fyYJ3TKA/Yf4P19UdMMSQX
l2yD1cYwWs/tIalXpWBBPEprlJ++Y/SJoFEJA7PKoXHnYdozEZtmzVhPPS9cmciW
upz2E+zeU17oCU1FuTY6
=z7eN
-----END PGP SIGNATURE-----

--------------enigB4A499D2F9B334E4BB6422A2--
