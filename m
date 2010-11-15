From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
 OMAP3
Date: Mon, 15 Nov 2010 16:17:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E58@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-2-git-send-email-thara@ti.com>
 <87bp5x80nx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49935 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006Ab0KOKrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 05:47:21 -0500
In-Reply-To: <87bp5x80nx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, November 11, 2010 12:30 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
>>OMAP3
>>
>>[resend with thinned out response, since original reply was determined
>> to be spam by vger.kernel.org.  wondering that tells me about my review
>> style... ]
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds voltage driver support for OMAP3. The driver
>>> allows  configuring the voltage controller and voltage
>>> processors during init and exports APIs to enable/disable
>>> voltage processors, scale voltage and reset voltage.
>>> The driver also maintains the global voltage table on a per
>>> VDD basis which contains the various voltages supported by the
>>> VDD along with per voltage dependent data like smartreflex
>>> n-target value, errminlimit and voltage processor errorgain.
>>> The driver allows scaling of VDD voltages either through
>>> "vc bypass method" or through "vp forceupdate method" the
>>> choice being configurable through the board file.
>>>
>>> This patch contains code originally in linux omap pm branch
>>> smartreflex driver.  Major contributors to this driver are
>>> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
>>> Nishant Menon, Kevin Hilman.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>All comments below are cut-and-paste from v3 review, and were not
>>addressed in this update.

Hello Kevin,

Thanks for the review. I thought I had fixed most of the v3 comments
except the ones about the n-target values. Sorry if I had missed some.

>>
>>[...]
>>
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -0,0 +1,1158 @@
>>> +/*
>>> + * OMAP3/OMAP4 Voltage Management Routines
>>> + *
>>> + * Author: Thara Gopinath  <thara@ti.com>
>>> + *
>>> + * Copyright (C) 2007 Texas Instruments, Inc.
>>> + * Rajendra Nayak <rnayak@ti.com>
>>> + * Lesly A M <x0080970@ti.com>
>>> + *
>>> + * Copyright (C) 2008 Nokia Corporation
>>> + * Kalle Jokiniemi
>>> + *
>>> + * Copyright (C) 2010 Texas Instruments, Inc.
>>> + * Thara Gopinath <thara@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <plat/common.h>
>>> +#include <plat/voltage.h>
>>> +
>>> +#include "prm-regbits-34xx.h"
>>> +
>>> +#define VP_IDLE_TIMEOUT            200
>>> +#define VP_TRANXDONE_TIMEOUT       300
>>> +#define VOLTAGE_DIR_SIZE   16
>>> +
>>> +static struct dentry *voltage_dir;
>>> +/* PRM voltage module */
>>> +static u32 volt_mod;
>>
>>There's no need for this to be a global, this should be a member of
>>vdd_info (or the voltage domain.)  That means the read/write functions
>>will have to take an additional argument (vdd or voltdm) but that's
>>cleaner to me.

Ok.

>>
>>[...]
>>
>>> +/* OMAP3 specific voltage init functions */
>>> +/*
>>> + * Intializes the voltage controller registers with the PMIC and board
>>> + * specific parameters and voltage setup times for OMAP3. If the board
>>> + * file does not populate the voltage controller parameters through
>>> + * omap3_pm_init_vc, default values specified in vc_config is used.
>>> + */
>>> +static void __init omap3_init_voltagecontroller(void)
>>
>>I'd like to see consistent naming.  Elsewhere in the code, things are
>>named with either a vdd, vc or vp prefix.  Let's keep that here and call
>>this omap3_vc_init(), and for VP below, s/init_voltagecontroller/vp_init/

Will rename

