From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Tue, 13 Mar 2012 15:45:53 +0200
Message-ID: <1331646353.2856.354.camel@deskari>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-eanzQgdhRZlF5wJcJhrM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53982 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151Ab2CMNp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 09:45:57 -0400
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so647485lah.37
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 06:45:55 -0700 (PDT)
In-Reply-To: <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: archit@ti.com


--=-eanzQgdhRZlF5wJcJhrM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin, Paul,

I know you're busy, but I'd appreciate a comment/ack on these two small
patches, so I could get them in to next merge window. Otherwise using
any other OPP than OPP100 will most likely break the DSS.

This looks quite straightforward fix for me, but I'm not sure if there
could be any side effects.

 Tomi

On Thu, 2012-03-08 at 13:13 +0200, Tomi Valkeinen wrote:
> Most of the DSS clocks have restrictions on their frequency based on the
> OPP in use. For example, maximum frequency for a clock may be 180MHz in
> OPP100, but 90MHz in OPP50. This means that when a high enough pixel
> clock or function clock is required, we need to use OPP100.
>=20
> However, there's currently no way in the PM framework to make that kind
> of request. The closest we get is to ask for very high bus throughput
> from the PM framework, which should effectively force OPP100.
>=20
> This patch is a simple version for handling the problem. Instead of
> asking for OPP100 only when needed, this patch asks for OPP100 whenever
> DSS is active. This obviously is not an optimal solution for cases with
> small displays where OPP50 would work just fine. However, a proper
> solution is a complex one, and this patch is a short term solution for
> the problem.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/video/omap2/dss/core.c |   10 ++++++++++
>  drivers/video/omap2/dss/dss.c  |   13 +++++++++++++
>  drivers/video/omap2/dss/dss.h  |    1 +
>  3 files changed, 24 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/cor=
e.c
> index 8613f86..999bcbc 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -87,6 +87,16 @@ struct regulator *dss_get_vdds_sdi(void)
>  	return reg;
>  }
> =20
> +int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
> +{
> +	struct omap_dss_board_info *pdata =3D core.pdev->dev.platform_data;
> +
> +	if (pdata->set_min_bus_tput)
> +		return pdata->set_min_bus_tput(dev, tput);
> +	else
> +		return 0;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
>  static int dss_debug_show(struct seq_file *s, void *unused)
>  {
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 4a6b5ee..4a3eb22 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -826,11 +826,24 @@ static int omap_dsshw_remove(struct platform_device=
 *pdev)
>  static int dss_runtime_suspend(struct device *dev)
>  {
>  	dss_save_context();
> +	dss_set_min_bus_tput(dev, 0);
>  	return 0;
>  }
> =20
>  static int dss_runtime_resume(struct device *dev)
>  {
> +	int r;
> +	/*
> +	 * Set an arbitrarily high tput request to ensure OPP100.
> +	 * What we should really do is to make a request to stay in OPP100,
> +	 * without any tput requirements, but that is not currently possible
> +	 * via the PM layer.
> +	 */
> +
> +	r =3D dss_set_min_bus_tput(dev, 1000000000);
> +	if (r)
> +		return r;
> +
>  	dss_restore_context();
>  	return 0;
>  }
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index d4b3dff..42f8f62 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -162,6 +162,7 @@ struct platform_device;
>  struct bus_type *dss_get_bus(void);
>  struct regulator *dss_get_vdds_dsi(void);
>  struct regulator *dss_get_vdds_sdi(void);
> +int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
> =20
>  /* apply */
>  void dss_apply_init(void);


--=-eanzQgdhRZlF5wJcJhrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPX0+RAAoJEPo9qoy8lh71zEUP/2rs2BBrUEcweRABQS4XxBoe
xPN99ix6Uvr5DFMfL1fcFvGQl+QqQlbhDdixhVXTXVlZvODCvAwCl9J+hoYMHO+V
U1vmm2hClAQCxssyZBU/AV+m2p1lVhWlts1quhCD9K7FzAsHs6ur1Ahnzp5psixC
f22SYdW9dyNJUvBEqlucEKO7wCM1PFvD4BS3L3Cm6kf2HEkuZqpQBRts9QAaGpWD
pl3Je1ao3UTVPBlec71UTsno2l52h7UdENJuqvlo5LyXf9NFkOZDmD1ZmfWLT44P
6VYd6/WWekEE146CNcGGgn8RUmHrt2M1R+tGfXwk4mkxJQ8e20gzYvXCOX2Oxltr
2gOQ7xxYidV3w2F6PoGP7d6TTvOsc2uBlXSlSIIpCmYoJXrLrnLo4qm8WNrAeVk1
wrnVAEJkppqmSelLrrYSLFOaKgKYktfkA/rcNEO6OBjcnk6UATWDF4Gd/I9pxyuI
yLVVyUIVU+zG2Jzzox6dgfz+8GoVwBpkkGiqvuEibnV6OMChSzhslM/L6NoeFOCI
XH+pLgJg80J3HWjNPb8MsxOmFD1mbELpE/zbdlpFbh21HAKLJhG7fBGM/91UeubI
4jcjgujVOK66eDz57sCZe0BNb/MIR8XLNjsh1t0cIuDQLxT9gV5hrotzocZPsUk0
KooM2egCTEBhiSmcfn0g
=m5fq
-----END PGP SIGNATURE-----

--=-eanzQgdhRZlF5wJcJhrM--

