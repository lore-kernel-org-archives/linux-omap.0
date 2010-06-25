From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PM-SR] [PATCH] OMAP: PM: Remove the usage of vdd id's.
Date: Fri, 25 Jun 2010 08:15:35 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C01335B64A9@dlee02.ent.ti.com>
References: <1277391768-3361-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab0FYNPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 09:15:38 -0400
In-Reply-To: <1277391768-3361-1-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

[Reply 2/2]
Gopinath, Thara had written, on 06/24/2010 10:02 AM, the following:
> This patch removes the usage of vdd and sr id alltogether.
[.. in reply 1/2 ..]
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index d289691..17a8e22 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -31,9 +31,9 @@
>  #include <plat/opp_twl_tps.h>
>  #include <plat/clock.h>
>  #include <plat/common.h>
> +#include <plat/voltage.h>
>
>  #include "prm-regbits-34xx.h"
> -#include "voltage.h"
>
>  #define VP_IDLE_TIMEOUT                200
>  #define VP_TRANXDONE_TIMEOUT   300
> @@ -114,8 +114,8 @@ struct omap_vdd_info{
>         struct vp_reg_val vp_reg;
>         struct clk *volt_clk;
>         struct device *opp_dev;
> +       struct omap_volt_domain volt_domain;

curious -> vdd_info contains pointer to voltage_domain? I am confused
with the data structure dependency here.
should'nt voltage_domain contain vdd_info and potentially vc_info as well?

>         int volt_data_count;
> -       int id;
>         unsigned long nominal_volt;
>         u8 cmdval_reg;
>         u8 vdd_sr_reg;
> @@ -126,29 +126,36 @@ static struct omap_vdd_info *vdd_info;
>   */
>  static int no_scalable_vdd;
>
> -/* OMAP3 VP register offsets and other definitions */
> -struct __init vp_reg_offs omap3_vp_offs[] = {
> -       /* VP1 */
> +/* OMAP3 VDD sturctures */
> +static struct omap_vdd_info omap3_vdd_info[] = {
>         {
> -               .vpconfig_reg = OMAP3_PRM_VP1_CONFIG_OFFSET,
> -               .vstepmin_reg = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
> -               .vstepmax_reg = OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
> -               .vlimitto_reg = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
> -               .status_reg = OMAP3_PRM_VP1_STATUS_OFFSET,
> -               .voltage_reg = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
> +               .vp_offs = {
> +                       .vpconfig_reg = OMAP3_PRM_VP1_CONFIG_OFFSET,
> +                       .vstepmin_reg = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
> +                       .vstepmax_reg = OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
> +                       .vlimitto_reg = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
> +                       .status_reg = OMAP3_PRM_VP1_STATUS_OFFSET,
> +                       .voltage_reg = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
curious - why is this not part of hwmod?
> +               },
> +               .volt_domain = {
> +                       .name = "mpu",
> +               },
>         },
> -       /* VP2 */
> -       {       .vpconfig_reg = OMAP3_PRM_VP2_CONFIG_OFFSET,
> -               .vstepmin_reg = OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
> -               .vstepmax_reg = OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
> -               .vlimitto_reg = OMAP3_PRM_VP2_VLIMITTO_OFFSET,
> -               .status_reg = OMAP3_PRM_VP2_STATUS_OFFSET,
> -               .voltage_reg = OMAP3_PRM_VP2_VOLTAGE_OFFSET,
> +       {
> +               .vp_offs = {
> +                       .vpconfig_reg = OMAP3_PRM_VP2_CONFIG_OFFSET,
> +                       .vstepmin_reg = OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
> +                       .vstepmax_reg = OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
> +                       .vlimitto_reg = OMAP3_PRM_VP2_VLIMITTO_OFFSET,
> +                       .status_reg = OMAP3_PRM_VP2_STATUS_OFFSET,
> +                       .voltage_reg = OMAP3_PRM_VP2_VOLTAGE_OFFSET,
curious - why is this not part of hwmod?

> +               },
> +               .volt_domain = {
> +                       .name = "core"
> +               },
>         },
>  };
> -
might be good to leave this EOL alone.

> -#define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vp_offs)
> -static struct omap_vdd_info omap3_vdd_info[OMAP3_NO_SCALABLE_VDD];
> +#define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
>
>  /* TODO: OMAP4 register offsets */
>
> @@ -228,15 +235,6 @@ static inline void voltage_write_reg(u8 offset, u32 value)
>         prm_write_mod_reg(value, volt_mod, offset);
>  }
>
> -static int check_voltage_domain(int vdd)
> -{
> -       if (cpu_is_omap34xx()) {
> -               if ((vdd == VDD1) || (vdd == VDD2))
> -                       return 0;
> -       }
> -       return -EINVAL;
> -}
> -
glad to see this go. thanks.

>  /* Voltage debugfs support */
>  #ifdef CONFIG_PM_DEBUG
>  static int vp_debug_get(void *data, u64 *val)
> @@ -261,10 +259,10 @@ static int vp_debug_set(void *data, u64 val)
>
>  static int vp_volt_debug_get(void *data, u64 *val)
>  {
> -       struct omap_vdd_info *info = (struct omap_vdd_info *) data;
> +       struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
ok paranoia tells me to do an unlikely check on val and data and check
if it is fine..

>         u8 vsel;
>
> -       vsel = voltage_read_reg(info->vp_offs.voltage_reg);
> +       vsel = voltage_read_reg(vdd->vp_offs.voltage_reg);
>         pr_notice("curr_vsel = %x\n", vsel);
>         *val = vsel * 12500 + 600000;
errr... definitely something which is pmic specific
>
> @@ -273,9 +271,9 @@ static int vp_volt_debug_get(void *data, u64 *val)
>
>  static int nom_volt_debug_get(void *data, u64 *val)
>  {
> -       struct omap_vdd_info *info = (struct omap_vdd_info *) data;
> +       struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
paranoia again here.
>
> -       *val = get_curr_voltage(info->id);
> +       *val = get_curr_voltage(&vdd->volt_domain);
>         return 0;
>  }
>
> @@ -285,32 +283,32 @@ DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NULL,
>                                                                 "%llu\n");
>  #endif
>
> -static void vp_latch_vsel(int vp_id)
> +static void vp_latch_vsel(struct omap_vdd_info *vdd)
>  {
>         u32 vpconfig;
>         unsigned long uvdc;
>         char vsel;
>
> -       uvdc = get_curr_voltage(vp_id);
> +       uvdc = get_curr_voltage(&vdd->volt_domain);
>         if (!uvdc) {
> -               pr_warning("%s: unable to find current voltage for VDD %d\n",
> -                       __func__, vp_id);
> +               pr_warning("%s: unable to find current voltage for vdd_%s\n",
> +                       __func__, vdd->volt_domain.name);
>                 return;
>         }
>         vsel = omap_twl_uv_to_vsel(uvdc);
> -       vpconfig = voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg);
> -       vpconfig &= ~(vdd_info[vp_id].vp_reg.vpconfig_initvoltage_mask |
> -                       vdd_info[vp_id].vp_reg.vpconfig_initvdd);
> -       vpconfig |= vsel << vdd_info[vp_id].vp_reg.vpconfig_initvoltage_shift;
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
> +       vpconfig &= ~(vdd->vp_reg.vpconfig_initvoltage_mask |
> +                       vdd->vp_reg.vpconfig_initvdd);
> +       vpconfig |= vsel << vdd->vp_reg.vpconfig_initvoltage_shift;
>
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg, vpconfig);
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>
>         /* Trigger initVDD value copy to voltage processor */
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
> -                       (vpconfig | vdd_info[vp_id].vp_reg.vpconfig_initvdd));
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg,
> +                       (vpconfig | vdd->vp_reg.vpconfig_initvdd));
>
>         /* Clear initVDD copy trigger bit */
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg, vpconfig);
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>  }
>
>  /* OMAP3 specific voltage init functions */
> @@ -356,83 +354,80 @@ static void __init omap3_init_voltagecontroller(void)
>  }
>
>  /* Sets up all the VDD related info for OMAP3 */
> -static void __init omap3_vdd_data_configure(int vdd)
> +static void __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
>  {
>         unsigned long curr_volt;
>         struct omap_volt_data *volt_data;
>         struct clk *sys_ck;
>         u32 sys_clk_speed, timeout_val, waittime;
>
> -       vdd_info[vdd].vp_offs = omap3_vp_offs[vdd];
> -       if (vdd == VDD1) {
> +       if (!strcmp(vdd->volt_domain.name, "mpu")) {
>                 if (cpu_is_omap3630()) {
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmin =
> +                       vdd->vp_reg.vlimitto_vddmin =
>                                         OMAP3630_VP1_VLIMITTO_VDDMIN;
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmax =
> +                       vdd->vp_reg.vlimitto_vddmax =
>                                         OMAP3630_VP1_VLIMITTO_VDDMAX;
> -                       vdd_info[vdd].volt_data = omap36xx_vdd1_volt_data;
> -                       vdd_info[vdd].volt_data_count =
> +                       vdd->volt_data = omap36xx_vdd1_volt_data;
> +                       vdd->volt_data_count =
>                                         ARRAY_SIZE(omap36xx_vdd1_volt_data);
>                 } else {
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmin =
> +                       vdd->vp_reg.vlimitto_vddmin =
>                                         OMAP3430_VP1_VLIMITTO_VDDMIN;
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmax =
> +                       vdd->vp_reg.vlimitto_vddmax =
>                                         OMAP3430_VP1_VLIMITTO_VDDMAX;
> -                       vdd_info[vdd].volt_data = omap34xx_vdd1_volt_data;
> -                       vdd_info[vdd].volt_data_count =
> +                       vdd->volt_data = omap34xx_vdd1_volt_data;
> +                       vdd->volt_data_count =
>                                         ARRAY_SIZE(omap34xx_vdd1_volt_data);
>                 }

this code is precisely the reason why I wondered why are we using hwmod
at all?? this is the kind of data that beautifully fits inside hwmod if
you define a vc and a vp device and oh_lookup..

> -               vdd_info[vdd].volt_clk = clk_get(NULL, "dpll1_ck");
> -               WARN(IS_ERR(vdd_info[vdd].volt_clk),
> -                               "unable to get clock for VDD%d\n", vdd + 1);
> -               vdd_info[vdd].opp_dev = omap_get_mpu_device();
> -               vdd_info[vdd].vp_reg.tranxdone_status =
> -                               OMAP3430_VP1_TRANXDONE_ST_MASK;
> -               vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
> -               vdd_info[vdd].vdd_sr_reg = OMAP3_VDD1_SR_CONTROL_REG;
> -       } else if (vdd == VDD2) {
> +               vdd->volt_clk = clk_get(NULL, "dpll1_ck");
> +               WARN(IS_ERR(vdd->volt_clk), "unable to get clock for vdd_%s\n",
> +                               vdd->volt_domain.name);
> +               vdd->opp_dev = omap_get_mpu_device();
> +               vdd->vp_reg.tranxdone_status = OMAP3430_VP1_TRANXDONE_ST_MASK;
> +               vdd->cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
> +               vdd->vdd_sr_reg = OMAP3_VDD1_SR_CONTROL_REG;
bit lost - why is SR register par of vdd..? I think i missed something.

> +       } else if (!strcmp(vdd->volt_domain.name, "core")) {
>                 if (cpu_is_omap3630()) {
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmin =
> +                       vdd->vp_reg.vlimitto_vddmin =
>                                         OMAP3630_VP2_VLIMITTO_VDDMIN;
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmax =
> +                       vdd->vp_reg.vlimitto_vddmax =
>                                         OMAP3630_VP2_VLIMITTO_VDDMAX;
> -                       vdd_info[vdd].volt_data = omap36xx_vdd2_volt_data;
> -                       vdd_info[vdd].volt_data_count =
> +                       vdd->volt_data = omap36xx_vdd2_volt_data;
> +                       vdd->volt_data_count =
>                                         ARRAY_SIZE(omap36xx_vdd2_volt_data);
>                 } else {
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmin =
> +                       vdd->vp_reg.vlimitto_vddmin =
>                                         OMAP3430_VP2_VLIMITTO_VDDMIN;
> -                       vdd_info[vdd].vp_reg.vlimitto_vddmax =
> +                       vdd->vp_reg.vlimitto_vddmax =
>                                         OMAP3430_VP2_VLIMITTO_VDDMAX;
> -                       vdd_info[vdd].volt_data = omap34xx_vdd2_volt_data;
> -                       vdd_info[vdd].volt_data_count =
> +                       vdd->volt_data = omap34xx_vdd2_volt_data;
> +                       vdd->volt_data_count =
>                                         ARRAY_SIZE(omap34xx_vdd2_volt_data);
>                 }
> -               vdd_info[vdd].volt_clk = clk_get(NULL, "l3_ick");
> -               WARN(IS_ERR(vdd_info[vdd].volt_clk),
> -                               "unable to get clock for VDD%d\n", vdd + 1);
> -               vdd_info[vdd].opp_dev = omap_get_l3_device();
> -               vdd_info[vdd].vp_reg.tranxdone_status =
> -                                       OMAP3430_VP2_TRANXDONE_ST_MASK;
> -               vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
> -               vdd_info[vdd].vdd_sr_reg = OMAP3_VDD2_SR_CONTROL_REG;
> +               vdd->volt_clk = clk_get(NULL, "l3_ick");
> +               WARN(IS_ERR(vdd->volt_clk), "unable to get clock for vdd_%s\n",
> +                               vdd->volt_domain.name);
> +               vdd->opp_dev = omap_get_l3_device();
> +               vdd->vp_reg.tranxdone_status = OMAP3430_VP2_TRANXDONE_ST_MASK;
> +               vdd->cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
> +               vdd->vdd_sr_reg = OMAP3_VDD2_SR_CONTROL_REG;

>         } else {
> -               pr_warning("%s: Vdd%d does not exisit in OMAP3\n",
> -                       __func__, vdd + 1);
> +               pr_warning("%s: vdd_%sdoes not exisit in OMAP3\n",
> +                       __func__, vdd->volt_domain.name);
>                 return;
>         }

Aieee... this is one messy code we could have done without..
>
> -       curr_volt = get_curr_voltage(vdd);
> +       curr_volt = get_curr_voltage(&vdd->volt_domain);
>         if (!curr_volt) {
> -               pr_warning("%s: unable to find current voltage for VDD%d\n",
> -                       __func__, vdd + 1);
> +               pr_warning("%s: unable to find current voltage for vdd_%s\n",
> +                       __func__, vdd->volt_domain.name);
>                 return;
>         }
>
> -       volt_data = omap_get_volt_data(vdd, curr_volt);
> +       volt_data = omap_get_volt_data(&vdd->volt_domain, curr_volt);
>         if (IS_ERR(volt_data)) {
> -               pr_warning("%s: Unable to get voltage table for VDD%d at init",
> -                       __func__, vdd + 1);
> +               pr_warning("%s: Unable to get volt table for vdd_%s at init",
> +                       __func__, vdd->volt_domain.name);
>                 return;
>         }
>         /*
> @@ -442,7 +437,8 @@ static void __init omap3_vdd_data_configure(int vdd)
>         sys_ck = clk_get(NULL, "sys_ck");
>         if (IS_ERR(sys_ck)) {
>                 pr_warning("%s: Could not get the sys clk to calculate"
> -                       "various VP%d params\n", __func__, vdd + 1);
> +                       "various vdd_%s params\n",
> +                       __func__, vdd->volt_domain.name);
>                 return;
>         }
>         sys_clk_speed = clk_get_rate(sys_ck);
> @@ -451,135 +447,133 @@ static void __init omap3_vdd_data_configure(int vdd)
>         sys_clk_speed /= 1000;
>
>         /* Nominal/Reset voltage of the VDD */
> -       vdd_info[vdd].nominal_volt = 1200000;
> +       vdd->nominal_volt = 1200000;

err.... hardcoded voltage. things change and this will mess us up.

>
>         /* VPCONFIG bit fields */
> -       vdd_info[vdd].vp_reg.vpconfig_erroroffset =
> -                               (OMAP3_VP_CONFIG_ERROROFFSET <<
> +       vdd->vp_reg.vpconfig_erroroffset = (OMAP3_VP_CONFIG_ERROROFFSET <<
>                                  OMAP3430_ERROROFFSET_SHIFT);
> -       vdd_info[vdd].vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
> -       vdd_info[vdd].vp_reg.vpconfig_errorgain_mask = OMAP3430_ERRORGAIN_MASK;
> -       vdd_info[vdd].vp_reg.vpconfig_errorgain_shift =
> +       vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
> +       vdd->vp_reg.vpconfig_errorgain_mask = OMAP3430_ERRORGAIN_MASK;
> +       vdd->vp_reg.vpconfig_errorgain_shift =
>                                 OMAP3430_ERRORGAIN_SHIFT;
> -       vdd_info[vdd].vp_reg.vpconfig_initvoltage_shift =
> +       vdd->vp_reg.vpconfig_initvoltage_shift =
>                                 OMAP3430_INITVOLTAGE_SHIFT;
> -       vdd_info[vdd].vp_reg.vpconfig_initvoltage_mask =
> +       vdd->vp_reg.vpconfig_initvoltage_mask =
>                                 OMAP3430_INITVOLTAGE_MASK;
> -       vdd_info[vdd].vp_reg.vpconfig_timeouten = OMAP3430_TIMEOUTEN_MASK;
> -       vdd_info[vdd].vp_reg.vpconfig_initvdd = OMAP3430_INITVDD_MASK;
> -       vdd_info[vdd].vp_reg.vpconfig_forceupdate = OMAP3430_FORCEUPDATE_MASK;
> -       vdd_info[vdd].vp_reg.vpconfig_vpenable = OMAP3430_VPENABLE_MASK;
> +       vdd->vp_reg.vpconfig_timeouten = OMAP3430_TIMEOUTEN_MASK;
> +       vdd->vp_reg.vpconfig_initvdd = OMAP3430_INITVDD_MASK;
> +       vdd->vp_reg.vpconfig_forceupdate = OMAP3430_FORCEUPDATE_MASK;
> +       vdd->vp_reg.vpconfig_vpenable = OMAP3430_VPENABLE_MASK;

my recommendation to move to hwmod for vp and vc is highlighted yet again.

>
>         /* VSTEPMIN VSTEPMAX bit fields */
>         waittime = ((volt_pmic_info.step_size / volt_pmic_info.slew_rate) *
>                                 sys_clk_speed) / 1000;
> -       vdd_info[vdd].vp_reg.vstepmin_smpswaittimemin = waittime;
> -       vdd_info[vdd].vp_reg.vstepmax_smpswaittimemax = waittime;
> -       vdd_info[vdd].vp_reg.vstepmin_stepmin = OMAP3_VP_VSTEPMIN_VSTEPMIN;
> -       vdd_info[vdd].vp_reg.vstepmax_stepmax = OMAP3_VP_VSTEPMAX_VSTEPMAX;
> -       vdd_info[vdd].vp_reg.vstepmin_smpswaittimemin_shift =
> +       vdd->vp_reg.vstepmin_smpswaittimemin = waittime;
> +       vdd->vp_reg.vstepmax_smpswaittimemax = waittime;
> +       vdd->vp_reg.vstepmin_stepmin = OMAP3_VP_VSTEPMIN_VSTEPMIN;
> +       vdd->vp_reg.vstepmax_stepmax = OMAP3_VP_VSTEPMAX_VSTEPMAX;
> +       vdd->vp_reg.vstepmin_smpswaittimemin_shift =
>                                 OMAP3430_SMPSWAITTIMEMIN_SHIFT;
> -       vdd_info[vdd].vp_reg.vstepmax_smpswaittimemax_shift =
> +       vdd->vp_reg.vstepmax_smpswaittimemax_shift =
>                                 OMAP3430_SMPSWAITTIMEMAX_SHIFT;
> -       vdd_info[vdd].vp_reg.vstepmin_stepmin_shift = OMAP3430_VSTEPMIN_SHIFT;
> -       vdd_info[vdd].vp_reg.vstepmax_stepmax_shift = OMAP3430_VSTEPMAX_SHIFT;
> +       vdd->vp_reg.vstepmin_stepmin_shift = OMAP3430_VSTEPMIN_SHIFT;
> +       vdd->vp_reg.vstepmax_stepmax_shift = OMAP3430_VSTEPMAX_SHIFT;
>
>         /* VLIMITTO bit fields */
>         timeout_val = (sys_clk_speed * OMAP3_VP_VLIMITTO_TIMEOUT_US) / 1000;
> -       vdd_info[vdd].vp_reg.vlimitto_timeout = timeout_val;
> -       vdd_info[vdd].vp_reg.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT;
> -       vdd_info[vdd].vp_reg.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT;
> -       vdd_info[vdd].vp_reg.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT;
> +       vdd->vp_reg.vlimitto_timeout = timeout_val;
> +       vdd->vp_reg.vlimitto_vddmin_shift = OMAP3430_VDDMIN_SHIFT;
> +       vdd->vp_reg.vlimitto_vddmax_shift = OMAP3430_VDDMAX_SHIFT;
> +       vdd->vp_reg.vlimitto_timeout_shift = OMAP3430_TIMEOUT_SHIFT;
>  }
>
>  /* Generic voltage init functions */
> -static void __init init_voltageprocesor(int vp_id)
> +static void __init init_voltageprocesor(struct omap_vdd_info *vdd)
>  {
>         u32 vpconfig;
>
> -       vpconfig = vdd_info[vp_id].vp_reg.vpconfig_erroroffset |
> -                       (vdd_info[vp_id].vp_reg.vpconfig_errorgain <<
> -                       vdd_info[vp_id].vp_reg.vpconfig_errorgain_shift) |
> -                       vdd_info[vp_id].vp_reg.vpconfig_timeouten;
> -
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg, vpconfig);
> -
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmin_reg,
> -                       (vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin <<
> -                       vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin_shift) |
> -                       (vdd_info[vp_id].vp_reg.vstepmin_stepmin <<
> -                       vdd_info[vp_id].vp_reg.vstepmin_stepmin_shift));
> -
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmax_reg,
> -                       (vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax <<
> -                       vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax_shift) |
> -                       (vdd_info[vp_id].vp_reg.vstepmax_stepmax <<
> -                       vdd_info[vp_id].vp_reg.vstepmax_stepmax_shift));
> -
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vlimitto_reg,
> -                       (vdd_info[vp_id].vp_reg.vlimitto_vddmax <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_vddmax_shift) |
> -                       (vdd_info[vp_id].vp_reg.vlimitto_vddmin <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_vddmin_shift) |
> -                       (vdd_info[vp_id].vp_reg.vlimitto_timeout <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_timeout_shift));
> +       vpconfig = vdd->vp_reg.vpconfig_erroroffset |
> +                       (vdd->vp_reg.vpconfig_errorgain <<
> +                       vdd->vp_reg.vpconfig_errorgain_shift) |
> +                       vdd->vp_reg.vpconfig_timeouten;
> +
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
> +
> +       voltage_write_reg(vdd->vp_offs.vstepmin_reg,
> +                       (vdd->vp_reg.vstepmin_smpswaittimemin <<
> +                       vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
> +                       (vdd->vp_reg.vstepmin_stepmin <<
> +                       vdd->vp_reg.vstepmin_stepmin_shift));
> +
> +       voltage_write_reg(vdd->vp_offs.vstepmax_reg,
> +                       (vdd->vp_reg.vstepmax_smpswaittimemax <<
> +                       vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
> +                       (vdd->vp_reg.vstepmax_stepmax <<
> +                       vdd->vp_reg.vstepmax_stepmax_shift));
> +
> +       voltage_write_reg(vdd->vp_offs.vlimitto_reg,
> +                       (vdd->vp_reg.vlimitto_vddmax <<
> +                        vdd->vp_reg.vlimitto_vddmax_shift) |
> +                       (vdd->vp_reg.vlimitto_vddmin <<
> +                       vdd->vp_reg.vlimitto_vddmin_shift) |
> +                       (vdd->vp_reg.vlimitto_timeout <<
> +                       vdd->vp_reg.vlimitto_timeout_shift));

suggestion, why not use a local variable, cast vdd->vp_reg to r and use
it? code will be a lot cleaner and readable

>
>         /* Set the init voltage */
> -       vp_latch_vsel(vp_id);
> +       vp_latch_vsel(vdd);
>
> -       vpconfig = voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg);
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
>         /* Force update of voltage */
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
> -                       (vpconfig |
> -                        vdd_info[vp_id].vp_reg.vpconfig_forceupdate));
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg,
> +                       (vpconfig | vdd->vp_reg.vpconfig_forceupdate));
>         /* Clear force bit */
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg, vpconfig);
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>  }
>
> -static void __init vdd_data_configure(int vdd)
> +static void __init vdd_data_configure(struct omap_vdd_info *vdd)
>  {
>  #ifdef CONFIG_PM_DEBUG
>         struct dentry *vdd_debug;
> -       char name[5];
> +       char name[16];
I am going to crib as before with the sizes used here.
>  #endif
> -       vdd_info[vdd].id = vdd;
>         if (cpu_is_omap34xx())
>                 omap3_vdd_data_configure(vdd);
>
>  #ifdef CONFIG_PM_DEBUG
> -       sprintf(name, "VDD%d", vdd + 1);
> +       strcpy(name, "vdd_");
> +       strcat(name, vdd->volt_domain.name);

I am going to crib as before...

>         vdd_debug = debugfs_create_dir(name, voltage_dir);
>         (void) debugfs_create_file("vp_errorgain", S_IRUGO | S_IWUGO,
>                                 vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vpconfig_errorgain),
> +                               &(vdd->vp_reg.vpconfig_errorgain),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_smpswaittimemin", S_IRUGO | S_IWUGO,
> -                               vdd_debug, &(vdd_info[vdd].vp_reg.
> -                               vstepmin_smpswaittimemin),
> +                               vdd_debug,
> +                               &(vdd->vp_reg.vstepmin_smpswaittimemin),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_stepmin", S_IRUGO | S_IWUGO, vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vstepmin_stepmin),
> +                               &(vdd->vp_reg.vstepmin_stepmin),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_smpswaittimemax", S_IRUGO | S_IWUGO,
> -                               vdd_debug, &(vdd_info[vdd].vp_reg.
> -                               vstepmax_smpswaittimemax),
> +                               vdd_debug,
> +                               &(vdd->vp_reg.vstepmax_smpswaittimemax),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_stepmax", S_IRUGO | S_IWUGO, vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vstepmax_stepmax),
> +                               &(vdd->vp_reg.vstepmax_stepmax),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_vddmax", S_IRUGO | S_IWUGO, vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vlimitto_vddmax),
> +                               &(vdd->vp_reg.vlimitto_vddmax),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_vddmin", S_IRUGO | S_IWUGO, vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vlimitto_vddmin),
> +                               &(vdd->vp_reg.vlimitto_vddmin),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("vp_timeout", S_IRUGO | S_IWUGO, vdd_debug,
> -                               &(vdd_info[vdd].vp_reg.vlimitto_timeout),
> +                               &(vdd->vp_reg.vlimitto_timeout),
>                                 &vp_debug_fops);
>         (void) debugfs_create_file("curr_vp_volt", S_IRUGO, vdd_debug,
> -                               (void *) &vdd_info[vdd], &vp_volt_debug_fops);
> +                               (void *) vdd, &vp_volt_debug_fops);
>         (void) debugfs_create_file("curr_nominal_volt", S_IRUGO, vdd_debug,
> -                               (void *) &vdd_info[vdd], &nom_volt_debug_fops);
> +                               (void *) vdd, &nom_volt_debug_fops);

