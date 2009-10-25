From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Sun, 25 Oct 2009 23:12:59 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DDDFCC3C@dnce01.ent.ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
 <1256361352-9968-1-git-send-email-nm@ti.com>
 <1256361352-9968-2-git-send-email-nm@ti.com>
 <1256361352-9968-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbZJYWNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Oct 2009 18:13:19 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1256361352-9968-3-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>, "Sabatier, Sebastien" <s-sabatier1@ti.com>

Hi Nishanth,

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>
> Refactor the smart reflex implementation.

[snip]

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-
> omap2/smartreflex.c
> new file mode 100644
> index 0000000..d506896
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -0,0 +1,1604 @@
> +/*
> + * linux/arch/arm/mach-omap3/smartreflex.c
> + *
> + * OMAP34XX SmartReflex Voltage Control
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + * Nishanth Menon
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + * Kalle Jokiniemi
> + *
> + * Copyright (C) 2007 Texas Instruments, Inc.
> + * Lesly A M <x0080970@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/sysfs.h>
> +#include <linux/kobject.h>
> +#include <linux/i2c/twl4030.h>
> +#include <linux/io.h>
> +#include <linux/debugfs.h>
> +
> +#include <plat/omap34xx.h>
> +#include <plat/control.h>
> +#include <plat/clock.h>
> +#include <plat/omap-pm.h>
> +#include <plat/resource.h>
> +#include <plat/powerdomain.h>
> +
> +#include "prm.h"
> +#include "smartreflex.h"
> +#include "prm-regbits-34xx.h"
> +
> +/* MCUDISACK is expected to happen within 1uSec. */
> +#define COUNT_TIMEOUT_MCUDISACK              200
> +
> +/* VPINIDLE is expected to happen within 100uSec. Typical is 2uSec */
> +#define COUNT_TIMEOUT_VPINIDLE               200
> +
> +/* Time taken for setting the device - worst case as FS I2C
> + * Depends on SMPSWAITIME MIN/MAX Typical is 200uSec
> + */
> +#define COUNT_TIMEOUT_TRANSDONE_SET  400
> +
> +/* Time to clear out multiple transdone events typical is 3uSec */
> +#define COUNT_TIMEOUT_TRANSDONE_CLR  50
> +
> +/* Time For VCBypass mode for TWL4030 derivative chip. */
> +#define COUNT_TIMEOUT_TWL4030_VCBYPASS       500
> +
> +/* How many retries to do for I2C errors seen on bus for Forceupdate? */
> +#define COUNT_RETRY_SMPSNOACK                4
> +
> +#define SR_REGADDR(offset)   (sr->srbase_addr + (offset))
> +
> +/* Which function to use for setting voltage */
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +#define SR_CHOSEN_VOLTAGE_UPDATE_MECH  sr_vc_bypass
> +#else
> +#define SR_CHOSEN_VOLTAGE_UPDATE_MECH  sr_vp_forceupdate
> +#endif
> +
> +#ifdef CONFIG_OMAP_PM_NONE
> +struct omap_opp *mpu_opps;
> +struct omap_opp *dsp_opps;
> +struct omap_opp *l3_opps;
> +#endif
> +
> +static ssize_t omap_sr_vdd_autocomp_show(struct kobject *kobj,
> +                                      struct kobj_attribute *attr,
> +                                      char *buf);
> +static ssize_t omap_sr_vdd_autocomp_store(struct kobject *kobj,
> +                                       struct kobj_attribute *attr,
> +                                       const char *buf, size_t n);
> +/* Structure for Voltage processor */
> +struct omap_sr_vp {
> +     /* Store the commonly used register offsets.
> +      * this saves a if condition decision
> +      */
> +     u16 prm_vpx_status_offset;
> +     u16 prm_vpx_config_offset;
> +     u16 prm_vpx_stepmin_offset;
> +     u16 prm_vpx_stepmax_offset;
> +     u16 prm_vpx_limito_offset;
> +     u32 prm_vpx_vlimito_timeout;
> +     u8 prm_vpx_vlimito_shift;
> +     u16 prm_vpx_voltage_offset;
> +     u16 prm_vc_cmd_val_offset;
> +     /* Store the defaults
> +      * allowing us to save OCP read
> +      * operation
> +      */
> +     u32 vpconfig_value;
> +     u32 vpstepmin_value;
> +     u32 vpstepmax_value;
> +     u32 vplimito_value;
> +     u32 vpenable_mask;
> +     u32 irqmask_trans_done;
> +     u32 irqmask_smps_noack;
> +};
> +
> +/* Structure for Smart Reflex */
> +struct omap_sr {
> +     u8 srid;
> +     u8 prcm_vdd;
> +     char *vdd_name;
> +     struct kobj_attribute autocom_attr;
> +     struct omap_opp **omap_opp;
> +     /* SR activity marker */
> +     u8 is_sr_reset;
> +     u8 is_autocomp_active;
> +     u32 req_opp_no;
> +     u32 sr_config_value;
> +     u32 sr_errconfig_value;
> +     u32 sr_n_mod_mask;
> +     u8 sr_n_mod_shift;
> +     u32 sr_p_mod_mask;
> +     u8 sr_p_mod_shift;
> +     struct clk *fclk;
> +     struct clk *iclk;
> +     void __iomem *srbase_addr;
> +     char *iclk_name;
> +     char *fclk_name;
> +     /* Voltage processor for the specific SR module */
> +     struct omap_sr_vp vp;
> +     /* This will contain the register offset on
> +      * boot, replaced with the actual value
> +      * as part of init routine
> +      */
> +     u8 num_opp;
> +     u8 opp_boundary;
> +     u32 opp_nvalue[];
> +};
> +
> +/* A superset of all SRs in the system ordered by SRID */
> +struct omap_sr_list {
> +     u8 num_sr;
> +     struct omap_sr *sr_list[];
> +};
> +
> +/* Definitions for 3430 Silicon */
> +/* Smart Reflex 1 structure */
> +static __initdata struct omap_sr omap34xx_sr1 = {
> +     /* *INDENT-OFF* */
> +     .srid                   = SR1,
> +     .prcm_vdd               = PRCM_VDD1,
> +     .vdd_name               = "vdd1_opp",
> +     .omap_opp               = &mpu_opps,
> +     .autocom_attr           = {
> +             .attr = {
> +                      .name = __stringify(sr_vdd1_autocomp),
> +                      .mode = 0644,
> +                      },
> +             .show = omap_sr_vdd_autocomp_show,
> +             .store = omap_sr_vdd_autocomp_store,
> +     },
> +     .is_sr_reset            = 1,
> +     .is_autocomp_active     = 0,
> +     .srbase_addr            = (void *)OMAP34XX_SR1_BASE,
> +     .fclk_name              = "sr1_fck",
> +     .iclk_name              = "sr_l4_ick",
> +     .sr_errconfig_value     = SR1_ERRWEIGHT | SR1_ERRMAXLIMIT |
> +             ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST |
> +             SR_CLKACTIVITY_IOFF_FON,
> +     .sr_n_mod_mask          = OMAP343X_SR1_SENNENABLE_MASK,
> +     .sr_n_mod_shift         = OMAP343X_SR1_SENNENABLE_SHIFT,
> +     .sr_p_mod_mask          = OMAP343X_SR1_SENPENABLE_MASK,
> +     .sr_p_mod_shift         = OMAP343X_SR1_SENPENABLE_SHIFT,
> +     .vp = {
> +             .prm_vpx_status_offset  = OMAP3_PRM_VP1_STATUS_OFFSET,
> +             .prm_vpx_config_offset  = OMAP3_PRM_VP1_CONFIG_OFFSET,
> +             .prm_vpx_stepmin_offset = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
> +             .prm_vpx_stepmax_offset = OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
> +             .prm_vpx_limito_offset  = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
> +             .prm_vpx_vlimito_timeout = PRM_VP1_VLIMITTO_TIMEOUT_US,
> +             .prm_vpx_vlimito_shift = PRM_VP1_VLIMITTO_TIMEOUT_SHIFT,
> +             .prm_vpx_voltage_offset = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
> +             .prm_vc_cmd_val_offset = OMAP3_PRM_VC_CMD_VAL_0_OFFSET,
> +             .vpconfig_value         = PRM_VP1_CONFIG_ERROROFFSET |
> +                     PRM_VP1_CONFIG_TIMEOUTEN,
> +             .vpstepmin_value        = PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> +                     PRM_VP1_VSTEPMIN_VSTEPMIN,
> +             .vpstepmax_value        = PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
> +                     PRM_VP1_VSTEPMAX_VSTEPMAX,
> +             .vplimito_value         = PRM_VP1_VLIMITTO_VDDMAX |
> +                     PRM_VP1_VLIMITTO_VDDMIN,
> +             .vpenable_mask          = PRM_VP1_CONFIG_VPENABLE,
> +             .irqmask_trans_done     = VP1_IRQMASK_TRANSDONE,
> +             .irqmask_smps_noack     = OMAP3430_VP1_NOSMPSACK_ST,
> +     },
> +     .num_opp                = 5,
> +     .opp_boundary           = 3,
> +     .opp_nvalue             = {
> +                 OMAP343X_CONTROL_FUSE_OPP1_VDD1,
> +                 OMAP343X_CONTROL_FUSE_OPP2_VDD1,
> +                 OMAP343X_CONTROL_FUSE_OPP3_VDD1,
> +                 OMAP343X_CONTROL_FUSE_OPP4_VDD1,
> +                 OMAP343X_CONTROL_FUSE_OPP5_VDD1,
> +     },
> +             /* *INDENT-ON* */
> +};
> +
> +/* Smart Reflex 2 structure */
> +static __initdata struct omap_sr omap34xx_sr2 = {
> +     /* *INDENT-OFF* */
> +     .srid                   = SR2,
> +     .prcm_vdd               = PRCM_VDD2,
> +     .vdd_name               = "vdd2_opp",
> +     .omap_opp               = &l3_opps,
> +     .autocom_attr           = {
> +             .attr = {
> +                      .name = __stringify(sr_vdd2_autocomp),
> +                      .mode = 0644,
> +                      },
> +             .show = omap_sr_vdd_autocomp_show,
> +             .store = omap_sr_vdd_autocomp_store,
> +     },
> +     .is_sr_reset            = 1,
> +     .is_autocomp_active     = 0,
> +     .srbase_addr            = (void *)OMAP34XX_SR2_BASE,
> +     .fclk_name              = "sr2_fck",
> +     .iclk_name              = "sr_l4_ick",
> +     .sr_errconfig_value     = SR2_ERRWEIGHT | SR2_ERRMAXLIMIT |
> +             ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST |
> +             SR_CLKACTIVITY_IOFF_FON,
> +     .sr_n_mod_mask          = OMAP343X_SR2_SENNENABLE_MASK,
> +     .sr_n_mod_shift         = OMAP343X_SR2_SENNENABLE_SHIFT,
> +     .sr_p_mod_mask          = OMAP343X_SR2_SENPENABLE_MASK,
> +     .sr_p_mod_shift         = OMAP343X_SR2_SENPENABLE_SHIFT,
> +     .vp = {
> +             .prm_vpx_status_offset  = OMAP3_PRM_VP2_STATUS_OFFSET,
> +             .prm_vpx_config_offset  = OMAP3_PRM_VP2_CONFIG_OFFSET,
> +             .prm_vpx_stepmin_offset = OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
> +             .prm_vpx_stepmax_offset = OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
> +             .prm_vpx_limito_offset  = OMAP3_PRM_VP2_VLIMITTO_OFFSET,
> +             .prm_vpx_vlimito_timeout = PRM_VP2_VLIMITTO_TIMEOUT_US,
> +             .prm_vpx_vlimito_shift = PRM_VP2_VLIMITTO_TIMEOUT_SHIFT,
> +             .prm_vpx_voltage_offset = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
> +             .prm_vc_cmd_val_offset = OMAP3_PRM_VC_CMD_VAL_1_OFFSET,
> +             .vpconfig_value         = PRM_VP2_CONFIG_ERROROFFSET |
> +                     PRM_VP2_CONFIG_TIMEOUTEN,
> +             .vpstepmin_value        = PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
> +                     PRM_VP2_VSTEPMIN_VSTEPMIN,
> +             .vpstepmax_value        = PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
> +                     PRM_VP2_VSTEPMAX_VSTEPMAX,
> +             .vplimito_value         = PRM_VP2_VLIMITTO_VDDMAX |
> +                     PRM_VP2_VLIMITTO_VDDMIN,
> +             .vpenable_mask          = PRM_VP2_CONFIG_VPENABLE,
> +             .irqmask_trans_done     = VP2_IRQMASK_TRANSDONE,
> +             .irqmask_smps_noack     = OMAP3430_VP2_NOSMPSACK_ST,
> +     },
> +     .num_opp                = 3,
> +     .opp_boundary           = 3,
> +     .opp_nvalue             = {
> +                 OMAP343X_CONTROL_FUSE_OPP1_VDD2,
> +                 OMAP343X_CONTROL_FUSE_OPP2_VDD2,
> +                 OMAP343X_CONTROL_FUSE_OPP3_VDD2,
> +     },
> +             /* *INDENT-ON* */
> +};
> +
> +/* SR list for 3430 */
> +static __initdata struct omap_sr_list omap34xx_srlist = {
> +     .num_sr = 2,
> +     .sr_list = {&omap34xx_sr1, &omap34xx_sr2}
> +};
> +
> +/* The final SR list */
> +static struct omap_sr_list *omap_srlist;

