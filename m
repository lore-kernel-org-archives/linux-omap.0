From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 1/5] OMAP: move voltage.h and vp.h under platform include directory
Date: Wed, 13 Jul 2011 17:00:34 +0300
Message-ID: <1310565638-13140-2-git-send-email-t-kristo@ti.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35732 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab1GMOBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 10:01:46 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

This is needed so that these include files can be accessed from drivers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_opp_data.h           |    3 +-
 arch/arm/mach-omap2/omap_twl.c                |    2 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/smartreflex.h             |    2 +-
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 arch/arm/mach-omap2/vc3xxx_data.c             |    2 +-
 arch/arm/mach-omap2/vc44xx_data.c             |    2 +-
 arch/arm/mach-omap2/voltage.c                 |    4 +-
 arch/arm/mach-omap2/voltage.h                 |  184 -------------------------
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    3 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +-
 arch/arm/mach-omap2/vp.h                      |  143 -------------------
 arch/arm/mach-omap2/vp3xxx_data.c             |    4 +-
 arch/arm/mach-omap2/vp44xx_data.c             |    4 +-
 arch/arm/plat-omap/include/plat/voltage.h     |  183 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/vp.h          |  143 +++++++++++++++++++
 16 files changed, 338 insertions(+), 348 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltage.h
 delete mode 100644 arch/arm/mach-omap2/vp.h
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
 create mode 100644 arch/arm/plat-omap/include/plat/vp.h

diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index c784c12..4d93209 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -20,8 +20,7 @@
 #define __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H
 
 #include <plat/omap_hwmod.h>
