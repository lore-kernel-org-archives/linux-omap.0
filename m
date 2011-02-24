From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 06/19] omap3+: voltage: use volt_data pointer instead values
Date: Thu, 24 Feb 2011 10:58:55 +0530
Message-ID: <AANLkTik8=zPKU9UNVij-VxXui4kCtN2fqNCGs_dM7E+i@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37356 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057Ab1BXF25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 00:28:57 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so907438bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 21:28:56 -0800 (PST)
In-Reply-To: <1298116918-30744-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Hi,

On Sat, Feb 19, 2011 at 5:31 PM, Nishanth Menon <nm@ti.com> wrote:
> Voltage values can get confusing in meaning with various Smartreflex
> classes being active. Depending on the class used, the actual voltage
> selected might be a variant. Hence pass the volt_data pointers throug=
h
> the structure. Each voltage domain contains a set of volt_data struct=
s.
> Each of those volt_data struct represents a voltage point that is sup=
ported
> for that domain. Hence, this is a more accurate representation of the
> voltage point we are interested in going to, and the actual translati=
on
> of this voltage point to the voltage value is done inside the voltage=
 layer
> which allows the users of the voltage layer to be blissfully ignorant
> of any complexity of the underneath layers.
Volt_data has efuse, Errgain and errminlimit other than nom_volt
How does this data differs in different SR Class implementation which
is why using volt_data is required?
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 +-
> =A0arch/arm/mach-omap2/smartreflex-class3.c =A0| =A0 =A03 +-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 72 +++=
++++++++++++--------------
> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 13 ++++-
> =A04 files changed, 53 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..669998b 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -209,7 +209,8 @@ static int __init omap2_set_init_voltage(char *vd=
d_name, char *clk_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap_voltage_scale_vdd(voltdm, bootup_volt);
> + =A0 =A0 =A0 omap_voltage_scale_vdd(voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_get_voltda=
ta(voltdm, bootup_volt));
> =A0 =A0 =A0 =A0return 0;
>
> =A0exit:
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach=
-omap2/smartreflex-class3.c
> index 60e7055..2195668 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -15,7 +15,8 @@
>
> =A0static int sr_class3_enable(struct voltagedomain *voltdm)
> =A0{
> - =A0 =A0 =A0 unsigned long volt =3D omap_voltage_get_nom_volt(voltdm=
);
> + =A0 =A0 =A0 unsigned long volt =3D omap_get_operation_voltage(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_get_nom_volt(voltdm));
>
> =A0 =A0 =A0 =A0if (!volt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Curr voltage unknown. =
Cannot enable sr_%s\n",
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 3ee8a80..08f0abf 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -146,14 +146,14 @@ struct omap_vdd_info {
> =A0 =A0 =A0 =A0struct vc_reg_info vc_reg;
> =A0 =A0 =A0 =A0struct voltagedomain voltdm;
> =A0 =A0 =A0 =A0struct dentry *debug_dir;
> - =A0 =A0 =A0 u32 curr_volt;
> + =A0 =A0 =A0 struct omap_volt_data *curr_volt;
> =A0 =A0 =A0 =A0u16 ocp_mod;
> =A0 =A0 =A0 =A0u8 prm_irqst_reg;
> =A0 =A0 =A0 =A0bool vp_enabled;
> =A0 =A0 =A0 =A0u32 (*read_reg) (u16 mod, u8 offset);
> =A0 =A0 =A0 =A0void (*write_reg) (u32 val, u16 mod, u8 offset);
> =A0 =A0 =A0 =A0int (*volt_scale) (struct omap_vdd_info *vdd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt);
> =A0};
>
> =A0static struct omap_vdd_info *vdd_info;
> @@ -361,13 +361,15 @@ static int vp_volt_debug_get(void *data, u64 *v=
al)
> =A0static int nom_volt_debug_get(void *data, u64 *val)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd =3D (struct omap_vdd_info *)=
 data;
> + =A0 =A0 =A0 struct omap_volt_data *volt_data;
>
> =A0 =A0 =A0 =A0if (!vdd) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Wrong paramater passed\n")=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 volt_data =3D omap_voltage_get_nom_volt(&vdd->voltdm);
>
> - =A0 =A0 =A0 *val =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> + =A0 =A0 =A0 *val =3D volt_data->volt_nominal;
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -382,7 +384,8 @@ static void vp_latch_vsel(struct omap_vdd_info *v=
dd)
> =A0 =A0 =A0 =A0unsigned long uvdc;
> =A0 =A0 =A0 =A0char vsel;
>
> - =A0 =A0 =A0 uvdc =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> + =A0 =A0 =A0 uvdc =3D omap_get_operation_voltage(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_get_nom_vo=
lt(&vdd->voltdm));
> =A0 =A0 =A0 =A0if (!uvdc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: unable to find current=
 voltage for vdd_%s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd->voltdm.=
name);
> @@ -505,12 +508,18 @@ static void __init vdd_debugfs_init(struct omap=
_vdd_info *vdd)
>
> =A0/* Voltage scale and accessory APIs */
> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt, u8 *target_v=
sel, u8 *current_vsel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt, u8 =
*target_vsel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *current_vsel)
> =A0{
> - =A0 =A0 =A0 struct omap_volt_data *volt_data;
> =A0 =A0 =A0 =A0u32 vc_cmdval, vp_errgain_val;
> =A0 =A0 =A0 =A0u16 vp_mod, vc_mod;
>
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(target_volt) || IS_ERR_OR_NULL(vdd) =
||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !target_vsel || !curren=
t_vsel) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: invalid parms!\n", __func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Check if suffiecient pmic info is available for thi=
s vdd */
> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Insufficient pmic info to =
scale the vdd_%s\n",
> @@ -534,12 +543,8 @@ static int _pre_volt_scale(struct omap_vdd_info =
*vdd,
> =A0 =A0 =A0 =A0vp_mod =3D vdd->vp_reg.prm_mod;
> =A0 =A0 =A0 =A0vc_mod =3D vdd->vc_reg.prm_mod;
>
> - =A0 =A0 =A0 /* Get volt_data corresponding to target_volt */
> - =A0 =A0 =A0 volt_data =3D omap_voltage_get_voltdata(&vdd->voltdm, t=
arget_volt);
> - =A0 =A0 =A0 if (IS_ERR(volt_data))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt_data =3D NULL;
> -
> - =A0 =A0 =A0 *target_vsel =3D vdd->pmic_info->uv_to_vsel(target_volt=
);
> + =A0 =A0 =A0 *target_vsel =3D vdd->pmic_info->uv_to_vsel(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_get_operation_volt=
age(target_volt));
> =A0 =A0 =A0 =A0*current_vsel =3D vdd->read_reg(vp_mod, vdd->vp_offs.v=
oltage);
>
> =A0 =A0 =A0 =A0/* Setting the ON voltage to the new target voltage */
> @@ -549,22 +554,21 @@ static int _pre_volt_scale(struct omap_vdd_info=
 *vdd,
> =A0 =A0 =A0 =A0vdd->write_reg(vc_cmdval, vc_mod, vdd->vc_reg.cmdval_r=
eg);
>
> =A0 =A0 =A0 =A0/* Setting vp errorgain based on the voltage */
> - =A0 =A0 =A0 if (volt_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val =3D vdd->read_reg(vp_mod=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp=
_offs.vpconfig);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_reg.vpconfig_errorgain =3D volt=
_data->vp_errgain;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val &=3D ~vdd->vp_reg.vpconf=
ig_errorgain_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val |=3D vdd->vp_reg.vpconfi=
g_errorgain <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp=
_reg.vpconfig_errorgain_shift;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->write_reg(vp_errgain_val, vp_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp=
_offs.vpconfig);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 vp_errgain_val =3D vdd->read_reg(vp_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_offs.vpconfig);
> + =A0 =A0 =A0 vdd->vp_reg.vpconfig_errorgain =3D target_volt->vp_errg=
ain;
> + =A0 =A0 =A0 vp_errgain_val &=3D ~vdd->vp_reg.vpconfig_errorgain_mas=
k;
> + =A0 =A0 =A0 vp_errgain_val |=3D vdd->vp_reg.vpconfig_errorgain <<
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_reg.vpconfig_er=
rorgain_shift;
> + =A0 =A0 =A0 vdd->write_reg(vp_errgain_val, vp_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_offs.vpconfig);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static void _post_volt_scale(struct omap_vdd_info *vdd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt, u8 target_vs=
el, u8 current_vsel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt, u8 =
target_vsel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 current_vsel)
> =A0{
> =A0 =A0 =A0 =A0u32 smps_steps =3D 0, smps_delay =3D 0;
>
> @@ -579,7 +583,7 @@ static void _post_volt_scale(struct omap_vdd_info=
 *vdd,
>
> =A0/* vc_bypass_scale_voltage - VC bypass method of voltage scaling *=
/
> =A0static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt)
> =A0{
> =A0 =A0 =A0 =A0u32 loop_cnt =3D 0, retries_cnt =3D 0;
> =A0 =A0 =A0 =A0u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
> @@ -632,7 +636,7 @@ static int vc_bypass_scale_voltage(struct omap_vd=
d_info *vdd,
>
> =A0/* VP force update method of voltage scaling */
> =A0static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt)
> =A0{
> =A0 =A0 =A0 =A0u32 vpconfig;
> =A0 =A0 =A0 =A0u16 mod, ocp_mod;
> @@ -1118,16 +1122,15 @@ static int __init omap4_vdd_data_configure(st=
ruct omap_vdd_info *vdd)
> =A0* omap_voltage_get_nom_volt() - Gets the current non-auto-compensa=
ted voltage
> =A0* @voltdm: =A0 =A0pointer to the VDD for which current voltage inf=
o is needed
> =A0*
> - * API to get the current non-auto-compensated voltage for a VDD.
> - * Returns 0 in case of error else returns the current voltage for t=
he VDD.
> + * API to get the current non-auto-compensated voltage data pointer =
for a VDD.
> =A0*/
> -unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm=
)
> +struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomai=
n *voltdm)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
>
> =A0 =A0 =A0 =A0if (IS_ERR_OR_NULL(voltdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: VDD specified does not=
 exist!\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENODATA);
> =A0 =A0 =A0 =A0}
The change to return volt_data instead of nominal voltage in function
definition is not there.
Am I missing something?
>
> =A0 =A0 =A0 =A0vdd =3D container_of(voltdm, struct omap_vdd_info, vol=
tdm);
> @@ -1269,18 +1272,19 @@ void omap_vp_disable(struct voltagedomain *vo=
ltdm)
> =A0* omap_voltage_scale_vdd() - API to scale voltage of a particular
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltage =
domain.
> =A0* @voltdm: =A0 =A0pointer to the VDD which is to be scaled.
> - * @target_volt: =A0 =A0 =A0 The target voltage of the voltage domai=
n
> + * @target_volt: =A0 =A0 =A0 The target voltage data for the voltage=
 domain
> =A0*
> =A0* This API should be called by the kernel to do the voltage scalin=
g
> =A0* for a particular voltage domain during dvfs or any other situati=
on.
> =A0*/
> =A0int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
>
> - =A0 =A0 =A0 if (!voltdm || IS_ERR(voltdm)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: VDD specified does not =
exist!\n", __func__);
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(target_vol=
t)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Bad Params vdm=3D%p tv=3D=
%p!\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm,=
 target_volt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> @@ -1306,7 +1310,7 @@ int omap_voltage_scale_vdd(struct voltagedomain=
 *voltdm,
> =A0*/
> =A0void omap_voltage_reset(struct voltagedomain *voltdm)
> =A0{
> - =A0 =A0 =A0 unsigned long target_uvdc;
> + =A0 =A0 =A0 struct omap_volt_data *target_uvdc;
>
> =A0 =A0 =A0 =A0if (IS_ERR_OR_NULL(voltdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: VDD specified does not=
 exist!\n", __func__);
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pla=
t-omap/include/plat/voltage.h
> index 5bd204e..52df49f 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -117,13 +117,13 @@ unsigned long omap_vp_get_curr_volt(struct volt=
agedomain *voltdm);
> =A0void omap_vp_enable(struct voltagedomain *voltdm);
> =A0void omap_vp_disable(struct voltagedomain *voltdm);
> =A0int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *target_volt);
> =A0void omap_voltage_reset(struct voltagedomain *voltdm);
> =A0void omap_voltage_get_volttable(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_data **volt_data);
> =A0struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedom=
ain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long volt);
> -unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm=
);
> +struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomai=
n *voltdm);
> =A0struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltd=
m);
> =A0#ifdef CONFIG_PM
> =A0int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> @@ -152,4 +152,13 @@ static inline struct voltagedomain *omap_voltage=
_domain_lookup(char *name)
> =A0}
> =A0#endif
>
> +/* convert volt data to the voltage for the voltage data */
> +static inline unsigned long omap_get_operation_voltage(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *vdata)
> +{
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(vdata))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return vdata->volt_nominal;
> +}
> +
> =A0#endif
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
