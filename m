From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 14/19] OMAP2+: voltage: split voltage controller (VC)
 code into dedicated layer
Date: Fri, 25 Mar 2011 10:26:12 +0100
Message-ID: <AANLkTinDbAbhSNMNgTGGWyOGxOUJb4CF24bjHKNDe4nW@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-15-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39642 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab1CYJ0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:26:13 -0400
Received: by qyk7 with SMTP id 7so5894021qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:26:13 -0700 (PDT)
In-Reply-To: <1300924833-26745-15-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> As part of the voltage layer cleanup, split out VC specific code into
> a dedicated VC layer. =A0This patch primarily just moves VC code from
> voltage.c into vc.c, and adds prototypes to vc.h.
>
> No functional changes.
>
> For readability, cach function was given a local 'vc' pointer:
s/cach/each

>
> =A0 =A0struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_data;
>
> and a global replace of s/vdd->vc_data/vc/ was done.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0| =A0276 +++++++++++++++++++++=
++++++++++++++++++++
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0| =A0 12 ++
> =A0arch/arm/mach-omap2/voltage.c | =A0262 +--------------------------=
------------
> =A04 files changed, 292 insertions(+), 260 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/vc.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index ce2105c..a0d8f61 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -90,7 +90,7 @@ obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D prcm.o cm2xxx_3xxx.o cminst44xx.o \
>
> =A0# OMAP voltage domains
> =A0ifeq ($(CONFIG_PM),y)
> -voltagedomain-common =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D voltag=
e.o
> +voltagedomain-common =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D voltag=
e.o vc.o
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(voltag=
edomain-common) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 voltagedomains2xxx_data.o
> =A0obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D $(voltag=
edomain-common) \
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> new file mode 100644
> index 0000000..4e65fdc
> --- /dev/null
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -0,0 +1,276 @@
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +
> +#include <plat/cpu.h>
> +
> +#include "voltage.h"
> +#include "vc.h"
> +#include "prm-regbits-34xx.h"
> +#include "prm-regbits-44xx.h"
> +#include "prm44xx.h"
> +
> +/* Voltage scale and accessory APIs */
> +int omap_vc_pre_scale(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *target_vsel, u8 *curren=
t_vsel)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 struct omap_volt_data *volt_data;
> + =A0 =A0 =A0 const struct omap_vc_common_data *vc_common;
> + =A0 =A0 =A0 const struct omap_vp_common_data *vp_common;
> + =A0 =A0 =A0 u32 vc_cmdval, vp_errgain_val;
> +
> + =A0 =A0 =A0 vc_common =3D vc->vc_common;
> + =A0 =A0 =A0 vp_common =3D vdd->vp_data->vp_common;
> +
> + =A0 =A0 =A0 /* Check if suffiecient pmic info is available for this=
 vdd */
Typo

