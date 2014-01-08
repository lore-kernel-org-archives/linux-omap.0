From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: dispc: Preload more data in pipeline DMAs for
 OMAP4+ SoCs
Date: Wed, 8 Jan 2014 15:52:38 +0200
Message-ID: <52CD5826.9010501@ti.com>
References: <1387278621-10966-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="89ex3LBEbHnBhX2GMB2kXEU9tv36SpcSG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39527 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757061AbaAHNwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 08:52:40 -0500
In-Reply-To: <1387278621-10966-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--89ex3LBEbHnBhX2GMB2kXEU9tv36SpcSG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 13:10, Archit Taneja wrote:
> DISPC pipeline DMAs preload some bytes of pixel data in the vertical bl=
anking
> region before the start of each frame. The preload ensures the pipeline=
 doesn't
> underflow when the active region of the display starts.
>=20
> DISPC_GFX/VIDp_PRELOAD registers allow us to program how many bytes of =
data
> should be preloaded for each pipeline. Calculating a precise preload va=
lue
> would be a complex function of the pixel clock of the connected display=
, the
> vertical blanking duration and the interconnect traffic at that instanc=
e. If
> the register is left untouched, a default value is preloaded.
>=20
> We observe underflows for OMAP4+ SoCs for certain bandwidth intensive u=
se cases
> with many other initiators active, and in situations where memory acces=
s isn't
> very efficient(like accessing Tiler mapped buffers and EMIF configured =
in
> non-interleaved more). The cause of the underflow is because the defaul=
t preload
> value isn't sufficient for the DMA to reach a steady state. We configur=
e the
> PRELOAD register such that the pipelines preload data up to the high th=
reshold
> of the FIFO.
>=20
> Preloading lot of data for older SoCs can have a negative impact. Due t=
o slower
> interconnects, it's possible that the DISPC DMA cannot preload up to th=
e high
> threshold within the vertical blanking region of the panel. We leave th=
e PRELOAD
> registers to their reset values since we haven't faced underflows with =
these
> SoCs because of low value of PRELOAD.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index 6578540..ace179e 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -90,6 +90,8 @@ struct dispc_features {
> =20
>  	/* revert to the OMAP4 mechanism of DISPC Smart Standby operation */
>  	bool mstandby_workaround:1;
> +
> +	bool set_max_preload:1;
>  };
> =20
>  #define DISPC_MAX_NR_FIFOS 5
> @@ -1200,6 +1202,15 @@ void dispc_ovl_set_fifo_threshold(enum omap_plan=
e plane, u32 low, u32 high)
>  	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
>  			FLD_VAL(high, hi_start, hi_end) |
>  			FLD_VAL(low, lo_start, lo_end));
> +
> +	/*
> +	 * configure the preload to the pipeline's high threhold, if HT it's =
too
> +	 * large for the preload field, set the threshold to the maximum valu=
e
> +	 * that can be held by the preload register
> +	 */
> +	if (dss_has_feature(FEAT_PRELOAD) && dispc.feat->set_max_preload &&
> +			plane !=3D OMAP_DSS_WB)
> +		dispc_write_reg(DISPC_OVL_PRELOAD(plane), min(high, 0xfff));

This causes compile warning:

drivers/video/omap2/dss/dispc.c: In function =91dispc_ovl_set_fifo_thresh=
old=92:
drivers/video/omap2/dss/dispc.c:1213:152: warning: comparison of
distinct pointer types lacks a cast

I fixed it by changing 0xfff to 0xfffu

Queued for 3.14.

 Tomi



--89ex3LBEbHnBhX2GMB2kXEU9tv36SpcSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzVgmAAoJEPo9qoy8lh71+EgQAJIq7w/G0MianyqGAav0fhPW
+2YIYpAaRoxZvnsBt6Fs0nX3982iFyq0C9dU94V+YONbi7CLetmWLJ+dorwipGoJ
ORO4j7QEEBzwYxumQSD0VuNei4aD2LPQ8z/YsUK6cZC3/jXwhkXZ74dlDlQ/Gyxw
NOrOQT0+HwuKOFbZ3C1Q9g0AFQfoeNv57xUGujaA0LLypuZlzsFEnvywA+NLp4RQ
SblUOl05nzaer7XRqKBNQeWMGrB55CeJco0uQtO8d0QHAYvzBddRr4mta3PztWTV
ubVh+/u5KOdKbxdz6o7YBZuHhalCkosU1QuHAdUVybvoVTcbU/A4B7A/4/yIZY+I
lT/2oSal83WEXXwbM7mgZYFr/vpdUabDKJUqRhn39JZ6jzrJOxSATlFcpm38YWSv
HSxoUhU9TE7FQ6/1ppAPBKThxaCo16/EkSHkD9Vyu5KQd/FJutxQGXVNJUR/SsPB
Gc3m3eT2G2Bc4IVDi+W6Vgzqa7OhM7sF2L7gv5Oo8Kymcd7s6Xu9RqZ1WgTOy/Kp
dyqrBNlwMF/D31C7X6IIi3r/2c40w616Frc6ii2hte26RtETS9uomgNhTCBd0Hue
v+A/HRytcO2fM+LAo+wDmVFYJT9banwQO+xwYdqpHHxWPdhQ3saINCDOYYxzKAEW
NfjwHCI0MbwF5e05qGzI
=3CL+
-----END PGP SIGNATURE-----

--89ex3LBEbHnBhX2GMB2kXEU9tv36SpcSG--
