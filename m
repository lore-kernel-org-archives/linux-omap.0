From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 07/19] OMAPDSS: hdmi5_core: Fix compilation with OMAP5_DSS_HDMI_AUDIO
Date: Fri, 16 May 2014 13:31:01 +0300
Message-ID: <5375E8E5.5020007@ti.com>
References: <cover.1399884780.git.jsarha@ti.com> <6e02441be6a699e4376e547ae99515d14079850d.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="W2A8t0RkUIJJd9L4o9hKCMVLNFd5Rn1BO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49972 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756838AbaEPKbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 06:31:12 -0400
In-Reply-To: <6e02441be6a699e4376e547ae99515d14079850d.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

--W2A8t0RkUIJJd9L4o9hKCMVLNFd5Rn1BO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/05/14 12:12, Jyri Sarha wrote:
> Use correct variable name for base address.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/hdmi5_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video=
/fbdev/omap2/dss/hdmi5_core.c
> index 270ebdd..af88e3c 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
> +++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
> @@ -786,7 +786,7 @@ static void hdmi5_core_audio_config(struct hdmi_cor=
e_data *core,
>  	REG_FLD_MOD(base, HDMI_CORE_AUD_GP_POL, 1, 0, 0);
> =20
>  	/* unmute audio */
> -	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AUDSCONF, 0, 7, 4);
> +	REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCONF, 0, 7, 4);
>  }
> =20
>  static void hdmi5_core_audio_infoframe_cfg(struct hdmi_core_data *core=
,

This fix is independent of the rest of the series, so I'll already pick
this one to my 3.16 omapdss branch.

 Tomi




--W2A8t0RkUIJJd9L4o9hKCMVLNFd5Rn1BO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdejlAAoJEPo9qoy8lh71QSoP/jSYhAEh5ad2o5B8+Y74bcc8
cOLG5naHlZG3V9TPXg2wxJOgVYOWR5RK9LZb4xMufjo1OKItJpke6lI0lqtuZBG7
JgcRkQSqT1OkrB5NY4amcYzO/yCJuATHer1as5srxB03VmC0fuSqJoDIIUCemzTL
35csLVxi5yWBeDEe2VeEoqfpprU9VgNUDGiJKmEpiLuGv6ypwRNhMNrARxX+cf4q
suePVcs288Cwfs7jvP8qgNYO3Y3PKECxviDDEhZYxsnpxAgd2If+EA2VdT2BT/vn
uy+tcxyz3YFYtkmnn+r54WL2SuDTwRd2TYOpL2C5ct585n6YoGAAaciuTSzwoItn
X4aeNvVN+YVs9YhfBxv+dLE1EwgFUoIKDlxJoie190nWhDXaHzQfNcDcXJweTZJM
Nft/fAowx5K+7fpmawgJEzhKv2t0gImQXCqkrXeW6o/9G797pk81/foeZNFGpJIM
7fzKQJ6MLigtOhdiAwoD7ih8it+0a2l+u9ykYz1aeLnc55O4LMiV4tBeou7DGvO1
ekD6a3krgC7BCgmubmwALwnfyxGnhb2UvDw6EU71ZpfJ21drUjmSOrR69B5gFcOt
edD70NMXSGBYSrOJFcxZYPVPhCrgA4op2LvK2nsi+VUtObuYKDZdZ+NqtHkgehcD
ANswUsgdVsG/5pZ0NtGM
=Lc2L
-----END PGP SIGNATURE-----

--W2A8t0RkUIJJd9L4o9hKCMVLNFd5Rn1BO--
