From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
Date: Wed, 19 Mar 2014 14:59:13 -0500
Message-ID: <20140319195913.GA4271@saruman.home>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-24-git-send-email-arnd@arndb.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38232 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbaCSUBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 16:01:32 -0400
Content-Disposition: inline
In-Reply-To: <1395257399-359545-24-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2014 at 08:29:20PM +0100, Arnd Bergmann wrote:
> If we enable CONFIG_OMAP_MPU_TIMER and CONFIG_OMAP_DM_TIMER but
> not CONFIG_OMAP_32K_TIMER on OMAP1, we currently get this build error:
>=20
> mach-omap1/pm.c: In function 'omap1_pm_idle':
> mach-omap1/pm.c:123:9: error: 'enable_dyn_sleep' undeclared (first use in=
 this function)
>   while (enable_dyn_sleep) {
>          ^
> mach-omap1/pm.c:123:9: note: each undeclared identifier is reported only =
once for each function it appears in
>=20
> This attempts to fix the #ifdef logic to deal with all combinations
> of timers.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-omap@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>

I had sent a fix for months and months ago, what happened to it ?

> ---
>  arch/arm/mach-omap1/pm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 40a1ae3..7dff68e 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -71,10 +71,10 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_=
SAVE_SIZE];
>  static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
>  static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
> =20
> -#ifdef CONFIG_OMAP_32K_TIMER
> -
>  static unsigned short enable_dyn_sleep =3D 1;
> =20
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
> +
>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *at=
tr,
>  			 char *buf)
>  {
> @@ -643,7 +643,7 @@ static const struct platform_suspend_ops omap_pm_ops =
=3D {
>  static int __init omap_pm_init(void)
>  {
> =20
> -#ifdef CONFIG_OMAP_32K_TIMER
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
>  	int error;
>  #endif
> =20
> @@ -700,7 +700,7 @@ static int __init omap_pm_init(void)
>  	omap_pm_init_debugfs();
>  #endif
> =20
> -#ifdef CONFIG_OMAP_32K_TIMER
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
>  	error =3D sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
>  	if (error)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> --=20
> 1.8.3.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKfcRAAoJEIaOsuA1yqRE+PkQAK2l0CxTQeqZKKjLjXQ4GsJK
z1zOLT5CbdBebbtWtqNLM+jEp1l54NHGOL6xp0rAXfuuMR2PhXr0sk1oTOSMKQS6
unvhTS1RTrvWIxTYY0SFNvl7fo3Ez7XgXtRdcW9QDq2G+PmDyQpd5L6/SFNM6J4x
UORNc7yZB42fEvyFT4GHw3Mlp1JX1wZN2fF5ygEUwbbCRLZU/C6mVcYpV0u2kehT
CQQIIL9yOI+cZjj7+5kFOCIi4Uz+eE+VjYsjHTwkGnLTXKEdPiU8sTUs7mx/s0zQ
He2ERVjAWkb2cvnsHFMOc3De4tmO5AQ5Suku21N1KJtmEFoEnCRjEbSf+/AFherO
rbCeAmIVLBnzebbzSWGlSdLMk+Pkx4korfTGm+6IkZNF3qGP0X2NR3977rY3FuXh
WXGMnzq37EahDwGaw1Ydn8LqgT23a8irCm0Dd8sV6O0SftDKUtvs3CWwAImBl4Wu
Qr0tEjGGn/l4m+4oyb22jt7TMF753xyr+q+g9Pq4WvylZpj8ECmVMbTTxHF9N1xw
hD1TBPtb10uaYfoiM0KPpwK5NMTHiE90m5CNFpRi2omS9nQ6K3vaRmstVasc6/dY
TtwBrUDYFE4HoG22ASPjTAeLsIFTkRvPLTYQnGvF7yeKxmCTyd4tlarzKBHTPVcx
7/HpbgPW43yP3kr0FHbH
=ycaC
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