> + =A0 =A0 =A0 if (!vdd->pmic_info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Insufficient pmic info to s=
cale the vdd_%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!vdd->pmic_info->uv_to_vsel) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PMIC function to convert vo=
ltage in uV to"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vsel not registered. H=
ence unable to scale voltage"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for vdd_%s\n", __func_=
_, voltdm->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!vdd->read_reg || !vdd->write_reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No read/write API for acces=
sing vdd_%s regs\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Get volt_data corresponding to target_volt */
> + =A0 =A0 =A0 volt_data =3D omap_voltage_get_voltdata(voltdm, target_=
volt);
> + =A0 =A0 =A0 if (IS_ERR(volt_data))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt_data =3D NULL;
> +
> + =A0 =A0 =A0 *target_vsel =3D vdd->pmic_info->uv_to_vsel(target_volt=
);
> + =A0 =A0 =A0 *current_vsel =3D vdd->read_reg(vdd->vp_data->vp_common=
->prm_mod, vdd->vp_data->voltage);
> +
> + =A0 =A0 =A0 /* Setting the ON voltage to the new target voltage */
> + =A0 =A0 =A0 vc_cmdval =3D vdd->read_reg(vc->vc_common->prm_mod, vc-=
>cmdval_reg);
> + =A0 =A0 =A0 vc_cmdval &=3D ~vc_common->cmd_on_mask;
> + =A0 =A0 =A0 vc_cmdval |=3D (*target_vsel << vc_common->cmd_on_shift=
);
> + =A0 =A0 =A0 vdd->write_reg(vc_cmdval, vc->vc_common->prm_mod, vc->c=
mdval_reg);
> +
> + =A0 =A0 =A0 /* Setting vp errorgain based on the voltage */
> + =A0 =A0 =A0 if (volt_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val =3D vdd->read_reg(vdd->v=
p_data->vp_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_data->vpconfig);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_rt_data.vpconfig_errorgain =3D =
volt_data->vp_errgain;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val &=3D ~vp_common->vpconfi=
g_errorgain_mask;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val |=3D vdd->vp_rt_data.vpc=
onfig_errorgain <<
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_common->vpconfig_err=
orgain_shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->write_reg(vp_errgain_val, vdd->vp_=
data->vp_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_=
data->vpconfig);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +void omap_vc_post_scale(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_vo=
lt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 target_vsel, u8 curr=
ent_vsel)
> +{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 u32 smps_steps =3D 0, smps_delay =3D 0;
> +
> + =A0 =A0 =A0 smps_steps =3D abs(target_vsel - current_vsel);
> + =A0 =A0 =A0 /* SMPS slew rate / step size. 2us added as buffer. */
> + =A0 =A0 =A0 smps_delay =3D ((smps_steps * vdd->pmic_info->step_size=
) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->pmic_info->slew_ra=
te) + 2;
> + =A0 =A0 =A0 udelay(smps_delay);
> +
> + =A0 =A0 =A0 vdd->curr_volt =3D target_volt;
> +}
> +
> +/* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
> +int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsi=
gned long target_volt)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 u32 loop_cnt =3D 0, retries_cnt =3D 0;
> + =A0 =A0 =A0 u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
> + =A0 =A0 =A0 u8 target_vsel, current_vsel;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D omap_vc_pre_scale(voltdm, target_volt, &target_=
vsel, &current_vsel);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 vc_valid =3D vc->vc_common->valid;
> + =A0 =A0 =A0 vc_bypass_val_reg =3D vc->vc_common->bypass_val_reg;
> + =A0 =A0 =A0 vc_bypass_value =3D (target_vsel << vc->vc_common->data=
_shift) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vdd->pmic_info->pmic_r=
eg <<
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->vc_common->regaddr_=
shift) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vdd->pmic_info->i2c_sl=
ave_addr <<
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->vc_common->slaveadd=
r_shift);
> +
> + =A0 =A0 =A0 vdd->write_reg(vc_bypass_value, vc->vc_common->prm_mod,=
 vc_bypass_val_reg);
> + =A0 =A0 =A0 vdd->write_reg(vc_bypass_value | vc_valid, vc->vc_commo=
n->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc_bypass_val_reg);
> +
> + =A0 =A0 =A0 vc_bypass_value =3D vdd->read_reg(vc->vc_common->prm_mo=
d, vc_bypass_val_reg);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Loop till the bypass command is acknowledged from =
the SMPS.
> + =A0 =A0 =A0 =A0* NOTE: This is legacy code. The loop count and retr=
y count needs
> + =A0 =A0 =A0 =A0* to be revisited.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 while (!(vc_bypass_value & vc_valid)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 loop_cnt++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retries_cnt > 10) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Retry c=
ount exceeded\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loop_cnt > 50) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retries_cnt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loop_cnt =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc_bypass_value =3D vdd->read_reg(vc->v=
c_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vc_bypass_val_reg);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_vc_post_scale(voltdm, target_volt, target_vsel, cu=
rrent_vsel);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Voltage Manager FSM parameters init
> + =A0 =A0 =A0 =A0* XXX This data should be passed in from the board f=
ile
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vdd->write_reg(OMAP3_CLKSETUP, vc->vc_common->prm_mod, =
OMAP3_PRM_CLKSETUP_OFFSET);
> + =A0 =A0 =A0 vdd->write_reg(OMAP3_VOLTOFFSET, vc->vc_common->prm_mod=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_PRM_VOLTOFFSET_OFF=
SET);
> + =A0 =A0 =A0 vdd->write_reg(OMAP3_VOLTSETUP2, vc->vc_common->prm_mod=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_PRM_VOLTSETUP2_OFF=
SET);
> +}
> +
> +static void __init omap3_vc_init(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 static bool is_initialized;
> + =A0 =A0 =A0 u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
> + =A0 =A0 =A0 u32 vc_val;
> +
> + =A0 =A0 =A0 if (is_initialized)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* Set up the on, inactive, retention and off voltage *=
/
> + =A0 =A0 =A0 on_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info->=
on_volt);
> + =A0 =A0 =A0 onlp_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info=
->onlp_volt);
> + =A0 =A0 =A0 ret_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info-=
>ret_volt);
> + =A0 =A0 =A0 off_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info-=
>off_volt);
> + =A0 =A0 =A0 vc_val =A0=3D ((on_vsel << vc->vc_common->cmd_on_shift)=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (onlp_vsel << vc->vc_common->cmd_onlp_s=
hift) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ret_vsel << vc->vc_common->cmd_ret_shi=
ft) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (off_vsel << vc->vc_common->cmd_off_shi=
ft));
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod, vc->cmdv=
al_reg);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Generic VC parameters init
> + =A0 =A0 =A0 =A0* XXX This data should be abstracted out
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vdd->write_reg(OMAP3430_CMD1_MASK | OMAP3430_RAV1_MASK,=
 vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VC_CH_CONF_OF=
=46SET);
> + =A0 =A0 =A0 vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MAS=
K, vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VC_I2C_CFG_OF=
=46SET);
> +
> + =A0 =A0 =A0 omap3_vfsm_init(voltdm);
> +
> + =A0 =A0 =A0 is_initialized =3D true;
> +}
> +
> +
> +/* OMAP4 specific voltage init functions */
> +static void __init omap4_vc_init(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 static bool is_initialized;
> + =A0 =A0 =A0 u32 vc_val;
> +
> + =A0 =A0 =A0 if (is_initialized)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* TODO: Configure setup times and CMD_VAL values*/
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Generic VC parameters init
> + =A0 =A0 =A0 =A0* XXX This data should be abstracted out
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vc_val =3D (OMAP4430_RAV_VDD_MPU_L_MASK | OMAP4430_CMD_=
VDD_MPU_L_MASK |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_RAV_VDD_IVA_L_MASK | OMAP4=
430_CMD_VDD_IVA_L_MASK |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_RAV_VDD_CORE_L_MASK | OMAP=
4430_CMD_VDD_CORE_L_MASK);
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod, OMAP4_PR=
M_VC_CFG_CHANNEL_OFFSET);
> +
> + =A0 =A0 =A0 /* XXX These are magic numbers and do not belong! */
> + =A0 =A0 =A0 vc_val =3D (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4=
430_SCLH_SHIFT);
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod, OMAP4_PR=
M_VC_CFG_I2C_CLK_OFFSET);
> +
> + =A0 =A0 =A0 is_initialized =3D true;
> +}
> +
> +void __init omap_vc_init(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_da=
ta;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> + =A0 =A0 =A0 u32 vc_val;
> +
> + =A0 =A0 =A0 if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PMIC info requried to confi=
gure vc for"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vdd_%s not populated.H=
ence cannot initialize vc\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!vdd->read_reg || !vdd->write_reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No read/write API for acces=
sing vdd_%s regs\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set up the SMPS_SA(i2c slave address in VC */
> + =A0 =A0 =A0 vc_val =3D vdd->read_reg(vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->vc_c=
ommon->smps_sa_reg);
> + =A0 =A0 =A0 vc_val &=3D ~vc->smps_sa_mask;
> + =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->i2c_slave_addr << vc->smps_=
sa_shift;
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->vc_common->smps_sa_r=
eg);
> +
> + =A0 =A0 =A0 /* Setup the VOLRA(pmic reg addr) in VC */
> + =A0 =A0 =A0 vc_val =3D vdd->read_reg(vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->vc_c=
ommon->smps_volra_reg);
> + =A0 =A0 =A0 vc_val &=3D ~vc->smps_volra_mask;
> + =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->pmic_reg << vc->smps_volra_=
shift;
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc->vc_common->smps_volr=
a_reg);
> +
> + =A0 =A0 =A0 /* Configure the setup times */
> + =A0 =A0 =A0 vc_val =3D vdd->read_reg(vc->vc_common->prm_mod, vdd->v=
fsm->voltsetup_reg);
> + =A0 =A0 =A0 vc_val &=3D ~vdd->vfsm->voltsetup_mask;
> + =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->volt_setup_time <<
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vfsm->voltsetup_sh=
ift;
> + =A0 =A0 =A0 vdd->write_reg(vc_val, vc->vc_common->prm_mod, vdd->vfs=
m->voltsetup_reg);
> +
> + =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_vc_init(voltdm);
> + =A0 =A0 =A0 else if (cpu_is_omap44xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vc_init(voltdm);
> +}
> +
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index f7338af..b823e5b 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -19,6 +19,8 @@
>
> =A0#include <linux/kernel.h>
>
> +struct voltagedomain;
> +
> =A0/**
> =A0* struct omap_vc_common_data - per-VC register/bitfield data
> =A0* @cmd_on_mask: ON bitmask in PRM_VC_CMD_VAL* register
> @@ -81,5 +83,15 @@ extern struct omap_vc_instance_data omap4_vc_mpu_d=
ata;
> =A0extern struct omap_vc_instance_data omap4_vc_iva_data;
> =A0extern struct omap_vc_instance_data omap4_vc_core_data;
>
> +void omap_vc_init(struct voltagedomain *voltdm);
> +int omap_vc_pre_scale(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *target_vsel, u8 *curren=
t_vsel);
> +void omap_vc_post_scale(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_vo=
lt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 target_vsel, u8 curr=
ent_vsel);
> +int omap_vc_bypass_scale_voltage(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsi=
gned long target_volt);
> +
> =A0#endif
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index b1b5e38..8a47dd1 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -293,136 +293,6 @@ static void __init vdd_debugfs_init(struct volt=
agedomain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom_v=
olt_debug_fops);
> =A0}
>
> -/* Voltage scale and accessory APIs */
> -static int _pre_volt_scale(struct voltagedomain *voltdm,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt, u8 *target_v=
sel, u8 *current_vsel)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 struct omap_volt_data *volt_data;
> - =A0 =A0 =A0 const struct omap_vc_common_data *vc_common;
> - =A0 =A0 =A0 const struct omap_vp_common_data *vp_common;
> - =A0 =A0 =A0 u32 vc_cmdval, vp_errgain_val;
> -
> - =A0 =A0 =A0 vc_common =3D vdd->vc_data->vc_common;
> - =A0 =A0 =A0 vp_common =3D vdd->vp_data->vp_common;
> -
> - =A0 =A0 =A0 /* Check if suffiecient pmic info is available for this=
 vdd */