dumb question - will we expose this even if sr for that vdd is disabled?
might be better not to do it.. rt?

>  #endif
>  }
>  static void __init init_voltagecontroller(void)
> @@ -591,7 +585,8 @@ static void __init init_voltagecontroller(void)
>  /*
>   * vc_bypass_scale_voltage - VC bypass method of voltage scaling
>   */
> -static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt)
> +static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
> +               unsigned long target_volt)
>  {
>         struct omap_volt_data *volt_data;
>         u32 vc_bypass_value, vc_cmdval, vc_valid, vc_bypass_val_reg_offs;
> @@ -614,49 +609,46 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt)
>         }
>
>         /* Get volt_data corresponding to target_volt */
> -       volt_data = omap_get_volt_data(vdd, target_volt);
> +       volt_data = omap_get_volt_data(&vdd->volt_domain, target_volt);
>         if (IS_ERR(volt_data)) {
>                 /*
>                  * If a match is not found but the target voltage is
>                  * is the nominal vdd voltage allow scaling
>                  */
> -               if (target_volt != vdd_info[vdd].nominal_volt) {
> -                       pr_warning("%s: Unable to get voltage table for VDD%d"
> +               if (target_volt != vdd->nominal_volt) {
> +                       pr_warning("%s: Unable to get voltage table for vdd_%s"
>                                 "during voltage scaling. Some really Wrong!",
> -                               __func__, vdd + 1);
> +                               __func__, vdd->volt_domain.name);
>                         return -ENODATA;
>                 }
>                 volt_data = NULL;
>         }
>
>         target_vsel = omap_twl_uv_to_vsel(target_volt);
not related, but could'nt ressist: twl?? should'nt vp be independt of
twl? I know of folks who use omap without TWL..

> -       current_vsel = voltage_read_reg(vdd_info[vdd].vp_offs.voltage_reg);
> +       current_vsel = voltage_read_reg(vdd->vp_offs.voltage_reg);
curious - is'nt this a VP register? I see it set to
OMAP3_PRM_VP1_VOLTAGE_OFFSET. when we do vc bypass, with SR disabled
instead of forceupdate, we write to vc_bypass_val_reg_offs and we do a
initvdd and the vp register does not really have any valid value,
meaning you actually are waiting a random smps steps for this to
complete. so wondering how does this work?

now if SR was enabled, yeah, later in sr sequence, we enable SR, and SR
would have talked to VP and this actually contains a valid voltage.

how do we handle two independent cases here?

>         smps_steps = abs(target_vsel - current_vsel);
>
>         /* Setting the ON voltage to the new target voltage */
> -       vc_cmdval = voltage_read_reg(vdd_info[vdd].cmdval_reg);
> +       vc_cmdval = voltage_read_reg(vdd->cmdval_reg);
>         vc_cmdval &= ~vc_cmd_on_mask;
>         vc_cmdval |= (target_vsel << vc_cmd_on_shift);
> -       voltage_write_reg(vdd_info[vdd].cmdval_reg, vc_cmdval);
> +       voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
>
>         /*
>          * Setting vp errorgain based on the voltage If the debug option is
>          * enabled allow the override of errorgain from user side
>          */
>         if (!enable_sr_vp_debug && volt_data) {
> -               vp_errgain_val = voltage_read_reg(vdd_info[vdd].
> -                               vp_offs.vpconfig_reg);
> -               vdd_info[vdd].vp_reg.vpconfig_errorgain =
> -                               volt_data->vp_errgain;
> -               vp_errgain_val &= ~vdd_info[vdd].vp_reg.vpconfig_errorgain_mask;
> -               vp_errgain_val |= vdd_info[vdd].vp_reg.vpconfig_errorgain <<
> -                               vdd_info[vdd].vp_reg.vpconfig_errorgain_shift;
> -               voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg,
> -                               vp_errgain_val);
> +               vp_errgain_val = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
> +               vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
> +               vp_errgain_val &= ~vdd->vp_reg.vpconfig_errorgain_mask;
> +               vp_errgain_val |= vdd->vp_reg.vpconfig_errorgain <<
> +                               vdd->vp_reg.vpconfig_errorgain_shift;
> +               voltage_write_reg(vdd->vp_offs.vpconfig_reg, vp_errgain_val);
>         }
>
>         vc_bypass_value = (target_vsel << vc_data_shift) |
> -                       (vdd_info[vdd].vdd_sr_reg << vc_regaddr_shift) |
> +                       (vdd->vdd_sr_reg << vc_regaddr_shift) |
>                         (sr_i2c_slave_addr << vc_slaveaddr_shift);
>
>         voltage_write_reg(vc_bypass_val_reg_offs, vc_bypass_value);
> @@ -687,7 +679,8 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt)
>  }
>
>  /* VP force update method of voltage scaling */
> -static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
> +static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
> +               unsigned long target_volt)
>  {
>         struct omap_volt_data *volt_data;
>         u32 vc_cmd_on_mask, vc_cmdval, vpconfig;
> @@ -705,75 +698,74 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
>         }
>
>         /* Get volt_data corresponding to the target_volt */
> -       volt_data = omap_get_volt_data(vdd, target_volt);
> +       volt_data = omap_get_volt_data(&vdd->volt_domain, target_volt);
>         if (IS_ERR(volt_data)) {
>                 /*
>                  * If a match is not found but the target voltage is
>                  * is the nominal vdd voltage allow scaling
>                  */
lost as to why... I just would expect to go and fail.
> -               if (target_volt != vdd_info[vdd].nominal_volt) {
> -                       pr_warning("%s: Unable to get voltage table for VDD%d"
> +               if (target_volt != vdd->nominal_volt) {
> +                       pr_warning("%s: Unable to get voltage table for vdd_%s"
>                                 "during voltage scaling. Some really Wrong!",
> -                               __func__, vdd + 1);
> +                               __func__, vdd->volt_domain.name);
>                         return -ENODATA;
>                 }
>                 volt_data = NULL;
>         }
>
>         target_vsel = omap_twl_uv_to_vsel(target_volt);
> -       current_vsel = voltage_read_reg(vdd_info[vdd].vp_offs.voltage_reg);
> +       current_vsel = voltage_read_reg(vdd->vp_offs.voltage_reg);
>         smps_steps = abs(target_vsel - current_vsel);
>
>         /* Setting the ON voltage to the new target voltage */
> -       vc_cmdval = voltage_read_reg(vdd_info[vdd].cmdval_reg);
> +       vc_cmdval = voltage_read_reg(vdd->cmdval_reg);
>         vc_cmdval &= ~vc_cmd_on_mask;
>         vc_cmdval |= (target_vsel << vc_cmd_on_shift);
> -       voltage_write_reg(vdd_info[vdd].cmdval_reg, vc_cmdval);
> +       voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
this code should probably move out rt? it is setting up the on voltage
which is not exactly forceupdate.
>
>         /*
>          * Getting  vp errorgain based on the voltage If the debug option is
>          * enabled allow the override of errorgain from user side.
>          */
>         if (!enable_sr_vp_debug && volt_data)
> -               vdd_info[vdd].vp_reg.vpconfig_errorgain =
> -                                       volt_data->vp_errgain;
> +               vdd->vp_reg.vpconfig_errorgain = volt_data->vp_errgain;
>         /*
>          * Clear all pending TransactionDone interrupt/status. Typical latency
>          * is <3us
>          */
>         while (timeout++ < VP_TRANXDONE_TIMEOUT) {
> -               prm_write_mod_reg(vdd_info[vdd].vp_reg.tranxdone_status,
> +               prm_write_mod_reg(vdd->vp_reg.tranxdone_status,
>                                 ocp_mod, prm_irqst_reg_offs);
>                 if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
> -                               vdd_info[vdd].vp_reg.tranxdone_status))
> +                               vdd->vp_reg.tranxdone_status))
>                                 break;
>                 udelay(1);
>         }
>
>         if (timeout >= VP_TRANXDONE_TIMEOUT) {
> -               pr_warning("%s: VP%d TRANXDONE timeout exceeded."
> -                       "Voltage change aborted", __func__, vdd + 1);
> +               pr_warning("%s: vdd_%s TRANXDONE timeout exceeded."
> +                       "Voltage change aborted",
> +                       __func__, vdd->volt_domain.name);
>                 return -ETIMEDOUT;
>         }
>         /* Configure for VP-Force Update */
> -       vpconfig = voltage_read_reg(vdd_info[vdd].vp_offs.vpconfig_reg);
> -       vpconfig &= ~(vdd_info[vdd].vp_reg.vpconfig_initvdd |
> -                       vdd_info[vdd].vp_reg.vpconfig_forceupdate |
> -                       vdd_info[vdd].vp_reg.vpconfig_initvoltage_mask |
> -                       vdd_info[vdd].vp_reg.vpconfig_errorgain_mask);
> -       vpconfig |= ((target_vsel <<
> -                       vdd_info[vdd].vp_reg.vpconfig_initvoltage_shift) |
> -                       (vdd_info[vdd].vp_reg.vpconfig_errorgain <<
> -                        vdd_info[vdd].vp_reg.vpconfig_errorgain_shift));
> -       voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
> +       vpconfig &= ~(vdd->vp_reg.vpconfig_initvdd |
> +                       vdd->vp_reg.vpconfig_forceupdate |
> +                       vdd->vp_reg.vpconfig_initvoltage_mask |
> +                       vdd->vp_reg.vpconfig_errorgain_mask);
> +       vpconfig |= ((target_vsel << vdd->vp_reg.vpconfig_initvoltage_shift) |
> +                       (vdd->vp_reg.vpconfig_errorgain <<
> +                        vdd->vp_reg.vpconfig_errorgain_shift));
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
do consider casting vdd->vp_offs and using.. it kinda makes reading code
a little easier..
>
>         /* Trigger initVDD value copy to voltage processor */
> -       vpconfig |= vdd_info[vdd].vp_reg.vpconfig_initvdd;
> -       voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig |= vdd->vp_reg.vpconfig_initvdd;
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>
>         /* Force update of voltage */
> -       vpconfig |= vdd_info[vdd].vp_reg.vpconfig_forceupdate;
> -       voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig |= vdd->vp_reg.vpconfig_forceupdate;
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>
>         timeout = 0;
>         /*
> @@ -781,13 +773,13 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
>          * Depends on SMPSWAITTIMEMIN/MAX and voltage change
>          */
>         omap_test_timeout((prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
> -                       vdd_info[vdd].vp_reg.tranxdone_status),
> -                       VP_TRANXDONE_TIMEOUT, timeout);
> +                       vdd->vp_reg.tranxdone_status), VP_TRANXDONE_TIMEOUT,
> +                       timeout);
>
>         if (timeout >= VP_TRANXDONE_TIMEOUT)
> -               pr_err("%s: VP%d TRANXDONE timeout exceeded."
> +               pr_err("%s: vdd_%s TRANXDONE timeout exceeded."
>                         "TRANXDONE never got set after the voltage update\n",
> -                       __func__, vdd + 1);
> +                       __func__, vdd->volt_domain.name);
>         /*
>          * Wait for voltage to settle with SW wait-loop.
>          * SMPS slew rate / step size. 2us added as buffer.
> @@ -802,24 +794,25 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
>          */
>         timeout = 0;
>         while (timeout++ < VP_TRANXDONE_TIMEOUT) {
> -               prm_write_mod_reg(vdd_info[vdd].vp_reg.tranxdone_status,
> -                               ocp_mod, prm_irqst_reg_offs);
> +               prm_write_mod_reg(vdd->vp_reg.tranxdone_status, ocp_mod,
> +                               prm_irqst_reg_offs);
>                 if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
> -                               vdd_info[vdd].vp_reg.tranxdone_status))
> +                               vdd->vp_reg.tranxdone_status))
>                                 break;
>                 udelay(1);
>         }
>         if (timeout >= VP_TRANXDONE_TIMEOUT)
> -               pr_warning("%s: VP%d TRANXDONE timeout exceeded while trying"
> -                       "to clear the TRANXDONE status\n", __func__, vdd + 1);
> +               pr_warning("%s: vdd_%s TRANXDONE timeout exceeded while trying"
> +                       "to clear the TRANXDONE status\n",
> +                       __func__, vdd->volt_domain.name);
>
> -       vpconfig = voltage_read_reg(vdd_info[vdd].vp_offs.vpconfig_reg);
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
>         /* Clear initVDD copy trigger bit */
> -       vpconfig &= ~vdd_info[vdd].vp_reg.vpconfig_initvdd;;
> -       voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig &= ~vdd->vp_reg.vpconfig_initvdd;;
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>         /* Clear force bit */
> -       vpconfig &= ~vdd_info[vdd].vp_reg.vpconfig_forceupdate;
> -       voltage_write_reg(vdd_info[vdd].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig &= ~vdd->vp_reg.vpconfig_forceupdate;
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>
>         return 0;
>  }
> @@ -827,26 +820,29 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt)
>  /* Public functions */
>  /**
>   * get_curr_vdd_voltage : Gets the current non-auto-compensated voltage
> - * @vdd        : the VDD for which current voltage info is needed
> + * @volt_domain        : pointer to the VDD for which current voltage info is needed
>   *
>   * API to get the current non-auto-compensated voltage for a VDD.
>   * Returns 0 in case of error else returns the current voltage for the VDD.
>   */
> -unsigned long get_curr_voltage(int vdd)
> +unsigned long get_curr_voltage(struct omap_volt_domain *volt_domain)
>  {
>         struct omap_opp *opp;
> +       struct omap_vdd_info *vdd;
>         unsigned long freq;
>
> -       if (check_voltage_domain(vdd)) {
> -               pr_warning("%s: VDD %d does not exist!\n", __func__, vdd);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
>                 return 0;
>         }
>
> -       freq = vdd_info[vdd].volt_clk->rate;
> -       opp = opp_find_freq_ceil(vdd_info[vdd].opp_dev, &freq);
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
> +       freq = vdd->volt_clk->rate;
> +       opp = opp_find_freq_ceil(vdd->opp_dev, &freq);
>         if (IS_ERR(opp)) {
> -               pr_warning("%s: Unable to find OPP for VDD%d freq%ld\n",
> -                       __func__, vdd + 1, freq);
> +               pr_warning("%s: Unable to find OPP for vdd_%s freq%ld\n",
> +                       __func__, volt_domain->name, freq);
>                 return 0;
>         }
>
> @@ -854,185 +850,197 @@ unsigned long get_curr_voltage(int vdd)
>          * Use higher freq voltage even if an exact match is not available
>          * we are probably masking a clock framework bug, so warn
>          */
> -       if (unlikely(freq != vdd_info[vdd].volt_clk->rate))
> +       if (unlikely(freq != vdd->volt_clk->rate))
errrr... am not really in favor of two structures holding same data..
leads to all kind of wierdness eventually.
>                 pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> -                       __func__, freq, vdd_info[vdd].volt_clk->rate);
> +                       __func__, freq, vdd->volt_clk->rate);
>
>         return opp_get_voltage(opp);
>  }
>
>  /**
>   * omap_voltageprocessor_get_curr_volt : API to get the current vp voltage.
> - * @vp_id: VP id.
> + * @volt_domain: pointer to the VDD.
>   *
>   * This API returns the current voltage for the specified voltage processor
>   */
> -unsigned long omap_voltageprocessor_get_curr_volt(int vp_id)
> +unsigned long omap_voltageprocessor_get_curr_volt(
> +               struct omap_volt_domain *volt_domain)
>  {
> +       struct omap_vdd_info *vdd;
>         u8 curr_vsel;
>
> -       curr_vsel = voltage_read_reg(vdd_info[vp_id].vp_offs.voltage_reg);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
> +               return -EINVAL;
are'nt we returning unsinged long? the caller will think he has a valid
voltage!
> +       }
> +
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
> +       curr_vsel = voltage_read_reg(vdd->vp_offs.voltage_reg);
>         return omap_twl_vsel_to_uv(curr_vsel);
twl?