I have a couple a suggestions regarding the code partitioning:

- SmartReflex is one IP with several instances; it means that only the base address will change between SR1 and SR2. There is no need to duplicate the mask and shift defines per SR.
Moreover, SR being an IP, I think we can encode the one IP / several instance in a platform_device / platform_driver code. It will allow the support of several drivers for the same devices in order to implement for example class3, class2 or class1 drivers. SR can even be represented by an HWMOD.

- The smartreflex.c file contains 34xx specifics code; it should not be there, only SR specific code should be there.

- If we want to go further, I think that the VP/VC code should not be in SR code either. It is located in the PRM, and can be used independently of SR.
  - In a SR class 2 mode, the smartreflex driver will not use the direct
    connection to the VP.
  - If we don't want SR we can still use the VP/VC for device voltage
    control.

 [snip]

> +/****************** PMIC WEAK FUNCTIONS FOR TWL4030 derivatives
> **********/
> +
> +/**
> + * @brief pmic_srinit - Power management IC initialization
> + * for smart reflex. The current code is written for TWL4030
> + * derivatives, replace in board file if PMIC requires
> + * a different sequence
> + *
> + * @return result of operation
> + */
> +int __weak __init omap_pmic_srinit(void)
> +{
> +     int ret = -ENODEV;
> +#ifdef CONFIG_TWL4030_CORE
> +     u8 reg;
> +     /* Enable SR on T2 */
> +     ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &reg,
> +                               R_DCDC_GLOBAL_CFG);
> +
> +     reg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
> +     ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, reg,
> +                                 R_DCDC_GLOBAL_CFG);
> +#endif                               /* End of CONFIG_TWL4030_CORE */
> +     return ret;
> +}
> +
> +/**
> + * @brief omap_pmic_voltage_ramp_delay - how much should this pmic ramp
> delay
> + * Various PMICs have different ramp up and down delays. choose to
> implement
> + * in required pmic file to override this function.
> + * On TWL4030 derivatives:
> + *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
> + *  2us added as buffer.
> + *
> + * @param srid - which SR is this for?
> + * @param target_vsel - targetted voltage selction
> + * @param current_vsel - current voltage selection
> + *
> + * @return delay in uSeconds
> + */
> +u32 __weak omap_pmic_voltage_ramp_delay(u8 srid, u8 target_vsel,
> +                                     u8 current_vsel)
> +{
> +     u32 t2_smps_steps = abs(target_vsel - current_vsel);
> +     u32 t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
> +     return t2_smps_delay;
> +}
> +
> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
> +/**
> + * @brief omap_pmic_voltage_cmds - hook for pmic command sequence
> + * to be send out which are specific to pmic to set a specific voltage.
> + * this should inturn call vc_send_command with the required sequence
> + * The current implementation is for TWL4030 derivatives
> + *
> + * @param srid - which SR is this for?
> + * @param target_vsel - what voltage is desired to be set?
> + *
> + * @return specific value to set.
> + */
> +int __weak omap_pmic_voltage_cmds(u8 srid, u8 target_vsel)
> +{
> +     u8 reg_addr = (srid == SR1) ? R_VDD1_SR_CONTROL : R_VDD2_SR_CONTROL;
> +     u16 timeout = COUNT_TIMEOUT_TWL4030_VCBYPASS;
> +     return vc_send_command(R_SRI2C_SLAVE_ADDR, reg_addr, target_vsel,
> +                            &timeout);
> +}
> +#endif                               /* ifdef CONFIG_OMAP_VC_BYPASS_UPDATE */
> +