> - =A0 =A0 =A0 if (!vdd->pmic_info) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Insufficient pmic info to s=
cale the vdd_%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (!vdd->pmic_info->uv_to_vsel) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PMIC function to convert vo=
ltage in uV to"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vsel not registered. H=
ence unable to scale voltage"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for vdd_%s\n", __func_=
_, voltdm->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (!vdd->read_reg || !vdd->write_reg) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No read/write API for acces=
sing vdd_%s regs\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* Get volt_data corresponding to target_volt */
> - =A0 =A0 =A0 volt_data =3D omap_voltage_get_voltdata(voltdm, target_=
volt);
> - =A0 =A0 =A0 if (IS_ERR(volt_data))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt_data =3D NULL;
> -
> - =A0 =A0 =A0 *target_vsel =3D vdd->pmic_info->uv_to_vsel(target_volt=
);
> - =A0 =A0 =A0 *current_vsel =3D vdd->read_reg(vdd->vp_data->vp_common=
->prm_mod, vdd->vp_data->voltage);
> -
> - =A0 =A0 =A0 /* Setting the ON voltage to the new target voltage */
> - =A0 =A0 =A0 vc_cmdval =3D vdd->read_reg(vdd->vc_data->vc_common->pr=
m_mod, vdd->vc_data->cmdval_reg);
> - =A0 =A0 =A0 vc_cmdval &=3D ~vc_common->cmd_on_mask;
> - =A0 =A0 =A0 vc_cmdval |=3D (*target_vsel << vc_common->cmd_on_shift=
);
> - =A0 =A0 =A0 vdd->write_reg(vc_cmdval, vdd->vc_data->vc_common->prm_=
mod, vdd->vc_data->cmdval_reg);
> -
> - =A0 =A0 =A0 /* Setting vp errorgain based on the voltage */
> - =A0 =A0 =A0 if (volt_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val =3D vdd->read_reg(vdd->v=
p_data->vp_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_data->vpconfig);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vp_rt_data.vpconfig_errorgain =3D =
volt_data->vp_errgain;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val &=3D ~vp_common->vpconfi=
g_errorgain_mask;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_errgain_val |=3D vdd->vp_rt_data.vpc=
onfig_errorgain <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_common->vpconfig_err=
orgain_shift;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->write_reg(vp_errgain_val, vdd->vp_=
data->vp_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_=
data->vpconfig);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static void _post_volt_scale(struct voltagedomain *voltdm,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt, u8 target_vs=
el, u8 current_vsel)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 u32 smps_steps =3D 0, smps_delay =3D 0;
> -
> - =A0 =A0 =A0 smps_steps =3D abs(target_vsel - current_vsel);
> - =A0 =A0 =A0 /* SMPS slew rate / step size. 2us added as buffer. */
> - =A0 =A0 =A0 smps_delay =3D ((smps_steps * vdd->pmic_info->step_size=
) /
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->pmic_info->slew_ra=
te) + 2;
> - =A0 =A0 =A0 udelay(smps_delay);
> -
> - =A0 =A0 =A0 vdd->curr_volt =3D target_volt;
> -}
> -
> -/* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
> -static int vc_bypass_scale_voltage(struct voltagedomain *voltdm,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long target_volt)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 u32 loop_cnt =3D 0, retries_cnt =3D 0;
> - =A0 =A0 =A0 u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
> - =A0 =A0 =A0 u8 target_vsel, current_vsel;
> - =A0 =A0 =A0 int ret;
> -
> - =A0 =A0 =A0 ret =3D _pre_volt_scale(voltdm, target_volt, &target_vs=
el, &current_vsel);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 vc_valid =3D vdd->vc_data->vc_common->valid;
> - =A0 =A0 =A0 vc_bypass_val_reg =3D vdd->vc_data->vc_common->bypass_v=
al_reg;
> - =A0 =A0 =A0 vc_bypass_value =3D (target_vsel << vdd->vc_data->vc_co=
mmon->data_shift) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vdd->pmic_info->pmic_r=
eg <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vc_data->vc_common=
->regaddr_shift) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vdd->pmic_info->i2c_sl=
ave_addr <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vc_data->vc_common=
->slaveaddr_shift);
> -
> - =A0 =A0 =A0 vdd->write_reg(vc_bypass_value, vdd->vc_data->vc_common=
->prm_mod, vc_bypass_val_reg);
> - =A0 =A0 =A0 vdd->write_reg(vc_bypass_value | vc_valid, vdd->vc_data=
->vc_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc_bypass_val_reg);
> -
> - =A0 =A0 =A0 vc_bypass_value =3D vdd->read_reg(vdd->vc_data->vc_comm=
on->prm_mod, vc_bypass_val_reg);
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Loop till the bypass command is acknowledged from =
the SMPS.
> - =A0 =A0 =A0 =A0* NOTE: This is legacy code. The loop count and retr=
y count needs
> - =A0 =A0 =A0 =A0* to be revisited.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 while (!(vc_bypass_value & vc_valid)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 loop_cnt++;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retries_cnt > 10) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Retry c=
ount exceeded\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (loop_cnt > 50) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retries_cnt++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loop_cnt =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc_bypass_value =3D vdd->read_reg(vdd->=
vc_data->vc_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vc_bypass_val_reg);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 _post_volt_scale(voltdm, target_volt, target_vsel, curr=
ent_vsel);
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0/* VP force update method of voltage scaling */
> =A0static int vp_forceupdate_scale_voltage(struct voltagedomain *volt=
dm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt)
> @@ -432,7 +302,7 @@ static int vp_forceupdate_scale_voltage(struct vo=
ltagedomain *voltdm,
> =A0 =A0 =A0 =A0u8 target_vsel, current_vsel;
> =A0 =A0 =A0 =A0int ret, timeout =3D 0;
>
> - =A0 =A0 =A0 ret =3D _pre_volt_scale(voltdm, target_volt, &target_vs=
el, &current_vsel);
> + =A0 =A0 =A0 ret =3D omap_vc_pre_scale(voltdm, target_volt, &target_=
vsel, &current_vsel);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> @@ -485,7 +355,7 @@ static int vp_forceupdate_scale_voltage(struct vo=
ltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"TRANXDONE never got s=
et after the voltage update\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->name=
);
>
> - =A0 =A0 =A0 _post_volt_scale(voltdm, target_volt, target_vsel, curr=
ent_vsel);
> + =A0 =A0 =A0 omap_vc_post_scale(voltdm, target_volt, target_vsel, cu=
rrent_vsel);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Disable TransactionDone interrupt , clear all statu=
s, clear
> @@ -517,132 +387,6 @@ static int vp_forceupdate_scale_voltage(struct =
voltagedomain *voltdm,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Voltage Manager FSM parameters init
> - =A0 =A0 =A0 =A0* XXX This data should be passed in from the board f=
ile
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 vdd->write_reg(OMAP3_CLKSETUP, vdd->vc_data->vc_common-=
>prm_mod, OMAP3_PRM_CLKSETUP_OFFSET);
> - =A0 =A0 =A0 vdd->write_reg(OMAP3_VOLTOFFSET, vdd->vc_data->vc_commo=
n->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_PRM_VOLTOFFSET_OFF=
SET);
> - =A0 =A0 =A0 vdd->write_reg(OMAP3_VOLTSETUP2, vdd->vc_data->vc_commo=
n->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_PRM_VOLTSETUP2_OFF=
SET);
> -}
> -
> -static void __init omap3_vc_init(struct voltagedomain *voltdm)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 static bool is_initialized;
> - =A0 =A0 =A0 u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
> - =A0 =A0 =A0 u32 vc_val;
> -
> - =A0 =A0 =A0 if (is_initialized)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 /* Set up the on, inactive, retention and off voltage *=
/
> - =A0 =A0 =A0 on_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info->=
on_volt);
> - =A0 =A0 =A0 onlp_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info=
->onlp_volt);
> - =A0 =A0 =A0 ret_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info-=
>ret_volt);
> - =A0 =A0 =A0 off_vsel =3D vdd->pmic_info->uv_to_vsel(vdd->pmic_info-=
>off_volt);
> - =A0 =A0 =A0 vc_val =A0=3D ((on_vsel << vdd->vc_data->vc_common->cmd=
_on_shift) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (onlp_vsel << vdd->vc_data->vc_common->=
cmd_onlp_shift) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ret_vsel << vdd->vc_data->vc_common->c=
md_ret_shift) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (off_vsel << vdd->vc_data->vc_common->c=
md_off_shift));
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
, vdd->vc_data->cmdval_reg);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Generic VC parameters init
> - =A0 =A0 =A0 =A0* XXX This data should be abstracted out
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 vdd->write_reg(OMAP3430_CMD1_MASK | OMAP3430_RAV1_MASK,=
 vdd->vc_data->vc_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VC_CH_CONF_OF=
=46SET);
> - =A0 =A0 =A0 vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MAS=
K, vdd->vc_data->vc_common->prm_mod,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VC_I2C_CFG_OF=
=46SET);
> -
> - =A0 =A0 =A0 omap3_vfsm_init(voltdm);
> -
> - =A0 =A0 =A0 is_initialized =3D true;
> -}
> -
> -
> -/* OMAP4 specific voltage init functions */
> -static void __init omap4_vc_init(struct voltagedomain *voltdm)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 static bool is_initialized;
> - =A0 =A0 =A0 u32 vc_val;
> -
> - =A0 =A0 =A0 if (is_initialized)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 /* TODO: Configure setup times and CMD_VAL values*/
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Generic VC parameters init
> - =A0 =A0 =A0 =A0* XXX This data should be abstracted out
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 vc_val =3D (OMAP4430_RAV_VDD_MPU_L_MASK | OMAP4430_CMD_=
VDD_MPU_L_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_RAV_VDD_IVA_L_MASK | OMAP4=
430_CMD_VDD_IVA_L_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_RAV_VDD_CORE_L_MASK | OMAP=
4430_CMD_VDD_CORE_L_MASK);
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
, OMAP4_PRM_VC_CFG_CHANNEL_OFFSET);
> -
> - =A0 =A0 =A0 /* XXX These are magic numbers and do not belong! */
> - =A0 =A0 =A0 vc_val =3D (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP4=
430_SCLH_SHIFT);
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
> -
> - =A0 =A0 =A0 is_initialized =3D true;
> -}
> -
> -static void __init omap_vc_init(struct voltagedomain *voltdm)
> -{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> - =A0 =A0 =A0 u32 vc_val;
> -
> - =A0 =A0 =A0 if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PMIC info requried to confi=
gure vc for"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vdd_%s not populated.H=
ence cannot initialize vc\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (!vdd->read_reg || !vdd->write_reg) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No read/write API for acces=
sing vdd_%s regs\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* Set up the SMPS_SA(i2c slave address in VC */
> - =A0 =A0 =A0 vc_val =3D vdd->read_reg(vdd->vc_data->vc_common->prm_m=
od,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_=
data->vc_common->smps_sa_reg);
> - =A0 =A0 =A0 vc_val &=3D ~vdd->vc_data->smps_sa_mask;
> - =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->i2c_slave_addr << vdd->vc_d=
ata->smps_sa_shift;
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_data->vc_common-=
>smps_sa_reg);
> -
> - =A0 =A0 =A0 /* Setup the VOLRA(pmic reg addr) in VC */
> - =A0 =A0 =A0 vc_val =3D vdd->read_reg(vdd->vc_data->vc_common->prm_m=
od,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_=
data->vc_common->smps_volra_reg);
> - =A0 =A0 =A0 vc_val &=3D ~vdd->vc_data->smps_volra_mask;
> - =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->pmic_reg << vdd->vc_data->s=
mps_volra_shift;
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_data->vc_common-=
>smps_volra_reg);
> -
> - =A0 =A0 =A0 /* Configure the setup times */
> - =A0 =A0 =A0 vc_val =3D vdd->read_reg(vdd->vc_data->vc_common->prm_m=
od, vdd->vfsm->voltsetup_reg);
> - =A0 =A0 =A0 vc_val &=3D ~vdd->vfsm->voltsetup_mask;
> - =A0 =A0 =A0 vc_val |=3D vdd->pmic_info->volt_setup_time <<
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->vfsm->voltsetup_sh=
ift;
> - =A0 =A0 =A0 vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mod=
, vdd->vfsm->voltsetup_reg);
> -
> - =A0 =A0 =A0 if (cpu_is_omap34xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_vc_init(voltdm);
> - =A0 =A0 =A0 else if (cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vc_init(voltdm);
> -}
> -
> =A0static int __init omap_vdd_data_configure(struct voltagedomain *vo=
ltdm)
> =A0{
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd =3D voltdm->vdd;
> @@ -1025,7 +769,7 @@ void omap_change_voltscale_method(struct voltage=
domain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_scale =3D vp_forceupdate_sca=
le_voltage;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0case VOLTSCALE_VCBYPASS:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->volt_scale =3D vc_bypass_scale_vol=
tage;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->volt_scale =3D omap_vc_bypass_scal=
e_voltage;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Trying to change the m=
ethod of voltage scaling"
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