>>
>>[...]
>>
>>> +   /*
>>> +    * Sys clk rate is require to calculate vp timeout value and
>>> +    * smpswaittimemin and smpswaittimemax.
>>> +    */
>>> +   sys_ck = clk_get(NULL, "sys_ck");
>>> +   if (IS_ERR(sys_ck)) {
>>> +           pr_warning("%s: Could not get the sys clk to calculate"
>>> +                   "various vdd_%s params\n", __func__, vdd->voltdm.name);
>>> +           return;
>>> +   }
>>> +   sys_clk_speed = clk_get_rate(sys_ck);
>>> +   clk_put(sys_ck);
>>> +   /* Divide to avoid overflow */
>>> +   sys_clk_speed /= 1000;
>>> +
>>> +   /* Nominal/Reset voltage of the VDD */
>>> +   vdd->nominal_volt = vdd->curr_volt = 1200000;
>>
>>This should be a #define someplace, something like OMAP3_VDDx_RESET_VOL
>>or similar.  Ideally with a TRM/doc reference to where it comes from.
>>
>>I'm a little confused. Is this a hardware reset value? or a software
>>reset value which is part of this layer.
>>
>>It's a little confusing, since if this is a hardware reset voltage why
>>does init_voltageprocessor() have to write it to the VP during init?
>>
>>Even better, rather than hard code this, it would be even better if it
>>just picked one of the nominal voltages from the volt_data table.

Yes this is the default voltage at which the hardware will boot up.
I had to add this since some errata workarounds requires the vdd to be put to
this level even though this level might not correspond to any opp. The voltage scaling APIs get the error gain from a table corresponding to voltage and might not find an entry for this voltage and hence will fail. I do a check in the scaling APIs if not errorgain is found, is the voltage equal to nominal voltage and if yes I go ahead with the voltage scaling. Maybe I will remove this variable and allow the scaling APIs to scale voltage even if the table does not contain the entry.