-
-#include "voltage.h"
+#include <plat/voltage.h>
 
 /*
  * *BIG FAT WARNING*:
diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 07d6140..ffe7e5c 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/i2c/twl.h>
 
-#include "voltage.h"
+#include <plat/voltage.h>
 
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index ce1a9f3..26ff6fa 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,8 +18,8 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include <plat/common.h>
+#include <plat/voltage.h>
 
-#include "voltage.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5f35b9e..fe9b242 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -22,7 +22,7 @@
 
 #include <linux/platform_device.h>
 
-#include "voltage.h"
+#include <plat/voltage.h>
 
 /*
  * Different Smartreflex IPs version. The v1 is the 65nm version used in
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 10d3c5e..a636604 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 
 #include <plat/omap_device.h>
+#include <plat/voltage.h>
 
 #include "smartreflex.h"
-#include "voltage.h"
 #include "control.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index f37dc4b..7df566c 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -19,9 +19,9 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
-#include "voltage.h"
 
 #include "vc.h"
 
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index a98da8d..7a69821 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -19,10 +19,10 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "voltage.h"
 
 #include "vc.h"
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 9ef3789..7e3c512 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
@@ -35,10 +36,7 @@
 #include "prminst44xx.h"
 #include "control.h"
 
-#include "voltage.h"
-
 #include "vc.h"
-#include "vp.h"
 
 #define VOLTAGE_DIR_SIZE	16
 
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
deleted file mode 100644
index e9f5408..0000000
--- a/arch/arm/mach-omap2/voltage.h
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- * OMAP Voltage Management Routines
- *
- * Author: Thara Gopinath	<thara@ti.com>
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- * Thara Gopinath <thara@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
-#define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
-
-#include <linux/err.h>
-
-#include "vc.h"
-#include "vp.h"
-
-/* XXX document */
-#define VOLTSCALE_VPFORCEUPDATE		1
-#define VOLTSCALE_VCBYPASS		2
-
-/*
- * OMAP3 GENERIC setup times. Revisit to see if these needs to be
- * passed from board or PMIC file
- */
-#define OMAP3_CLKSETUP		0xff
-#define OMAP3_VOLTOFFSET	0xff
-#define OMAP3_VOLTSETUP2	0xff
-
-/**
- * struct omap_vfsm_instance_data - per-voltage manager FSM register/bitfield
- * data
- * @voltsetup_mask: SETUP_TIME* bitmask in the PRM_VOLTSETUP* register
- * @voltsetup_reg: register offset of PRM_VOLTSETUP from PRM base
- * @voltsetup_shift: SETUP_TIME* field shift in the PRM_VOLTSETUP* register
- *
- * XXX What about VOLTOFFSET/VOLTCTRL?
- * XXX It is not necessary to have both a _mask and a _shift for the same
- *     bitfield - remove one!
- */
-struct omap_vfsm_instance_data {
-	u32 voltsetup_mask;
-	u8 voltsetup_reg;
-	u8 voltsetup_shift;
-};
-
-/**
- * struct voltagedomain - omap voltage domain global structure.
- * @name:	Name of the voltage domain which can be used as a unique
- *		identifier.
- */
-struct voltagedomain {
-	char *name;
-};
-
-/**
- * struct omap_volt_data - Omap voltage specific data.
- * @voltage_nominal:	The possible voltage value in uV
- * @sr_efuse_offs:	The offset of the efuse register(from system
- *			control module base address) from where to read
- *			the n-target value for the smartreflex module.
- * @sr_errminlimit:	Error min limit value for smartreflex. This value
- *			differs at differnet opp and thus is linked
- *			with voltage.
- * @vp_errorgain:	Error gain value for the voltage processor. This
- *			field also differs according to the voltage/opp.
- */
-struct omap_volt_data {
-	u32	volt_nominal;
-	u32	sr_efuse_offs;
-	u8	sr_errminlimit;
-	u8	vp_errgain;
-};
-
-/**
- * struct omap_volt_pmic_info - PMIC specific data required by voltage driver.
- * @slew_rate:	PMIC slew rate (in uv/us)
- * @step_size:	PMIC voltage step size (in uv)
- * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
- * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
- */
-struct omap_volt_pmic_info {
-	int slew_rate;
-	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
-	u16 volt_setup_time;
-	u8 vp_erroroffset;
-	u8 vp_vstepmin;
-	u8 vp_vstepmax;
-	u8 vp_vddmin;
-	u8 vp_vddmax;
-	u8 vp_timeout_us;
-	u8 i2c_slave_addr;
-	u8 pmic_reg;
-	unsigned long (*vsel_to_uv) (const u8 vsel);
-	u8 (*uv_to_vsel) (unsigned long uV);
-};
-
-/**
- * omap_vdd_info - Per Voltage Domain info
- *
- * @volt_data		: voltage table having the distinct voltages supported
- *			  by the domain and other associated per voltage data.
- * @pmic_info		: pmic specific parameters which should be populted by
- *			  the pmic drivers.
- * @vp_data		: the register values, shifts, masks for various
- *			  vp registers
- * @vp_rt_data          : VP data derived at runtime, not predefined
- * @vc_data		: structure containing various various vc registers,
- *			  shifts, masks etc.
- * @vfsm                : voltage manager FSM data
- * @voltdm		: pointer to the voltage domain structure
- * @debug_dir		: debug directory for this voltage domain.
- * @curr_volt		: current voltage for this vdd.
- * @vp_enabled		: flag to keep track of whether vp is enabled or not
- * @volt_scale		: API to scale the voltage of the vdd.
- */
-struct omap_vdd_info {
-	struct omap_volt_data *volt_data;
-	struct omap_volt_pmic_info *pmic_info;
-	struct omap_vp_instance_data *vp_data;
-	struct omap_vp_runtime_data vp_rt_data;
-	struct omap_vc_instance_data *vc_data;
-	const struct omap_vfsm_instance_data *vfsm;
-	struct voltagedomain voltdm;
-	struct dentry *debug_dir;
-	u32 curr_volt;
-	bool vp_enabled;
-	u32 (*read_reg) (u16 mod, u8 offset);
-	void (*write_reg) (u32 val, u16 mod, u8 offset);
-	int (*volt_scale) (struct omap_vdd_info *vdd,
-		unsigned long target_volt);
-};
-
-unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
-void omap_vp_enable(struct voltagedomain *voltdm);
-void omap_vp_disable(struct voltagedomain *voltdm);
-int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
-		unsigned long target_volt);
-void omap_voltage_reset(struct voltagedomain *voltdm);
-void omap_voltage_get_volttable(struct voltagedomain *voltdm,
-		struct omap_volt_data **volt_data);
-struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
-		unsigned long volt);
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
-struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
-int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
-				   struct omap_vdd_info *omap_vdd_array[],
-				   u8 omap_vdd_count);
-#ifdef CONFIG_PM
-int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info);
-void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method);
-/* API to get the voltagedomain pointer */
-struct voltagedomain *omap_voltage_domain_lookup(char *name);
-
-int omap_voltage_late_init(void);
-#else
-static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info)
-{
-	return -EINVAL;
-}
-static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method) {}
-static inline int omap_voltage_late_init(void)
-{
-	return -EINVAL;
-}
-static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
-{
-	return ERR_PTR(-EINVAL);
-}
-#endif
-
-#endif
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index def230f..2e17350 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -20,12 +20,11 @@
 
 #include <plat/common.h>
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
 #include "omap_opp_data.h"