>  }
>
>  /**
>   * omap_voltageprocessor_enable : API to enable a particular VP
> - * @vp_id : The id of the VP to be enable.
> + * @volt_domain: pointer to the VDD whose VP is to be enabled.
>   *
>   * This API enables a particular voltage processor. Needed by the smartreflex
>   * class drivers.
>   */
> -void omap_voltageprocessor_enable(int vp_id)
> +void omap_voltageprocessor_enable(struct omap_volt_domain *volt_domain)
>  {
> +       struct omap_vdd_info *vdd;
>         u32 vpconfig;
>
> -       if (check_voltage_domain(vp_id)) {
> -               pr_warning("%s: VDD %d does not exist!\n",
> -                       __func__, vp_id + 1);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
>                 return;
should'nt i return with an error here?
>         }
>
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
unlikely check if vdd is valid?

>         /* If VP is already enabled, do nothing. Return */
> -       if (voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg) &
> -                               vdd_info[vp_id].vp_reg.vpconfig_vpenable)
> +       if (voltage_read_reg(vdd->vp_offs.vpconfig_reg) &
> +                       vdd->vp_reg.vpconfig_vpenable)
>                 return;
>         /*
>          * This latching is required only if VC bypass method is used for
>          * voltage scaling during dvfs.
>          */
>         if (!voltscale_vpforceupdate)
> -               vp_latch_vsel(vp_id);
> +               vp_latch_vsel(vdd);
>
>         /*
>          * If debug is enabled, it is likely that the following parameters
>          * were set from user space so rewrite them.
>          */
>         if (enable_sr_vp_debug) {
> -               vpconfig = voltage_read_reg(
> -                       vdd_info[vp_id].vp_offs.vpconfig_reg);
> -               vpconfig |= (vdd_info[vp_id].vp_reg.vpconfig_errorgain <<
> -                       vdd_info[vp_id].vp_reg.vpconfig_errorgain_shift);
> -               voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
> -                       vpconfig);
> -
> -               voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmin_reg,
> -                       (vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin <<
> -                       vdd_info[vp_id].vp_reg.vstepmin_smpswaittimemin_shift) |
> -                       (vdd_info[vp_id].vp_reg.vstepmin_stepmin <<
> -                       vdd_info[vp_id].vp_reg.vstepmin_stepmin_shift));
> -
> -               voltage_write_reg(vdd_info[vp_id].vp_offs.vstepmax_reg,
> -                       (vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax <<
> -                       vdd_info[vp_id].vp_reg.vstepmax_smpswaittimemax_shift) |
> -                       (vdd_info[vp_id].vp_reg.vstepmax_stepmax <<
> -                       vdd_info[vp_id].vp_reg.vstepmax_stepmax_shift));
> -
> -               voltage_write_reg(vdd_info[vp_id].vp_offs.vlimitto_reg,
> -                       (vdd_info[vp_id].vp_reg.vlimitto_vddmax <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_vddmax_shift) |
> -                       (vdd_info[vp_id].vp_reg.vlimitto_vddmin <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_vddmin_shift) |
> -                       (vdd_info[vp_id].vp_reg.vlimitto_timeout <<
> -                       vdd_info[vp_id].vp_reg.vlimitto_timeout_shift));
> +               vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
> +               vpconfig |= (vdd->vp_reg.vpconfig_errorgain <<
> +                       vdd->vp_reg.vpconfig_errorgain_shift);
> +               voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
> +
> +               voltage_write_reg(vdd->vp_offs.vstepmin_reg,
> +                       (vdd->vp_reg.vstepmin_smpswaittimemin <<
> +                       vdd->vp_reg.vstepmin_smpswaittimemin_shift) |
> +                       (vdd->vp_reg.vstepmin_stepmin <<
> +                        vdd->vp_reg.vstepmin_stepmin_shift));
> +
> +               voltage_write_reg(vdd->vp_offs.vstepmax_reg,
> +                       (vdd->vp_reg.vstepmax_smpswaittimemax <<
> +                       vdd->vp_reg.vstepmax_smpswaittimemax_shift) |
> +                       (vdd->vp_reg.vstepmax_stepmax <<
> +                       vdd->vp_reg.vstepmax_stepmax_shift));
> +
> +               voltage_write_reg(vdd->vp_offs.vlimitto_reg,
> +                       (vdd->vp_reg.vlimitto_vddmax <<
> +                        vdd->vp_reg.vlimitto_vddmax_shift) |
> +                       (vdd->vp_reg.vlimitto_vddmin <<
> +                       vdd->vp_reg.vlimitto_vddmin_shift) |
> +                       (vdd->vp_reg.vlimitto_timeout <<
> +                       vdd->vp_reg.vlimitto_timeout_shift));
casting comment again..