>>
>>[...]
>>
>>> +/* vc_bypass_scale_voltage - VC bypass method of voltage scaling */
>>> +static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
>>> +           unsigned long target_volt)
>>> +{
>>> +   struct omap_volt_data *volt_data;
>>> +   u32 vc_bypass_value, vc_cmdval, vc_valid, vc_bypass_val_reg_offs;
>>> +   u32 vp_errgain_val, vc_cmd_on_mask;
>>> +   u32 loop_cnt = 0, retries_cnt = 0;
>>> +   u32 smps_steps = 0, smps_delay = 0;
>>> +   u8 vc_data_shift, vc_slaveaddr_shift, vc_regaddr_shift;
>>> +   u8 vc_cmd_on_shift;
>>> +   u8 target_vsel, current_vsel, sr_i2c_slave_addr;
>>> +
>>> +   if (cpu_is_omap34xx()) {
>>> +           vc_cmd_on_shift = OMAP3430_VC_CMD_ON_SHIFT;
>>> +           vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
>>> +           vc_data_shift = OMAP3430_DATA_SHIFT;
>>> +           vc_slaveaddr_shift = OMAP3430_SLAVEADDR_SHIFT;
>>> +           vc_regaddr_shift = OMAP3430_REGADDR_SHIFT;
>>> +           vc_valid = OMAP3430_VALID_MASK;
>>> +           vc_bypass_val_reg_offs = OMAP3_PRM_VC_BYPASS_VAL_OFFSET;
>>> +           sr_i2c_slave_addr = OMAP3_SRI2C_SLAVE_ADDR;
>>> +   } else {
>>> +           pr_warning("%s: Voltage scaling not yet enabled for"
>>> +                   "this chip\n", __func__);
>>> +           return -EINVAL;
>>> +   }
>>
>>cpu_is_* checks are only acceptable at init time.  This one happens
>>during every scale.  These VC settings should be set at init time only.
>>
>>Same issue with forceupdate_scale.

These masks are needed only in vc bypass voltage scaling API. I was thinking that for using in just one API I need not maintain these variables in the generic vdd structure. But yes this will add a cpu_is_* check in this API.
Is it preferred to have these variables defined in the common vdd structures and populated during init even if used only in one API?

>>
>>[...]
>>
>>> +/* VP force update method of voltage scaling */
>>> +static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>>> +           unsigned long target_volt)
>>> +{
>>> +   struct omap_volt_data *volt_data;
>>> +   u32 vc_cmd_on_mask, vc_cmdval, vpconfig;
>>> +   u32 smps_steps = 0, smps_delay = 0;
>>> +   int timeout = 0;
>>> +   u8 target_vsel, current_vsel;
>>> +   u8 vc_cmd_on_shift;
>>> +   u8 prm_irqst_reg_offs, ocp_mod;
>>> +
>>> +   if (cpu_is_omap34xx()) {
>>> +           vc_cmd_on_shift = OMAP3430_VC_CMD_ON_SHIFT;
>>> +           vc_cmd_on_mask = OMAP3430_VC_CMD_ON_MASK;
>>> +           prm_irqst_reg_offs = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
>>> +           ocp_mod = OCP_MOD;
>>> +   } else {
>>> +           pr_warning("%s: Voltage scaling not yet enabled for"
>>> +                   "this chip\n", __func__);
>>> +           return -EINVAL;
>>> +   }
>>> +
>>> +   /* Get volt_data corresponding to the target_volt */
>>> +   volt_data = omap_voltage_get_voltdata(&vdd->voltdm, target_volt);
>>> +   if (IS_ERR(volt_data)) {
>>> +           /*
>>> +            * If a match is not found but the target voltage is
>>> +            * is the nominal vdd voltage allow scaling
>>> +            */
>>> +           if (target_volt != vdd->nominal_volt) {
>>> +                   pr_warning("%s: Unable to get voltage table for vdd_%s"
>>> +                           "during voltage scaling. Some really Wrong!",
>>> +                           __func__, vdd->voltdm.name);
>>> +                   return -ENODATA;
>>> +           }
>>> +           volt_data = NULL;
>>> +   }
>>> +
>>> +   if (!volt_pmic_info.uv_to_vsel) {
>>> +           pr_warning("%s: PMIC function to convert voltage in uV to"
>>> +                   "vsel not registered. Hence unable to scale voltage"
>>> +                   "for vdd_%s\n", __func__, vdd->voltdm.name);
>>> +           return -ENODATA;
>>> +   }
>>> +
>>> +   target_vsel = volt_pmic_info.uv_to_vsel(target_volt);
>>> +   current_vsel = voltage_read_reg(vdd->vp_offs.voltage);
>>> +   smps_steps = abs(target_vsel - current_vsel);
>>> +
>>> +   /* Setting the ON voltage to the new target voltage */
>>> +   vc_cmdval = voltage_read_reg(vdd->cmdval_reg);
>>> +   vc_cmdval &= ~vc_cmd_on_mask;
>>> +   vc_cmdval |= (target_vsel << vc_cmd_on_shift);
>>> +   voltage_write_reg(vdd->cmdval_reg, vc_cmdval);
>>> +
>>
>>Up 'til here, this looks almost exactly like the vc_bypass version.
>>Maybe they can be combined into a common pre-scale function?
>>
>>> +   /* Getting  vp errorgain based on the voltage */
>>> +   if (volt_data)
>>> +           vdd->vp_reg.vpconfig_errorgain =
>>> +                                   volt_data->vp_errgain;
>>
>>This also looks similar to the vc_bypass version.
>>
>>After the full-series is applied, the comments are identical, but the
>>code is different.  I suspect they should be the same though.   Possibly
>>a good reason to have a common pre-scale function.

I will try combining into a common pre-scale fn. Not sure how many of these
steps are common but will give it a try for sure

>>
>>> +
>>> +   /*
>>> +    * Clear all pending TransactionDone interrupt/status. Typical latency
>>> +    * is <3us
>>> +    */
>>> +   while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>>> +           prm_write_mod_reg(vdd->vp_reg.tranxdone_status,
>>> +                           ocp_mod, prm_irqst_reg_offs);
>>> +           if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
>>> +                           vdd->vp_reg.tranxdone_status))
>>> +                           break;
>>> +           udelay(1);
>>> +   }
>>> +   if (timeout >= VP_TRANXDONE_TIMEOUT) {
>>> +           pr_warning("%s: vdd_%s TRANXDONE timeout exceeded."
>>> +                   "Voltage change aborted", __func__, vdd->voltdm.name);
>>> +           return -ETIMEDOUT;
>>> +   }
>>> +
>>> +   /* Configure for VP-Force Update */
>>> +   vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
>>> +   vpconfig &= ~(vdd->vp_reg.vpconfig_initvdd |
>>> +                   vdd->vp_reg.vpconfig_forceupdate |
>>> +                   vdd->vp_reg.vpconfig_initvoltage_mask |
>>> +                   vdd->vp_reg.vpconfig_errorgain_mask);
>>> +   vpconfig |= ((target_vsel <<
>>> +                   vdd->vp_reg.vpconfig_initvoltage_shift) |
>>> +                   (vdd->vp_reg.vpconfig_errorgain <<
>>> +                    vdd->vp_reg.vpconfig_errorgain_shift));
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +
>>> +   /* Trigger initVDD value copy to voltage processor */
>>> +   vpconfig |= vdd->vp_reg.vpconfig_initvdd;
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +
>>> +   /* Force update of voltage */
>>> +   vpconfig |= vdd->vp_reg.vpconfig_forceupdate;
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +
>>> +   /*
>>> +    * Wait for TransactionDone. Typical latency is <200us.
>>> +    * Depends on SMPSWAITTIMEMIN/MAX and voltage change
>>> +    */
>>> +   timeout = 0;
>>> +   omap_test_timeout((prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
>>> +                   vdd->vp_reg.tranxdone_status),
>>> +                   VP_TRANXDONE_TIMEOUT, timeout);
>>> +   if (timeout >= VP_TRANXDONE_TIMEOUT)
>>> +           pr_err("%s: vdd_%s TRANXDONE timeout exceeded."
>>> +                   "TRANXDONE never got set after the voltage update\n",
>>> +                   __func__, vdd->voltdm.name);
>>> +
>>> +   /*
>>> +    * Wait for voltage to settle with SW wait-loop.
>>> +    * SMPS slew rate / step size. 2us added as buffer.
>>> +    */
>>> +   smps_delay = ((smps_steps * volt_pmic_info.step_size) /
>>> +                   volt_pmic_info.slew_rate) + 2;
>>> +   udelay(smps_delay);
>>> +
>>> +   /*
>>> +    * Disable TransactionDone interrupt , clear all status, clear
>>> +    * control registers
>>> +    */
>>> +   timeout = 0;
>>> +   while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>>> +           prm_write_mod_reg(vdd->vp_reg.tranxdone_status,
>>> +                           ocp_mod, prm_irqst_reg_offs);
>>> +           if (!(prm_read_mod_reg(ocp_mod, prm_irqst_reg_offs) &
>>> +                           vdd->vp_reg.tranxdone_status))
>>> +                           break;
>>> +           udelay(1);
>>> +   }
>>> +   if (timeout >= VP_TRANXDONE_TIMEOUT)
>>> +           pr_warning("%s: vdd_%s TRANXDONE timeout exceeded while trying"
>>> +                   "to clear the TRANXDONE status\n",
>>> +                   __func__, vdd->voltdm.name);
>>> +
>>> +   vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
>>> +   /* Clear initVDD copy trigger bit */
>>> +   vpconfig &= ~vdd->vp_reg.vpconfig_initvdd;;
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +   /* Clear force bit */
>>> +   vpconfig &= ~vdd->vp_reg.vpconfig_forceupdate;
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +
>>> +   vdd->curr_volt = target_volt;
>>
>>The smps_delay part and updating ->curr_volt is common to the two scale
>>methods too.  Maybe can be combined into a post-scale common function.