The TWL4030 specific code should not be there even if this is the default PMIC, it should be in TWL4030 driver code.
The usage of weak functions will prevent a multiple OMAP build with different PMIC to work.
The mapping between omap and TWL4030 should be done in the board specific code.

[snip]


> +/*********************** DVFS Entry POINTS
> **********************************/
> +
> +/**
> + * @brief sr_vp_enable_both - enable both vp and sr
> + *
> + * @param target_opp - targetted op
> + * @param current_opp - current opp
> + *
> + * @return 0 if ok, 1 if not ok
> + */
> +int sr_vp_enable_both(u32 target_opp, u32 current_opp)

It thinks that it not obvious from the name to understand what this API is doing, especially if we consider the other enable_smartreflex API.
Maybe smartreflex_change_opp or sr_change_opp will more explicit. In any case the vp should be removed. The fact that VP is used internally is implementation dependent.

> +{
> +     struct omap_sr *sr;
> +     u32 vdd, target_opp_no;
> +     int ret = 0;
> +
> +     vdd = get_vdd(target_opp);
> +     target_opp_no = get_opp_no(target_opp);
> +     sr = get_sr_from_vdd(vdd);
> +
> +     if (sr->is_autocomp_active && sr->is_sr_reset) {
> +             ret = srvp_enable(sr, target_opp_no);
> +             if (ret) {
> +                     pr_err("SR[%d]:enableboth:"
> +                            "failed enable SR\n", sr->srid);
> +             }
> +     }
> +     return ret;
> +}
> +EXPORT_SYMBOL(sr_vp_enable_both);
> +
> +/**
> + * @brief sr_vp_disable_both - disable both vp and sr
> + *
> + * @param target_opp - targetted opp
> + * @param current_opp - current opp
> + *
> + * @return 0 if ok, 1 if not ok
> + */
> +int sr_vp_disable_both(u32 target_opp, u32 current_opp)
> +{
> +     struct omap_sr *sr;
> +     u32 vdd;
> +     int ret = 0;
> +
> +     vdd = get_vdd(target_opp);
> +     sr = get_sr_from_vdd(vdd);
> +
> +     if (sr->is_autocomp_active && !sr->is_sr_reset) {
> +             ret = srvp_disable(sr);
> +             if (ret) {
> +                     pr_err("SR[%d]:disableboth:"
> +                            "failed disable SR\n", sr->srid);
> +             }
> +     }
> +
> +     return ret;
> +
> +}
> +EXPORT_SYMBOL(sr_vp_disable_both);
> +
> +/**
> + * @brief sr_voltage_set - setup a voltage requested
> + *
> + * @param target_opp - targetted opp
> + * @param current_opp  - current opp
> + * @param target_vsel - targeted voltage
> + * @param current_vsel - current voltage
> + *
> + * @return  - result of op -0 if ok, else value
> + */
> +int sr_voltage_set(u32 target_opp, u32 current_opp,
> +                u8 target_vsel, u8 current_vsel)
> +{
> +     struct omap_sr *sr;
> +     u8 vdd, target_opp_no;
> +     int ret;
> +
> +     vdd = get_vdd(target_opp);
> +     target_opp_no = get_opp_no(target_opp);
> +     sr = get_sr_from_vdd(vdd);
> +
> +     ret =
> +         SR_CHOSEN_VOLTAGE_UPDATE_MECH(sr, target_opp_no, target_vsel,
> +                                       current_vsel);
> +
> +     return ret;
> +}
> +EXPORT_SYMBOL(sr_voltage_set);
> +
> +/*********************** CPUIDLE ENTRY POINTS
> *********************************/
> +
> +/**
> + * @brief disable_smartreflex - disable SmartReflex before WFI
> + *
> + * @param srid SRID
> + */
> +void disable_smartreflex(u8 srid)
> +{
> +     struct omap_sr *sr = NULL;
> +     int ret;
> +     u32 current_opp_no;
> +
> +     /* I want to be in irq_disabled context..
> +      * else I will die.. find the rootcause and fix it instead
> +      */
> +     BUG_ON(!irqs_disabled());
> +
> +     sr = get_sr(srid);
> +
> +     current_opp_no = get_current_opp_number_from_sr(sr);
> +
> +     if (sr->is_autocomp_active && !sr->is_sr_reset) {
> +             sr->req_opp_no = current_opp_no;
> +             ret = srvp_disable(sr);
> +             if (ret)
> +                     pr_err("SR[%d]:disable_smartreflex:"
> +                            "failed disable SR\n", sr->srid);
> +     }
> +
> +     /* Reset the voltage for current OPP to nominal if SR was enabled */
> +     if (sr->is_autocomp_active)
> +             sr_vp_reset_voltage(srid);
> +}
> +EXPORT_SYMBOL(disable_smartreflex);
> +
> +/**
> + * @brief enable_smartreflex - enable smart reflex after WFI is hit
> + *
> + * @param srid -SR ID to hit
> + */
> +void enable_smartreflex(u8 srid)

The naming is not coherent with previous API name sr_vp_enable_both. You should use the same denomination for smartreflex everywhere.

> +{
> +     struct omap_sr *sr;
> +     int ret;
> +     u32 current_opp_no;
> +
> +     /* I want to be in irq_disabled context..
> +      * else I will die.. find the rootcause and fix it instead
> +      */
> +     BUG_ON(!irqs_disabled());
> +
> +     sr = get_sr(srid);
> +     current_opp_no = get_current_opp_number_from_sr(sr);
> +
> +     if (sr->is_autocomp_active && sr->is_sr_reset) {
> +             ret = srvp_enable(sr, current_opp_no);
> +             if (ret)
> +                     pr_err("SR[%d]:enable_smartreflex:"
> +                            "failed enable SR\n", sr->srid);
> +     }
> +}
> +EXPORT_SYMBOL(enable_smartreflex);
> +

[snip]

For my point of view, this code should be dispatched into several files: smartreflex.c (pure SR IP driver), vp_vc.c (voltage processor and control), pmic driver, omap specific code and board initialization code.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



