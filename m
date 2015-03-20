From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: extend pm notifier to handle hibernation
Date: Fri, 20 Mar 2015 14:20:30 +0200
Message-ID: <550C108E.3020907@ti.com>
References: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="eQqrOXR1IJHWj8me6rAi0aok3JqKxXSjq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53820 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbbCTMUh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 08:20:37 -0400
In-Reply-To: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org

--eQqrOXR1IJHWj8me6rAi0aok3JqKxXSjq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/02/15 19:03, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>=20
> Add handling of missed events in omap_dss_pm_notif which are
> needed to support hibernation (suspend to disk).
>=20
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>  drivers/video/fbdev/omap2/dss/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev=
/omap2/dss/core.c
> index 6b74f73..e60976a 100644
> --- a/drivers/video/fbdev/omap2/dss/core.c
> +++ b/drivers/video/fbdev/omap2/dss/core.c
> @@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_bloc=
k *b, unsigned long v, void *d)
>  	DSSDBG("pm notif %lu\n", v);
> =20
>  	switch (v) {
> +	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
> +	case PM_RESTORE_PREPARE:
>  		DSSDBG("suspending displays\n");
>  		return dss_suspend_all_devices();
> =20
>  	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
>  		DSSDBG("resuming displays\n");
>  		return dss_resume_all_devices();
> =20

Why suspend displays when PM_RESTORE_PREPARE happens? Why resume when
PM_POST_RESTORE happens?

 Tomi



--eQqrOXR1IJHWj8me6rAi0aok3JqKxXSjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDBCOAAoJEPo9qoy8lh711zYP/jhWQktaeuNeo+w4wMY2fpZ7
Y76VZvOwjfbYmx2TYvlQXhAgeIgX4XRFvfrtJwC5/NkL8726EGw4To2DsndYA/gh
dep3AcDuGSgmSWfIMh47XqEGG3+74A9iVM9A+rdWf4o8wSdX+9eM+cwKv69nkmcQ
X26COqSYEksDocuN39cStaGse32yrTvDvALZffJBlowIK81LF+Do3N6NLxiOz8u4
yvVtzQ2VkxBfP+aK3rMSfWT4EAojFuPMS+rG/O71eOKmmPsGi/jwrAuCAWabcmo3
gd4zr4qM1LHybSYhYPHybQMRNUmIHSFxNigOplhRtRmhT598+ybhNOO4SFhF2et5
UEmHPI8GyRlMsbgEki5o74jIzYs91gQv31gv2WIlf9F/j8ApZCEnIhJZtsktlOIR
pNdXkCxGyBQvs9s8To2e0Qegu0jZv5+eph2mdEHPNzN+xOtARdK73N2WBZgFsjgx
a/od+NUSWkO30LZqd079iaaUIQBAbdYoGRIPgGuYRRaLkN3l78tQvgx5fcEAYb4h
81uuaq4T2MEQAHPmZ04s8gJrNEUbjB7je/NrlxNJC8GRYi5WLImQtwHa8WpVpOyr
DDAZiCbOYxgwGkzjgeed6dT2YXA70dMYAkhPb4KIjVSRveeVEjh6DfywZ2+3JK5E
5RV259f6aGB7KIzVStMU
=OQtZ
-----END PGP SIGNATURE-----

--eQqrOXR1IJHWj8me6rAi0aok3JqKxXSjq--