-#include "voltage.h"
 #include "vc.h"
-#include "vp.h"
 
 /*
  * VDD data
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index cb64996..be61419 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -22,15 +22,14 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx.h"
-#include "voltage.h"
 #include "omap_opp_data.h"
 #include "vc.h"
-#include "vp.h"
 
 static const struct omap_vfsm_instance_data omap4_vdd_mpu_vfsm_data = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
deleted file mode 100644
index 7ce134f..0000000
--- a/arch/arm/mach-omap2/vp.h
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * OMAP3/4 Voltage Processor (VP) structure and macro definitions
- *
- * Copyright (C) 2007, 2010 Texas Instruments, Inc.
- * Rajendra Nayak <rnayak@ti.com>
- * Lesly A M <x0080970@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Copyright (C) 2008, 2011 Nokia Corporation
- * Kalle Jokiniemi
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- */
-#ifndef __ARCH_ARM_MACH_OMAP2_VP_H
-#define __ARCH_ARM_MACH_OMAP2_VP_H
-
-#include <linux/kernel.h>
-
-/* XXX document */
-#define VP_IDLE_TIMEOUT		200
-#define VP_TRANXDONE_TIMEOUT	300
-
-
-/**
- * struct omap_vp_common_data - register data common to all VDDs
- * @vpconfig_errorgain_mask: ERRORGAIN bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_initvoltage_mask: INITVOLTAGE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_timeouten_mask: TIMEOUT bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_initvdd: INITVDD bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_forceupdate: FORCEUPDATE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_vpenable: VPENABLE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_erroroffset_shift: ERROROFFSET field shift in PRM_VP*_CONFIG reg
- * @vpconfig_errorgain_shift: ERRORGAIN field shift in PRM_VP*_CONFIG reg
- * @vpconfig_initvoltage_shift: INITVOLTAGE field shift in PRM_VP*_CONFIG reg
- * @vpconfig_stepmin_shift: VSTEPMIN field shift in the PRM_VP*_VSTEPMIN reg
- * @vpconfig_smpswaittimemin_shift: SMPSWAITTIMEMIN field shift in PRM_VP*_VSTEPMIN reg
- * @vpconfig_stepmax_shift: VSTEPMAX field shift in the PRM_VP*_VSTEPMAX reg
- * @vpconfig_smpswaittimemax_shift: SMPSWAITTIMEMAX field shift in PRM_VP*_VSTEPMAX reg
- * @vpconfig_vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
- * @vpconfig_vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
- * @vpconfig_vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
- *
- * XXX It it not necessary to have both a mask and a shift for the same
- *     bitfield - remove one
- * XXX Many of these fields are wrongly named -- e.g., vpconfig_smps* -- fix!
- */
-struct omap_vp_common_data {
-	u32 vpconfig_errorgain_mask;
-	u32 vpconfig_initvoltage_mask;
-	u32 vpconfig_timeouten;
-	u32 vpconfig_initvdd;
-	u32 vpconfig_forceupdate;
-	u32 vpconfig_vpenable;
-	u8 vpconfig_erroroffset_shift;
-	u8 vpconfig_errorgain_shift;
-	u8 vpconfig_initvoltage_shift;
-	u8 vstepmin_stepmin_shift;
-	u8 vstepmin_smpswaittimemin_shift;
-	u8 vstepmax_stepmax_shift;
-	u8 vstepmax_smpswaittimemax_shift;
-	u8 vlimitto_vddmin_shift;
-	u8 vlimitto_vddmax_shift;
-	u8 vlimitto_timeout_shift;
-};
-
-/**
- * struct omap_vp_prm_irqst_data - PRM_IRQSTATUS_MPU.VP_TRANXDONE_ST data
- * @prm_irqst_reg: reg offset for PRM_IRQSTATUS_MPU from top of PRM
- * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
- *
- * XXX prm_irqst_reg does not belong here
- * XXX Note that on OMAP3, VP_TRANXDONE interrupt may not work due to a
- *     hardware bug
- * XXX This structure is probably not needed
- */
-struct omap_vp_prm_irqst_data {
-	u8 prm_irqst_reg;
-	u32 tranxdone_status;
-};
-
-/**
- * struct omap_vp_instance_data - VP register offsets (per-VDD)
- * @vp_common: pointer to struct omap_vp_common_data * for this SoC
- * @prm_irqst_data: pointer to struct omap_vp_prm_irqst_data for this VDD
- * @vpconfig: PRM_VP*_CONFIG reg offset from PRM start
- * @vstepmin: PRM_VP*_VSTEPMIN reg offset from PRM start
- * @vlimitto: PRM_VP*_VLIMITTO reg offset from PRM start
- * @vstatus: PRM_VP*_VSTATUS reg offset from PRM start
- * @voltage: PRM_VP*_VOLTAGE reg offset from PRM start
- *
- * XXX vp_common is probably not needed since it is per-SoC
- */
-struct omap_vp_instance_data {
-	const struct omap_vp_common_data *vp_common;
-	const struct omap_vp_prm_irqst_data *prm_irqst_data;
-	u8 vpconfig;
-	u8 vstepmin;
-	u8 vstepmax;
-	u8 vlimitto;
-	u8 vstatus;
-	u8 voltage;
-};
-
-/**
- * struct omap_vp_runtime_data - VP data populated at runtime by code
- * @vpconfig_erroroffset: value of ERROROFFSET bitfield in PRM_VP*_CONFIG
- * @vpconfig_errorgain: value of ERRORGAIN bitfield in PRM_VP*_CONFIG
- * @vstepmin_smpswaittimemin: value of SMPSWAITTIMEMIN bitfield in PRM_VP*_VSTEPMIN
- * @vstepmax_smpswaittimemax: value of SMPSWAITTIMEMAX bitfield in PRM_VP*_VSTEPMAX
- * @vlimitto_timeout: value of TIMEOUT bitfield in PRM_VP*_VLIMITTO
- * @vstepmin_stepmin: value of VSTEPMIN bitfield in PRM_VP*_VSTEPMIN
- * @vstepmax_stepmax: value of VSTEPMAX bitfield in PRM_VP*_VSTEPMAX
- * @vlimitto_vddmin: value of VDDMIN bitfield in PRM_VP*_VLIMITTO
- * @vlimitto_vddmax: value of VDDMAX bitfield in PRM_VP*_VLIMITTO
- *
- * XXX Is this structure really needed?  Why not just program the
- * device directly?  They are in PRM space, therefore in the WKUP
- * powerdomain, so register contents should not be lost in off-mode.
- * XXX Some of these fields are incorrectly named, e.g., vstep*
- */
-struct omap_vp_runtime_data {
-	u32 vpconfig_erroroffset;
-	u16 vpconfig_errorgain;
-	u16 vstepmin_smpswaittimemin;
-	u16 vstepmax_smpswaittimemax;
-	u16 vlimitto_timeout;
-	u8 vstepmin_stepmin;
-	u8 vstepmax_stepmax;
-	u8 vlimitto_vddmin;
-	u8 vlimitto_vddmax;
-};
-
-extern struct omap_vp_instance_data omap3_vp1_data;
-extern struct omap_vp_instance_data omap3_vp2_data;
-
-extern struct omap_vp_instance_data omap4_vp_mpu_data;
-extern struct omap_vp_instance_data omap4_vp_iva_data;
-extern struct omap_vp_instance_data omap4_vp_core_data;
-
-#endif
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 6452170..a7ac327 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -20,11 +20,9 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm-regbits-34xx.h"
-#include "voltage.h"
-
-#include "vp.h"
 
 /*
  * VP data common to 34xx/36xx chips
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index 65d1ad6..88d059f 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -20,12 +20,10 @@
 #include <linux/init.h>
 
 #include <plat/common.h>
+#include <plat/voltage.h>
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "voltage.h"
-
-#include "vp.h"
 
 /*
  * VP data common to 44xx chips
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
new file mode 100644
index 0000000..46573bf
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -0,0 +1,183 @@
+/*
+ * OMAP Voltage Management Routines
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_VOLTAGE_H
+#define __ARCH_ARM_PLAT_OMAP_VOLTAGE_H
+
+#include <linux/err.h>
+
+#include <plat/vp.h>
+
+/* XXX document */
+#define VOLTSCALE_VPFORCEUPDATE		1
+#define VOLTSCALE_VCBYPASS		2
+
+/*
+ * OMAP3 GENERIC setup times. Revisit to see if these needs to be
+ * passed from board or PMIC file
+ */
+#define OMAP3_CLKSETUP		0xff
+#define OMAP3_VOLTOFFSET	0xff
+#define OMAP3_VOLTSETUP2	0xff
+
+/**
+ * struct omap_vfsm_instance_data - per-voltage manager FSM register/bitfield
+ * data
+ * @voltsetup_mask: SETUP_TIME* bitmask in the PRM_VOLTSETUP* register
+ * @voltsetup_reg: register offset of PRM_VOLTSETUP from PRM base
+ * @voltsetup_shift: SETUP_TIME* field shift in the PRM_VOLTSETUP* register
+ *
+ * XXX What about VOLTOFFSET/VOLTCTRL?
+ * XXX It is not necessary to have both a _mask and a _shift for the same
+ *     bitfield - remove one!
+ */
+struct omap_vfsm_instance_data {
+	u32 voltsetup_mask;
+	u8 voltsetup_reg;
+	u8 voltsetup_shift;
+};
+
+/**
+ * struct voltagedomain - omap voltage domain global structure.
+ * @name:	Name of the voltage domain which can be used as a unique
+ *		identifier.
+ */
+struct voltagedomain {
+	char *name;
+};
+
+/**
+ * struct omap_volt_data - Omap voltage specific data.
+ * @voltage_nominal:	The possible voltage value in uV
+ * @sr_efuse_offs:	The offset of the efuse register(from system
+ *			control module base address) from where to read
+ *			the n-target value for the smartreflex module.
+ * @sr_errminlimit:	Error min limit value for smartreflex. This value
+ *			differs at differnet opp and thus is linked
+ *			with voltage.
+ * @vp_errorgain:	Error gain value for the voltage processor. This
+ *			field also differs according to the voltage/opp.
+ */
+struct omap_volt_data {
+	u32	volt_nominal;
+	u32	sr_efuse_offs;
+	u8	sr_errminlimit;
+	u8	vp_errgain;
+};
+
+/**
+ * struct omap_volt_pmic_info - PMIC specific data required by voltage driver.
+ * @slew_rate:	PMIC slew rate (in uv/us)
+ * @step_size:	PMIC voltage step size (in uv)
+ * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
+ * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
+ */
+struct omap_volt_pmic_info {
+	int slew_rate;
+	int step_size;
+	u32 on_volt;
+	u32 onlp_volt;
+	u32 ret_volt;
+	u32 off_volt;
+	u16 volt_setup_time;
+	u8 vp_erroroffset;
+	u8 vp_vstepmin;
+	u8 vp_vstepmax;
+	u8 vp_vddmin;
+	u8 vp_vddmax;
+	u8 vp_timeout_us;
+	u8 i2c_slave_addr;
+	u8 pmic_reg;
+	unsigned long (*vsel_to_uv) (const u8 vsel);
+	u8 (*uv_to_vsel) (unsigned long uV);
+};
+
+/**
+ * omap_vdd_info - Per Voltage Domain info
+ *
+ * @volt_data		: voltage table having the distinct voltages supported
+ *			  by the domain and other associated per voltage data.
+ * @pmic_info		: pmic specific parameters which should be populted by
+ *			  the pmic drivers.
+ * @vp_data		: the register values, shifts, masks for various
+ *			  vp registers
+ * @vp_rt_data          : VP data derived at runtime, not predefined
+ * @vc_data		: structure containing various various vc registers,
+ *			  shifts, masks etc.
+ * @vfsm                : voltage manager FSM data
+ * @voltdm		: pointer to the voltage domain structure
+ * @debug_dir		: debug directory for this voltage domain.
+ * @curr_volt		: current voltage for this vdd.
+ * @vp_enabled		: flag to keep track of whether vp is enabled or not
+ * @volt_scale		: API to scale the voltage of the vdd.
+ */
+struct omap_vdd_info {
+	struct omap_volt_data *volt_data;
+	struct omap_volt_pmic_info *pmic_info;
+	struct omap_vp_instance_data *vp_data;
+	struct omap_vp_runtime_data vp_rt_data;
+	struct omap_vc_instance_data *vc_data;
+	const struct omap_vfsm_instance_data *vfsm;
+	struct voltagedomain voltdm;
+	struct dentry *debug_dir;
+	u32 curr_volt;
+	bool vp_enabled;
+	u32 (*read_reg) (u16 mod, u8 offset);
+	void (*write_reg) (u32 val, u16 mod, u8 offset);
+	int (*volt_scale) (struct omap_vdd_info *vdd,
+		unsigned long target_volt);
+};
+
+unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
+void omap_vp_enable(struct voltagedomain *voltdm);
+void omap_vp_disable(struct voltagedomain *voltdm);
+int omap_voltage_scale_vdd(struct voltagedomain *voltdm,
+		unsigned long target_volt);
+void omap_voltage_reset(struct voltagedomain *voltdm);
+void omap_voltage_get_volttable(struct voltagedomain *voltdm,
+		struct omap_volt_data **volt_data);
+struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
+		unsigned long volt);
+unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
+int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
+				   struct omap_vdd_info *omap_vdd_array[],
+				   u8 omap_vdd_count);
+#ifdef CONFIG_PM
+int omap_voltage_register_pmic(struct voltagedomain *voltdm,
+		struct omap_volt_pmic_info *pmic_info);
+void omap_change_voltscale_method(struct voltagedomain *voltdm,
+		int voltscale_method);
+/* API to get the voltagedomain pointer */
+struct voltagedomain *omap_voltage_domain_lookup(char *name);
+
+int omap_voltage_late_init(void);
+#else
+static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
+		struct omap_volt_pmic_info *pmic_info)
+{
+	return -EINVAL;
+}
+static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
+		int voltscale_method) {}
+static inline int omap_voltage_late_init(void)
+{
+	return -EINVAL;
+}
+static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/vp.h b/arch/arm/plat-omap/include/plat/vp.h
new file mode 100644
index 0000000..95f93b9
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/vp.h
@@ -0,0 +1,143 @@
+/*
+ * OMAP3/4 Voltage Processor (VP) structure and macro definitions
+ *
+ * Copyright (C) 2007, 2010 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ * Lesly A M <x0080970@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * Copyright (C) 2008, 2011 Nokia Corporation
+ * Kalle Jokiniemi
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_VP_H
+#define __ARCH_ARM_PLAT_OMAP_VP_H
+
+#include <linux/kernel.h>
+
+/* XXX document */
+#define VP_IDLE_TIMEOUT		200
+#define VP_TRANXDONE_TIMEOUT	300
+
+
+/**
+ * struct omap_vp_common_data - register data common to all VDDs
+ * @vpconfig_errorgain_mask: ERRORGAIN bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_initvoltage_mask: INITVOLTAGE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_timeouten_mask: TIMEOUT bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_initvdd: INITVDD bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_forceupdate: FORCEUPDATE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_vpenable: VPENABLE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_erroroffset_shift: ERROROFFSET field shift in PRM_VP*_CONFIG reg
+ * @vpconfig_errorgain_shift: ERRORGAIN field shift in PRM_VP*_CONFIG reg
+ * @vpconfig_initvoltage_shift: INITVOLTAGE field shift in PRM_VP*_CONFIG reg
+ * @vpconfig_stepmin_shift: VSTEPMIN field shift in the PRM_VP*_VSTEPMIN reg
+ * @vpconfig_smpswaittimemin_shift: SMPSWAITTIMEMIN field shift in PRM_VP*_VSTEPMIN reg
+ * @vpconfig_stepmax_shift: VSTEPMAX field shift in the PRM_VP*_VSTEPMAX reg
+ * @vpconfig_smpswaittimemax_shift: SMPSWAITTIMEMAX field shift in PRM_VP*_VSTEPMAX reg
+ * @vpconfig_vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
+ * @vpconfig_vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
+ * @vpconfig_vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
+ *
+ * XXX It it not necessary to have both a mask and a shift for the same
+ *     bitfield - remove one
+ * XXX Many of these fields are wrongly named -- e.g., vpconfig_smps* -- fix!
+ */
+struct omap_vp_common_data {
+	u32 vpconfig_errorgain_mask;
+	u32 vpconfig_initvoltage_mask;
+	u32 vpconfig_timeouten;
+	u32 vpconfig_initvdd;
+	u32 vpconfig_forceupdate;
+	u32 vpconfig_vpenable;
+	u8 vpconfig_erroroffset_shift;
+	u8 vpconfig_errorgain_shift;
+	u8 vpconfig_initvoltage_shift;
+	u8 vstepmin_stepmin_shift;
+	u8 vstepmin_smpswaittimemin_shift;
+	u8 vstepmax_stepmax_shift;
+	u8 vstepmax_smpswaittimemax_shift;
+	u8 vlimitto_vddmin_shift;
+	u8 vlimitto_vddmax_shift;
+	u8 vlimitto_timeout_shift;
+};
+
+/**
+ * struct omap_vp_prm_irqst_data - PRM_IRQSTATUS_MPU.VP_TRANXDONE_ST data
+ * @prm_irqst_reg: reg offset for PRM_IRQSTATUS_MPU from top of PRM
+ * @tranxdone_status: VP_TRANXDONE_ST bitmask in PRM_IRQSTATUS_MPU reg
+ *
+ * XXX prm_irqst_reg does not belong here
+ * XXX Note that on OMAP3, VP_TRANXDONE interrupt may not work due to a
+ *     hardware bug
+ * XXX This structure is probably not needed
+ */
+struct omap_vp_prm_irqst_data {
+	u8 prm_irqst_reg;
+	u32 tranxdone_status;
+};
+
+/**
+ * struct omap_vp_instance_data - VP register offsets (per-VDD)
+ * @vp_common: pointer to struct omap_vp_common_data * for this SoC
+ * @prm_irqst_data: pointer to struct omap_vp_prm_irqst_data for this VDD
+ * @vpconfig: PRM_VP*_CONFIG reg offset from PRM start
+ * @vstepmin: PRM_VP*_VSTEPMIN reg offset from PRM start
+ * @vlimitto: PRM_VP*_VLIMITTO reg offset from PRM start
+ * @vstatus: PRM_VP*_VSTATUS reg offset from PRM start
+ * @voltage: PRM_VP*_VOLTAGE reg offset from PRM start
+ *
+ * XXX vp_common is probably not needed since it is per-SoC
+ */
+struct omap_vp_instance_data {
+	const struct omap_vp_common_data *vp_common;
+	const struct omap_vp_prm_irqst_data *prm_irqst_data;
+	u8 vpconfig;
+	u8 vstepmin;
+	u8 vstepmax;
+	u8 vlimitto;
+	u8 vstatus;
+	u8 voltage;
+};
+
+/**
+ * struct omap_vp_runtime_data - VP data populated at runtime by code
+ * @vpconfig_erroroffset: value of ERROROFFSET bitfield in PRM_VP*_CONFIG
+ * @vpconfig_errorgain: value of ERRORGAIN bitfield in PRM_VP*_CONFIG
+ * @vstepmin_smpswaittimemin: value of SMPSWAITTIMEMIN bitfield in PRM_VP*_VSTEPMIN
+ * @vstepmax_smpswaittimemax: value of SMPSWAITTIMEMAX bitfield in PRM_VP*_VSTEPMAX
+ * @vlimitto_timeout: value of TIMEOUT bitfield in PRM_VP*_VLIMITTO
+ * @vstepmin_stepmin: value of VSTEPMIN bitfield in PRM_VP*_VSTEPMIN
+ * @vstepmax_stepmax: value of VSTEPMAX bitfield in PRM_VP*_VSTEPMAX
+ * @vlimitto_vddmin: value of VDDMIN bitfield in PRM_VP*_VLIMITTO
+ * @vlimitto_vddmax: value of VDDMAX bitfield in PRM_VP*_VLIMITTO
+ *
+ * XXX Is this structure really needed?  Why not just program the
+ * device directly?  They are in PRM space, therefore in the WKUP
+ * powerdomain, so register contents should not be lost in off-mode.
+ * XXX Some of these fields are incorrectly named, e.g., vstep*
+ */
+struct omap_vp_runtime_data {
+	u32 vpconfig_erroroffset;
+	u16 vpconfig_errorgain;
+	u16 vstepmin_smpswaittimemin;
+	u16 vstepmax_smpswaittimemax;
+	u16 vlimitto_timeout;
+	u8 vstepmin_stepmin;
+	u8 vstepmax_stepmax;
+	u8 vlimitto_vddmin;
+	u8 vlimitto_vddmax;
+};
+
+extern struct omap_vp_instance_data omap3_vp1_data;
+extern struct omap_vp_instance_data omap3_vp2_data;
+
+extern struct omap_vp_instance_data omap4_vp_mpu_data;
+extern struct omap_vp_instance_data omap4_vp_iva_data;
+extern struct omap_vp_instance_data omap4_vp_core_data;
+
+#endif
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