Will do this.

>>
>>> +
>>> +   return 0;
>>> +}
>>
>>[...]
>>
>>> +void omap_vp_enable(struct voltagedomain *voltdm)
>>> +{
>>> +   struct omap_vdd_info *vdd;
>>> +   u32 vpconfig;
>>> +
>>> +   if (!voltdm || IS_ERR(voltdm)) {
>>> +           pr_warning("%s: VDD specified does not exist!\n", __func__);
>>> +           return;
>>> +   }
>>> +
>>> +   vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>> +
>>> +   /* If VP is already enabled, do nothing. Return */
>>> +   if (voltage_read_reg(vdd->vp_offs.vpconfig) &
>>> +                           vdd->vp_reg.vpconfig_vpenable)
>>> +           return;
>>
>>Minor: is a register access here required?  Why not just keep an
>>'vp_enabled' flag as part of the vdd struct?

I do not want to have the complications of maintaining a flag and ensuring exclusivity. But do you think having a register read here is bad? Latency cannot be much as it is a single register read. If you really think we should have a flag, I can change it.

>>
>>> +   /*
>>> +    * This latching is required only if VC bypass method is used for
>>> +    * voltage scaling during dvfs.
>>> +    */
>>> +   if (!voltscale_vpforceupdate)
>>> +           vp_latch_vsel(vdd);
>>> +
>>> +   /* Enable VP */
>>> +   vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig,
>>> +                           vpconfig | vdd->vp_reg.vpconfig_vpenable);
>>> +}
>>> +
>>> +/**
>>> + * omap_vp_disable() - API to disable a particular VP
>>> + * @voltdm:        pointer to the VDD whose VP is to be disabled.
>>> + *
>>> + * This API disables a particular voltage processor. Needed by the
>>smartreflex
>>> + * class drivers.
>>> + */
>>> +void omap_vp_disable(struct voltagedomain *voltdm)
>>> +{
>>> +   struct omap_vdd_info *vdd;
>>> +   u32 vpconfig;
>>> +   int timeout;
>>> +
>>> +   if (!voltdm || IS_ERR(voltdm)) {
>>> +           pr_warning("%s: VDD specified does not exist!\n", __func__);
>>> +           return;
>>> +   }
>>> +
>>> +   vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>> +
>>> +   /* If VP is already disabled, do nothing. Return */
>>> +   if (!(voltage_read_reg(vdd->vp_offs.vpconfig) &
>>> +                           vdd->vp_reg.vpconfig_vpenable)) {
>>> +           pr_warning("%s: Trying to disable VP for vdd_%s when"
>>> +                   "it is already disabled\n", __func__, voltdm->name);
>>> +           return;
>>> +   }
>>
>>Same here... is a register read really needed if we can just check
>>vdd->vp_enabled?
>>
>>> +
>>> +   /* Disable VP */
>>> +   vpconfig = voltage_read_reg(vdd->vp_offs.vpconfig);
>>> +   vpconfig &= ~vdd->vp_reg.vpconfig_vpenable;
>>> +   voltage_write_reg(vdd->vp_offs.vpconfig, vpconfig);
>>> +
>>> +   /*
>>> +    * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
>>> +    */
>>> +   omap_test_timeout((voltage_read_reg(vdd->vp_offs.vstatus)),
>>> +                           VP_IDLE_TIMEOUT, timeout);
>>> +
>>> +   if (timeout >= VP_IDLE_TIMEOUT)
>>> +           pr_warning("%s: vdd_%s idle timedout\n",
>>> +                   __func__, voltdm->name);
>>> +   return;
>>> +}
>>> +
>>> +/**
>>> + * omap_voltage_scale_vdd() - API to scale voltage of a particular
>>> + *                         voltage domain.
>>> + * @voltdm:        pointer to the VDD which is to be scaled.
>>> + * @target_volt:   The target voltage of the voltage domain
>>> + *
>>> + * This API should be called by the kernel to do the voltage scaling
>>> + * for a particular voltage domain during dvfs or any other situation.
>>> + */
>>> +int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
>>> +           unsigned long target_volt)
>>> +{
>>> +   struct omap_vdd_info *vdd;
>>> +
>>> +   if (!voltdm || IS_ERR(voltdm)) {
>>> +           pr_warning("%s: VDD specified does not exist!\n", __func__);
>>> +           return -EINVAL;
>>> +   }
>>> +
>>> +   vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>> +
>>> +   if (voltscale_vpforceupdate)
>>> +           return vp_forceupdate_scale_voltage(vdd, target_volt);
>>> +   else
>>> +           return vc_bypass_scale_voltage(vdd, target_volt);
>>
>>Rather than the 'if' here, let's have a 'scale' function pointer
>>associated with the VDD which gets updated if the method changes.
>>
>>Not sure if would ever be useful, but that would also allow the scale
>>method to be different across VDDs instead of having it global.

Sounds good to me. Only we will be maintaining a fn ptr per vdd basis
for scaling the vdd. But then it is ok.

>>
>>[...]
>>
>>> +void omap_change_voltscale_method(int voltscale_method)
>>> +{
>>> +   switch (voltscale_method) {
>>> +   case VOLTSCALE_VPFORCEUPDATE:
>>> +           voltscale_vpforceupdate = true;
>>> +           return;
>>> +   case VOLTSCALE_VCBYPASS:
>>> +           voltscale_vpforceupdate = false;
>>> +           return;
>>> +   default:
>>> +           pr_warning("%s: Trying to change the method of voltage scaling"
>>> +                   "to an unsupported one!\n", __func__);
>>> +   }
>>> +}
>>
>>And this API should be changed to take a 'vdd' and just change the
>>'scale' function pointer.

Ok.

Regards
Thara