>         }
>
> -       vpconfig = voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg);
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
>         /* Enable VP */
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg,
> -                               vpconfig |
> -                               vdd_info[vp_id].vp_reg.vpconfig_vpenable);
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg,
> +                               vpconfig | vdd->vp_reg.vpconfig_vpenable);
>  }
>
>  /**
>   * omap_voltageprocessor_disable : API to disable a particular VP
> - * @vp_id : The id of the VP to be disable.
> + * @volt_domain: pointer to the VDD whose VP is to be disabled.
>   *
>   * This API disables a particular voltage processor. Needed by the smartreflex
>   * class drivers.
>   */
> -void omap_voltageprocessor_disable(int vp_id)
> +void omap_voltageprocessor_disable(struct omap_volt_domain *volt_domain)
>  {
> +       struct omap_vdd_info *vdd;
>         u32 vpconfig;
>         int timeout;
>
> -       if (check_voltage_domain(vp_id)) {
> -               pr_warning("%s: VDD %d does not exist!\n",
> -                       __func__, vp_id + 1);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
>                 return;
error?
>         }
>
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
>         /* If VP is already disabled, do nothing. Return */
> -       if (!(voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg) &
> -                               vdd_info[vp_id].vp_reg.vpconfig_vpenable))
> +       if (!(voltage_read_reg(vdd->vp_offs.vpconfig_reg) &
> +                               vdd->vp_reg.vpconfig_vpenable))
>                 return;
error? should'nt i warn so that i can go fix my code if i used multiple
disables in wrong sequence?
>
>         /* Disable VP */
> -       vpconfig = voltage_read_reg(vdd_info[vp_id].vp_offs.vpconfig_reg);
> -       vpconfig &= ~vdd_info[vp_id].vp_reg.vpconfig_vpenable;
> -       voltage_write_reg(vdd_info[vp_id].vp_offs.vpconfig_reg, vpconfig);
> +       vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig_reg);
> +       vpconfig &= ~vdd->vp_reg.vpconfig_vpenable;
> +       voltage_write_reg(vdd->vp_offs.vpconfig_reg, vpconfig);
>
>         /*
>          * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
>          */
> -       omap_test_timeout((voltage_read_reg
> -                       (vdd_info[vp_id].vp_offs.status_reg)),
> -                       VP_IDLE_TIMEOUT, timeout);
> +       omap_test_timeout(voltage_read_reg(vdd->vp_offs.status_reg),
> +                               VP_IDLE_TIMEOUT, timeout);
>
>         if (timeout >= VP_IDLE_TIMEOUT)
> -               pr_warning("%s: VP%d idle timedout\n", __func__, vp_id + 1);
> +               pr_warning("%s: vdd_%s idle timedout\n",
> +                       __func__, volt_domain->name);
and return error?

