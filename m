From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Tue, 26 Jul 2011 16:19:30 +0300
Message-ID: <20110726131929.GR32582@legolas.emea.dhcp.ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-6-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0244130012=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1299338962-5602-6-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============0244130012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GDLQamdgIxhPcIwq"
Content-Disposition: inline


--GDLQamdgIxhPcIwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 05, 2011 at 08:59:08PM +0530, Nishanth Menon wrote:
> Use IS_ERR_OR_NULL macro instead of !xyz || IS_ERR(xyz) usage.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 53c399f..76bcaee 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -682,7 +682,7 @@ unsigned long omap_voltage_get_nom_volt(struct voltag=
edomain *voltdm)
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return 0;
>  	}
> @@ -703,7 +703,7 @@ unsigned long omap_vp_get_curr_volt(struct voltagedom=
ain *voltdm)
>  	struct omap_vdd_info *vdd;
>  	u8 curr_vsel;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return 0;
>  	}
> @@ -738,7 +738,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
>  	struct omap_vdd_info *vdd;
>  	u32 vpconfig;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return;
>  	}
> @@ -776,7 +776,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  	u32 vpconfig;
>  	int timeout;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return;
>  	}
> @@ -829,7 +829,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *volt=
dm,
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return -EINVAL;
>  	}
> @@ -858,7 +858,7 @@ void omap_voltage_reset(struct voltagedomain *voltdm)
>  {
>  	unsigned long target_uvdc;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return;
>  	}
> @@ -890,7 +890,7 @@ void omap_voltage_get_volttable(struct voltagedomain =
*voltdm,
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return;
>  	}
> @@ -921,7 +921,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(stru=
ct voltagedomain *voltdm,
>  	struct omap_vdd_info *vdd;
>  	int i;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -959,7 +959,7 @@ int omap_voltage_register_pmic(struct voltagedomain *=
voltdm,
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return -EINVAL;
>  	}
> @@ -986,7 +986,7 @@ struct dentry *omap_voltage_get_dbgdir(struct voltage=
domain *voltdm)
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return NULL;
>  	}
> @@ -1011,7 +1011,7 @@ void omap_change_voltscale_method(struct voltagedom=
ain *voltdm,
>  {
>  	struct omap_vdd_info *vdd;
> =20
> -	if (!voltdm || IS_ERR(voltdm)) {
> +	if (IS_ERR_OR_NULL(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
>  		return;
>  	}
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--GDLQamdgIxhPcIwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLr7hAAoJEAv8Txj19kN1CGoH/2xFQg+TitoZgmHlqonq8+hM
ISdo3+cfpBchTB3pLj7a/tnwSPHbrVdRgcYAr8MBRv88TSAfZS01X3l4u7XedJKD
+pzxTbxfeC/ysiPNpnJY/aGlZxfaCyM2pyD43WOzz83BXzczP5juWeiXiCJFqOmx
81qwkXzNdegCUPwG5LQBJlQBsKOvqCtcnkDvtUlZ9AEfRuTuiyIzyiyD/7E2M4Ku
LhPgn1yfO2K5NAhX+nVVT7ethnJdX2VaTSkS59gApY79Puv/762NVkbuJrDu/GWA
lNspzoZVC8YJ7He3rR88LIuzlBwciTPw+gJiC9ehuhOkCO4WKec/QR1wGZuWOvQ=
=PqDn
-----END PGP SIGNATURE-----

--GDLQamdgIxhPcIwq--


--===============0244130012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0244130012==--
