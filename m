From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: bandgap: Fix build warning if
 !CONFIG_PM_SLEEP
Date: Tue, 24 Feb 2015 14:03:26 -0400
Message-ID: <20150224180324.GA3448@developer.amazonguestwifi.org>
References: <1423234546-10458-1-git-send-email-grygorii.strashko@linaro.org>
 <20150209150106.GB21362@kahuna>
 <54ECA053.8000809@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33530 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbBXSCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 13:02:54 -0500
Content-Disposition: inline
In-Reply-To: <54ECA053.8000809@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Zhang Rui <rui.zhang@intel.com>, Paul Walmsley <paul@pwsan.com>, Viresh Kumar <viresh.kumar@linaro.org>, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 06:01:23PM +0200, Grygorii.Strashko@linaro.org wrot=
e:
> Hi Rui,
>=20
> On 02/09/2015 05:01 PM, Nishanth Menon wrote:
> > On 16:55-20150206, grygorii.strashko@linaro.org wrote:
> >> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> >>
> >> Fix following build warning if CONFIG_PM_SLEEP is not set:
> >>
> >> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1478:12: warning: 'ti_band=
gap_suspend' defined but not used [-Wunused-function]
> >>   static int ti_bandgap_suspend(struct device *dev)
> >>              ^
> >> drivers/thermal/ti-soc-thermal/ti-bandgap.c:1492:12: warning: 'ti_band=
gap_resume' defined but not used [-Wunused-function]
> >>   static int ti_bandgap_resume(struct device *dev)
> >>              ^
> >> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> >> ---
> >>   drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/the=
rmal/ti-soc-thermal/ti-bandgap.c
> >> index 74c0e34..5d46660 100644
> >> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> >> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> >> @@ -1402,7 +1402,7 @@ int ti_bandgap_remove(struct platform_device *pd=
ev)
> >>   	return 0;
> >>   }
> >>  =20
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_PM_SLEEP
> >>   static int ti_bandgap_save_ctxt(struct ti_bandgap *bgp)
> >>   {
> >>   	int i;
> >> --=20
> >> 1.9.1
> >>
> >=20
> > Suggest aligning with Paul as well:
> > https://patchwork.kernel.org/patch/5795391/
>=20
> ^Paul Walmsley wrote: Oh, nothing to be confused by, I just missed the
>  earlier patch. I withdraw mine.
>=20
> >=20
> > Otherwise:
> > Acked-by: Nishanth Menon <nm@ti.com>
> >=20
>=20
> It looks like this patch is missed in 4.0-rc1, so could it be merged
> during rc cycle or you'd like me to resend it?
> (I've rechecked - it can be applied on top of Linux 4.0-rc1 without any i=
ssues)


No need to resend. I will add to my -fixes queue.

BR,

Eduardo Valentin

>=20
>=20
> --=20
> regards,
> -grygorii

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7LzgAAoJEMLUO4d9pOJWkQMIAIbveWllThcxOVmwosBxOC4e
sqlYCntRYM7FkA7lg4SJ24vGV5gMQS0I97SEh/rAcTKufCltp/s6JOnMdGC/zMrv
wtdqXBMofjR1kP7fa2xuFEbUGXlm9fAW6yQjIk1HwAauAhEwIxa/O3m/yHt52W+x
xsW+ZTDgWDisMB6xTzzfl1HpgxRu3NfsibqvCdkSCOzR1j8M1Tnyh9KzFrN6itox
miVSb7R/v51QjmyUI3y6Edtd9NHrGQAHIx+MniccWJRzQ/tbGpU1G+B0BX5s1afL
sBiGFMvTn3aMCY6ZQ3kgA8mT4P3zoTVyGq1yM0UEAbEYxqMPYc6mFcAh+kVLpnI=
=VuTy
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