>         return;
>  }
>
>  /**
>   * omap_voltage_scale : API to scale voltage of a particular voltage domain.
> - * @vdd : the voltage domain whose voltage is to be scaled
> + * @volt_domain: pointer to the VDD which is to be scaled.
>   * @target_vsel : The target voltage of the voltage domain
>   * @current_vsel : the current voltage of the voltage domain.
>   *
>   * This API should be called by the kernel to do the voltage scaling
>   * for a particular voltage domain during dvfs or any other situation.
>   */
> -int omap_voltage_scale(int vdd, unsigned long target_volt)
> +int omap_voltage_scale(struct omap_volt_domain *volt_domain,
> +                                       unsigned long target_volt)
>  {
> -       int ret = check_voltage_domain(vdd);
> -       if (ret) {
> -               pr_warning("%s: VDD %d does not exist!\n", __func__, vdd + 1);
> -               return ret;
> +       struct omap_vdd_info *vdd;
> +
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
> +               return -EINVAL;
>         }
>
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
i suppose checking of vdd is left to lower layers?
>         if (voltscale_vpforceupdate)
>                 return vp_forceupdate_scale_voltage(vdd, target_volt);
>         else
>                 return vc_bypass_scale_voltage(vdd, target_volt);
>  }
>
> -
> -
>  /**
>   * omap_reset_voltage : Resets the voltage of a particular voltage domain
>   * to that of the current OPP.
> - * @vdd : the voltage domain whose voltage is to be reset.
> + * @volt_domain: pointer to the VDD whose voltage is to be reset.
>   *
>   * This API finds out the correct voltage the voltage domain is supposed
>   * to be at and resets the voltage to that level. Should be used expecially
>   * while disabling any voltage compensation modules.
>   */
> -void omap_reset_voltage(int vdd)
> +void omap_reset_voltage(struct omap_volt_domain *volt_domain)
>  {
>         unsigned long target_uvdc;
>
> -       if (check_voltage_domain(vdd)) {
> -               pr_warning("%s: VDD %d does not exist!\n", __func__, vdd + 1);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
>                 return;
>         }
>
> -       target_uvdc = get_curr_voltage(vdd);
> +       target_uvdc = get_curr_voltage(volt_domain);
/me personally is not a fan of this function.. but understands it is
needed..

>         if (!target_uvdc) {
> -               pr_err("%s: unable to find current voltage for VDD %d\n",
> -                       __func__, vdd + 1);
> +               pr_err("%s: unable to find current voltage for vdd_%s\n",
> +                       __func__, volt_domain->name);
>                 return;
>         }
> -       omap_voltage_scale(vdd, target_uvdc);
> +       omap_voltage_scale(volt_domain, target_uvdc);
>  }
>
>  /**
> @@ -1092,7 +1100,7 @@ void __init omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc)
>   * omap_get_voltage_table : API to get the voltage table associated with a
>   *                         particular voltage domain.
>   *
> - * @vdd : the voltage domain id for which the voltage table is required
> + * @volt_domain: pointer to the VDD for which the voltage table is required
>   * @volt_data : the voltage table for the particular vdd which is to be
>   *             populated by this API
>   * This API populates the voltage table associated with a VDD into the
> @@ -1100,21 +1108,20 @@ void __init omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc)
>   * supported by this vdd.
>   *
>   */
> -int omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data)
> +int omap_get_voltage_table(struct omap_volt_domain *volt_domain,
> +                                       struct omap_volt_data **volt_data)
>  {
> -       if (!vdd_info) {
> -               pr_err("%s: Voltage driver init not yet happened.Faulting!\n",
> -                       __func__);
> -               return 0;
> -       }
> -       *volt_data = vdd_info[vdd].volt_data;
> -       return vdd_info[vdd].volt_data_count;
> +       struct omap_vdd_info *vdd = container_of(volt_domain,
> +                               struct omap_vdd_info, volt_domain);
> +
missed checking right pointers from a exposed function?

> +       *volt_data = vdd->volt_data;
> +       return vdd->volt_data_count;
>  }
>
>  /**
>   * omap_get_volt_data : API to get the voltage table entry for a particular
>   *                  voltage
> - * @vdd : the voltage domain id for whose voltage table has to be searched
> + * @volt_domain: pointer to the VDD whose voltage table has to be searched
>   * @volt : the voltage to be searched in the voltage table
>   *
>   * This API searches through the voltage table for the required voltage
> @@ -1126,29 +1133,32 @@ int omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data)
>   * sucess. Returns -ENODATA if no voltage table exisits for the passed voltage
>   * domain or if there is no matching entry.
>   */
> -struct omap_volt_data *omap_get_volt_data(int vdd, unsigned long volt)
> +struct omap_volt_data *omap_get_volt_data(
> +               struct omap_volt_domain *volt_domain, unsigned long volt)
>  {
> -       int i, ret;
> +       struct omap_vdd_info *vdd;
> +       int i;
>
> -       ret = check_voltage_domain(vdd);
> -       if (ret) {
> -               pr_warning("%s: VDD %d does not exist!\n", __func__, vdd + 1);
> -               return ERR_PTR(ret);
> +       if (!volt_domain || IS_ERR(volt_domain)) {
> +               pr_warning("%s: VDD specified does not exist!\n", __func__);
> +               return ERR_PTR(-EINVAL);
>         }
>
> -       if (!vdd_info[vdd].volt_data) {
> -               pr_warning("%s: voltage table does not exist for VDD %d\n",
> -                       __func__, vdd + 1);
> +       vdd = container_of(volt_domain, struct omap_vdd_info, volt_domain);
> +
> +       if (!vdd->volt_data) {
> +               pr_warning("%s: voltage table does not exist for vdd_%s\n",
> +                       __func__, volt_domain->name);
>                 return ERR_PTR(-ENODATA);
>         }
>
> -       for (i = 0; i < vdd_info[vdd].volt_data_count; i++) {
> -               if (vdd_info[vdd].volt_data[i].volt_nominal == volt)
> -                       return &vdd_info[vdd].volt_data[i];
> +       for (i = 0; i < vdd->volt_data_count; i++) {
> +               if (vdd->volt_data[i].volt_nominal == volt)
> +                       return &vdd->volt_data[i];
>         }
>
>         pr_notice("%s: Unable to match the current voltage with the voltage"
> -               "table for VDD %d\n", __func__, vdd + 1);
> +               "table for vdd_%s\n", __func__, volt_domain->name);
>
>         return ERR_PTR(-ENODATA);
>  }
> @@ -1170,6 +1180,33 @@ void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info)
>  }
>
>  /**
> + * omap_volt_domain_get        : API to get the voltage domain pointer
> + * @name : Name of the voltage domain
> + *
> + * This API looks up in the global vdd_info struct for the
> + * existence of voltage domain <name>. If it exists, the API returns
> + * a pointer to the voltage domain structure corresponding to the
> + * VDD<name>. Else retuns error pointer.
> + */
> +struct omap_volt_domain *omap_volt_domain_get(char *name)
> +{
> +       int i;
> +
> +       if (!vdd_info) {
> +               pr_err("%s: Voltage driver init not yet happened.Faulting!\n",
> +                       __func__);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
what if name was NULL?

> +       for (i = 0; i < no_scalable_vdd; i++) {
> +               if (!(strcmp(name, vdd_info[i].volt_domain.name)))
a list walk would have been more scalable.

> +                       return &vdd_info[i].volt_domain;
> +       }
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +/**
>   * omap_voltage_init : Volatage init API which does VP and VC init.
>   */
>  static int __init omap_voltage_init(void)
> @@ -1191,8 +1228,8 @@ static int __init omap_voltage_init(void)
>         }
>         init_voltagecontroller();
>         for (i = 0; i < no_scalable_vdd; i++) {
> -               vdd_data_configure(i);
> -               init_voltageprocesor(i);
> +               vdd_data_configure(&vdd_info[i]);
> +               init_voltageprocesor(&vdd_info[i]);

a list walk would have been preferrable.
>         }
>         return 0;
>  }
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> deleted file mode 100644
> index a7be515..0000000
> --- a/arch/arm/mach-omap2/voltage.h
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -/*
> - * OMAP Voltage Management Routines
> - *
> - * Author: Thara Gopinath      <thara@ti.com>
> - *
> - * Copyright (C) 2009 Texas Instruments, Inc.
> - * Thara Gopinath <thara@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> -#define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> -
> -extern u32 enable_sr_vp_debug;
> -extern struct dentry *pm_dbg_main_dir;
> -
> -/* VoltageDomain instances */
> -#define VDD1   0
> -#define VDD2   1
> -
> -#define VOLTSCALE_VPFORCEUPDATE                1
> -#define VOLTSCALE_VCBYPASS             2
> -
> -/* Voltage SR Parameters for OMAP3*/
> -#define OMAP3_SRI2C_SLAVE_ADDR                 0x12
> -#define OMAP3_VDD1_SR_CONTROL_REG              0x00
> -#define OMAP3_VDD2_SR_CONTROL_REG              0x01
> -
> -/*
> - * Omap3 VP register specific values. Maybe these need to come from
> - * board file or PMIC data structure
> - */
> -#define OMAP3_VP_CONFIG_ERROROFFSET            0x00
> -#define        OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN       0x3C
> -#define OMAP3_VP_VSTEPMIN_VSTEPMIN             0x1
> -#define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX      0x3C
> -#define OMAP3_VP_VSTEPMAX_VSTEPMAX             0x04
> -#define OMAP3_VP_VLIMITTO_TIMEOUT_US           0x200
> -
> -/*
> - * Omap3430 specific VP register values. Maybe these need to come from
> - * board file or PMIC data structure
> - */
> -#define OMAP3430_VP1_VLIMITTO_VDDMIN           0x14
> -#define OMAP3430_VP1_VLIMITTO_VDDMAX           0x42
> -#define OMAP3430_VP2_VLIMITTO_VDDMAX           0x2C
> -#define OMAP3430_VP2_VLIMITTO_VDDMIN           0x18
> -
> -/*
> - * Omap3630 specific VP register values. Maybe these need to come from
> - * board file or PMIC data structure
> - */
> -#define OMAP3630_VP1_VLIMITTO_VDDMIN           0x18
> -#define OMAP3630_VP1_VLIMITTO_VDDMAX           0x3C
> -#define OMAP3630_VP2_VLIMITTO_VDDMIN           0x18
> -#define OMAP3630_VP2_VLIMITTO_VDDMAX           0x30
> -
> -/* TODO OMAP4 VP register values if the same file is used for OMAP4*/
> -
> -/**
> - * omap_volt_data - Omap voltage specific data.
> - *
> - * @voltage_nominal    : The possible voltage value in uV
> - * @sr_nvalue          : Smartreflex N target value at voltage <voltage>
> - * @sr_errminlimit     : Error min limit value for smartreflex. This value
> - *                       differs at differnet opp and thus is linked
> - *                       with voltage.
> - * @vp_errorgain       : Error gain value for the voltage processor. This
> - *                       field also differs according to the voltage/opp.
> - */
> -struct omap_volt_data {
> -       u32     volt_nominal;
> -       u32     sr_nvalue;
> -       u8      sr_errminlimit;
> -       u8      vp_errgain;
> -};
> -
> -/**
> - * omap_volt_pmic_info - PMIC specific data required by the voltage driver.
> - *
> - * @slew_rate  : PMIC slew rate (in uv/us)
> - * @step_size  : PMIC voltage step size (in uv)
> - */
> -struct omap_volt_pmic_info {
> -      int slew_rate;
> -      int step_size;
> -};
> -
> -/* Various voltage controller related info */
> -struct omap_volt_vc_data {
> -       u16 clksetup;
> -       u16 voltsetup_time1;
> -       u16 voltsetup_time2;
> -       u16 voltoffset;
> -       u16 voltsetup2;
> -/* PRM_VC_CMD_VAL_0 specific bits */
> -       u16 vdd0_on;
> -       u16 vdd0_onlp;
> -       u16 vdd0_ret;
> -       u16 vdd0_off;
> -/* PRM_VC_CMD_VAL_1 specific bits */
> -       u16 vdd1_on;
> -       u16 vdd1_onlp;
> -       u16 vdd1_ret;
> -       u16 vdd1_off;
> -};
> -
> -unsigned long omap_voltageprocessor_get_curr_volt(int vp_id);
> -void omap_voltageprocessor_enable(int vp_id);
> -void omap_voltageprocessor_disable(int vp_id);
> -int omap_voltage_scale(int vdd, unsigned long target_volt);
> -void omap_reset_voltage(int vdd);
> -int omap_get_voltage_table(int vdd, struct omap_volt_data **volt_data);
> -struct omap_volt_data *omap_get_volt_data(int vdd, unsigned long volt);
> -void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
> -unsigned long get_curr_voltage(int vdd);
> -#ifdef CONFIG_PM
> -void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
> -#else
> -static inline void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc) {}
> -#endif
> -
> -#endif
> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
> index 1105db0..c5df1f3 100644
> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
> @@ -21,6 +21,7 @@
>  #define __ASM_ARM_OMAP_SMARTREFLEX_H
>
>  #include <linux/platform_device.h>
> +#include <plat/voltage.h>
>
>  /*
>   * Different Smartreflex IPs version. The v1 is the 65nm version used in
> @@ -169,6 +170,8 @@
>   * @test_sennenable    : SENNENABLE test value
>   * @test_senpenable    : SENPENABLE test value.
>   * @test_nvalues       : Array of test ntarget values.
> + * @vdd_name           : Name of the voltage domain associated with this
> + *                       Smartreflex device.
>   */
>  struct omap_sr_dev_data {
>         int volts_supported;
> @@ -179,6 +182,7 @@ struct omap_sr_dev_data {
>         u32 test_sennenable;
>         u32 test_senpenable;
>         u32 *test_nvalues;
> +       char *vdd_name;
one reason why i would prefer to have hwmod for vdd as well.. it is
easier to link up here..
>         struct omap_volt_data *volt_data;
>  };
>
> @@ -217,10 +221,10 @@ struct omap_smartreflex_pmic_data {
>   *             to take any class based decisions.
>   */
>  struct omap_smartreflex_class_data {
> -       int (*enable)(int sr_id);
> -       int (*disable)(int sr_id, int is_volt_reset);
> -       int (*configure)(int sr_id);
> -       int (*notify)(int sr_id, u32 status);
> +       int (*enable)(struct omap_volt_domain *volt_domain);
> +       int (*disable)(struct omap_volt_domain *volt_domain, int is_volt_reset);
> +       int (*configure)(struct omap_volt_domain *volt_domain);
> +       int (*notify)(struct omap_volt_domain *volt_domain, u32 status);
>         u8 notify_flags;
>         u8 class_type;
>  };
> @@ -233,11 +237,13 @@ struct omap_smartreflex_class_data {
>   * @sr_nvalue          : array of n target values for sr
>   * @enable_on_init     : whether this sr module needs to enabled at
>   *                       boot up or not.
> + * @volt_domain                : Pointer to the voltage domain associated with the sr
>   */
>  struct omap_sr_data {
>         u32                             senp_mod;
>         u32                             senn_mod;
>         bool                            enable_on_init;
> +       struct omap_volt_domain         *volt_domain;
>         int (*device_enable)(struct platform_device *pdev);
>         int (*device_shutdown)(struct platform_device *pdev);
>         int (*device_idle)(struct platform_device *pdev);
> @@ -248,15 +254,15 @@ struct omap_sr_data {
>   * NOTE: if smartreflex is not enabled from sysfs, these functions will not
>   * do anything.
>   */
> -void omap_smartreflex_enable(int srid);
> -void omap_smartreflex_disable(int srid);
> -void omap_smartreflex_disable_reset_volt(int srid);
> +void omap_smartreflex_enable(struct omap_volt_domain *volt_domain);
> +void omap_smartreflex_disable(struct omap_volt_domain *volt_domain);
> +void omap_smartreflex_disable_reset_volt(struct omap_volt_domain *volt_domain);
>
>  /* Smartreflex driver hooks to be called from Smartreflex class driver */
> -int sr_enable(int srid, unsigned long volt);
> -void sr_disable(int srid);
> -int sr_configure_errgen(int srid);
> -int sr_configure_minmax(int srid);
> +int sr_enable(struct omap_volt_domain *volt_domain, unsigned long volt);
> +void sr_disable(struct omap_volt_domain *volt_domain);
> +int sr_configure_errgen(struct omap_volt_domain *volt_domain);
> +int sr_configure_minmax(struct omap_volt_domain *volt_domain);
>
>  /* API to register the smartreflex class driver with the smartreflex driver */
>  int omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
> @@ -264,10 +270,13 @@ int omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
>  /* API to register the pmic specific data with the smartreflex driver. */
>  void omap_sr_register_pmic(struct omap_smartreflex_pmic_data *pmic_data);
>  #else
> -static inline void omap_smartreflex_enable(int srid) {}
> -static inline void omap_smartreflex_disable(int srid) {}
> -static inline void omap_smartreflex_disable_reset_volt(int srid) {}
> -static inline void omap_sr_register_pmic
> -               (struct omap_smartreflex_pmic_data *pmic_data) {}
> +static inline void omap_smartreflex_enable(
> +               struct omap_volt_domain *volt_domain) {}
> +static inline void omap_smartreflex_disable(
> +               struct omap_volt_domain *volt_domain) {}
> +static inline void omap_smartreflex_disable_reset_volt(
> +               struct omap_volt_domain *volt_domain) {}
> +static inline void omap_sr_register_pmic(
> +               struct omap_smartreflex_pmic_data *pmic_data) {}
>  #endif
>  #endif
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> new file mode 100644
> index 0000000..b7ac318
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -0,0 +1,137 @@
> +/*
> + * OMAP Voltage Management Routines
> + *
> + * Author: Thara Gopinath      <thara@ti.com>
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + * Thara Gopinath <thara@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> +#define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> +
> +extern u32 enable_sr_vp_debug;
> +extern struct dentry *pm_dbg_main_dir;
> +
> +#define VOLTSCALE_VPFORCEUPDATE                1
> +#define VOLTSCALE_VCBYPASS             2
> +
> +/* Voltage SR Parameters for OMAP3*/
> +#define OMAP3_SRI2C_SLAVE_ADDR                 0x12
> +#define OMAP3_VDD1_SR_CONTROL_REG              0x00
> +#define OMAP3_VDD2_SR_CONTROL_REG              0x01
> +
> +/*
> + * Omap3 VP register specific values. Maybe these need to come from
> + * board file or PMIC data structure
> + */
> +#define OMAP3_VP_CONFIG_ERROROFFSET            0x00
> +#define        OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN       0x3C
> +#define OMAP3_VP_VSTEPMIN_VSTEPMIN             0x1
> +#define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX      0x3C
> +#define OMAP3_VP_VSTEPMAX_VSTEPMAX             0x04
> +#define OMAP3_VP_VLIMITTO_TIMEOUT_US           0x200
> +
> +/*
> + * Omap3430 specific VP register values. Maybe these need to come from
> + * board file or PMIC data structure
> + */
> +#define OMAP3430_VP1_VLIMITTO_VDDMIN           0x14
> +#define OMAP3430_VP1_VLIMITTO_VDDMAX           0x42
> +#define OMAP3430_VP2_VLIMITTO_VDDMAX           0x2C
> +#define OMAP3430_VP2_VLIMITTO_VDDMIN           0x18
> +
> +/*
> + * Omap3630 specific VP register values. Maybe these need to come from
> + * board file or PMIC data structure
> + */
> +#define OMAP3630_VP1_VLIMITTO_VDDMIN           0x18
> +#define OMAP3630_VP1_VLIMITTO_VDDMAX           0x3C
> +#define OMAP3630_VP2_VLIMITTO_VDDMIN           0x18
> +#define OMAP3630_VP2_VLIMITTO_VDDMAX           0x30

it just does not make sense to expose these publically. no one should be
using them anyway.. use hwmod instead.

> +
> +/* TODO OMAP4 VP register values if the same file is used for OMAP4*/
> +
> +/**
> + * omap_voltagedomain - omap voltage domain global structure
> + *
> + * @name       : Name of the voltage domain which can be used as a unique
> + *               identifier.
> + */
> +struct omap_volt_domain {
> +       char *name;
> +};
> +
> +/**
> + * omap_volt_data - Omap voltage specific data.
> + *
just a side nitpick comment kernel-doc-nano (no eol here) - for all func
and structure
> + * @voltage_nominal    : The possible voltage value in uV
> + * @sr_nvalue          : Smartreflex N target value at voltage <voltage>
> + * @sr_errminlimit     : Error min limit value for smartreflex. This value
> + *                       differs at differnet opp and thus is linked
> + *                       with voltage.
> + * @vp_errorgain       : Error gain value for the voltage processor. This
> + *                       field also differs according to the voltage/opp.
> + */
> +struct omap_volt_data {
> +       u32     volt_nominal;
> +       u32     sr_nvalue;
> +       u8      sr_errminlimit;
> +       u8      vp_errgain;
> +};
> +
> +/**
> + * omap_volt_pmic_info - PMIC specific data required by the voltage driver.
> + *
> + * @slew_rate  : PMIC slew rate (in uv/us)
> + * @step_size  : PMIC voltage step size (in uv)
> + */
> +struct omap_volt_pmic_info {
> +      int slew_rate;
> +      int step_size;
> +};
> +
> +/* Various voltage controller related info */
kdoc comment?
> +struct omap_volt_vc_data {
> +       u16 clksetup;
> +       u16 voltsetup_time1;
> +       u16 voltsetup_time2;
> +       u16 voltoffset;
> +       u16 voltsetup2;
> +/* PRM_VC_CMD_VAL_0 specific bits */
in kdoc please
> +       u16 vdd0_on;
> +       u16 vdd0_onlp;
> +       u16 vdd0_ret;
> +       u16 vdd0_off;
> +/* PRM_VC_CMD_VAL_1 specific bits */
> +       u16 vdd1_on;
> +       u16 vdd1_onlp;
> +       u16 vdd1_ret;
> +       u16 vdd1_off;
> +};
> +
> +struct omap_volt_domain *omap_volt_domain_get(char *name);
> +void omap_voltage_register_pmic(struct omap_volt_pmic_info *pmic_info);
> +unsigned long omap_voltageprocessor_get_curr_volt(
> +               struct omap_volt_domain *volt_domain);
> +void omap_voltageprocessor_enable(struct omap_volt_domain *volt_domain);
> +void omap_voltageprocessor_disable(struct omap_volt_domain *volt_domain);
> +int omap_voltage_scale(struct omap_volt_domain *volt_domain,
> +               unsigned long target_volt);
> +void omap_reset_voltage(struct omap_volt_domain *volt_domain);
> +int omap_get_voltage_table(struct omap_volt_domain *volt_domain,
> +                                       struct omap_volt_data **volt_data);
> +struct omap_volt_data *omap_get_volt_data(
> +               struct omap_volt_domain *volt_domain, unsigned long volt);
> +unsigned long get_curr_voltage(struct omap_volt_domain *volt_domain);
> +#ifdef CONFIG_PM
> +void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc);
> +#else
> +static inline void omap_voltage_init_vc(struct omap_volt_vc_data *setup_vc) {}
> +#endif
> +
generic comment for exposed public function a oneliner giving a brief
idea about what it could do might help users who usually check header to
see the func..

> +#endif
> --
> 1.7.0.rc1.33.g07cf0f
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Regards,
Nishanth Menon

