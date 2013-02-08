From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in
 pm_late_init()
Date: Fri, 8 Feb 2013 17:20:15 +0200
Message-ID: <20130208152015.GH23979@arwen.pp.htv.fi>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48303 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946062Ab3BHPU2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:20:28 -0500
Content-Disposition: inline
In-Reply-To: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2013 at 08:41:44PM +0530, Santosh Shilimkar wrote:
> Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
> across OMAP2, 3, 4} moved suspend code to common place but now with
> that change, for DT build on OMAP4, suspend hooks are not getting
> registered which results in no suspend support.
>=20
> The DT return condition is limited to PMIC and smartreflex
> initialization and hence restrict it so that suspend ops gets
> registered.
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

makes sense to me, we still need to set the global suspend_ops pointer
to something valid in DT boots:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/pm.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index f4b3143..1ec4299 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -345,19 +345,19 @@ int __init omap2_common_pm_late_init(void)
>  	 * a completely different mechanism.
>  	 * Disable this part if a DT blob is available.
>  	 */
> -	if (of_have_populated_dt())
> -		return 0;
> +	if (!of_have_populated_dt()) {
> =20
> -	/* Init the voltage layer */
> -	omap_pmic_late_init();
> -	omap_voltage_late_init();
> +		/* Init the voltage layer */
> +		omap_pmic_late_init();
> +		omap_voltage_late_init();
> =20
> -	/* Initialize the voltages */
> -	omap3_init_voltages();
> -	omap4_init_voltages();
> +		/* Initialize the voltages */
> +		omap3_init_voltages();
> +		omap4_init_voltages();
> =20
> -	/* Smartreflex device init */
> -	omap_devinit_smartreflex();
> +		/* Smartreflex device init */
> +		omap_devinit_smartreflex();
> +	}
> =20
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFReuAAoJEIaOsuA1yqREgiwQAI+iHj0bPnqulCkV5go4J5bS
nw6pdt5O5KAsN/AqZllpYOatFUo+B9gjGo1YnTopg5oAMNdv0VVylN3YeTJrnKHA
T7xZTacnt/D3OksZfc9/3r4OwN0Zc/ROx8xcJxAmXbid7hud3SOeSIHhPI0OUltJ
AIuMtiPXCmF/+8ivTX40FyFg9z8ea9CXnG1zITdvYb+XVzCrdIFPu7RPMuix294t
EMdTfNZ929RexSA8i/W4qAFSaWVU4+wgLEngcd+3bvfFa6KPqjn0UPZX/ztNR+UW
fOu3JIkpVFozyi2Yh5xRgokFWAWs7F2Sfs3UzLJLm9byBaRXT8dA3QxpL4nNsr34
t0/lGcBYRsTOxBuINS5wQuZ/w9eQlNrJNbelJe7/N/lI8iXQoI82YjBguqSQ3Yp3
SDjCZF9oZOaPuU4IcMXC08w+CVngLVS1vnQDi7hunLrZnwMKulTcR/mwUTVv7b0N
vIhs4z4hHNWcjft9qD/59XRyzoajsSPexNp2sJggJdo8xuz7PTyJSTUVJReN5UWv
IRccHOtpCkkOADTvCiHP36BPzw732LtTA6yqDELVFF8qP18iogMlDfTaCwiHy5jr
pHGZ+jHoKzgME02xTpJqzd7+fNhTpvLn6BcMxX1N4loTfoqfDvsRwX+KxNN2b1dp
LdCrKNivp+nX+5xPg7f1
=8Sqd
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
