From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 1/6] OMAP: move voltage.h and vp.h under platform include directory
Date: Mon, 18 Jul 2011 20:35:17 +0300
Message-ID: <1311010522-5868-2-git-send-email-t-kristo@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab1GRRgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:36:06 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

This is needed so that these include files can be accessed from drivers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h             |  180 -----------------------------
 arch/arm/mach-omap2/vp.h                  |  128 --------------------
 arch/arm/plat-omap/include/plat/voltage.h |  179 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/vp.h      |  128 ++++++++++++++++++++
 4 files changed, 307 insertions(+), 308 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/voltage.h
 delete mode 100644 arch/arm/mach-omap2/vp.h
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
 create mode 100644 arch/arm/plat-omap/include/plat/vp.h

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
deleted file mode 100644
index 38a0145..0000000
--- a/arch/arm/mach-omap2/voltage.h
+++ /dev/null
@@ -1,180 +0,0 @@
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
-struct powerdomain;
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
- * struct omap_vfsm_instance - per-voltage manager FSM register/bitfield
- * data
- * @voltsetup_mask: SETUP_TIME* bitmask in the PRM_VOLTSETUP* register
- * @voltsetup_reg: register offset of PRM_VOLTSETUP from PRM base
- * @voltsetup_shift: SETUP_TIME* field shift in the PRM_VOLTSETUP* register
- *
- * XXX What about VOLTOFFSET/VOLTCTRL?
- * XXX It is not necessary to have both a _mask and a _shift for the same
- *     bitfield - remove one!
- */
-struct omap_vfsm_instance {
-	u32 voltsetup_mask;
-	u8 voltsetup_reg;
-	u8 voltsetup_shift;
-};
-
-/**
- * struct voltagedomain - omap voltage domain global structure.
- * @name: Name of the voltage domain which can be used as a unique identifier.
- * @scalable: Whether or not this voltage domain is scalable
- * @node: list_head linking all voltage domains
- * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
- * @vdd: to be removed
- * @pwrdms: powerdomains in this voltagedomain
- * @scale: function used to scale the voltage of the voltagedomain
- * @curr_volt: current nominal voltage for this voltage domain
- */
-struct voltagedomain {
-	char *name;
-	bool scalable;
-	struct list_head node;
-	struct list_head pwrdm_list;
-	struct omap_vc_channel *vc;
-	const struct omap_vfsm_instance *vfsm;
-	struct omap_vp_instance *vp;
-	struct omap_voltdm_pmic *pmic;
-
-	/* VC/VP register access functions: SoC specific */
-	u32 (*read) (u8 offset);
-	void (*write) (u32 val, u8 offset);
-	u32 (*rmw)(u32 mask, u32 bits, u8 offset);
-
-	union {
-		const char *name;
-		u32 rate;
-	} sys_clk;
-
-	int (*scale) (struct voltagedomain *voltdm,
-		      unsigned long target_volt);
-	u32 curr_volt;
-	struct omap_volt_data *volt_data;
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
- * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
- * @slew_rate:	PMIC slew rate (in uv/us)
- * @step_size:	PMIC voltage step size (in uv)
- * @i2c_high_speed: whether VC uses I2C high-speed mode to PMIC
- * @i2c_mcode: master code value for I2C high-speed preamble transmission
- * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
- * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
- */
-struct omap_voltdm_pmic {
-	int slew_rate;
-	int step_size;
-	u32 on_volt;
-	u32 onlp_volt;
-	u32 ret_volt;
-	u32 off_volt;
-	u16 volt_setup_time;
-	u16 i2c_slave_addr;
-	u16 volt_reg_addr;
-	u16 cmd_reg_addr;
-	u8 vp_erroroffset;
-	u8 vp_vstepmin;
-	u8 vp_vstepmax;
-	u8 vp_vddmin;
-	u8 vp_vddmax;
-	u8 vp_timeout_us;
-	bool i2c_high_speed;
-	u8 i2c_mcode;
-	unsigned long (*vsel_to_uv) (const u8 vsel);
-	u8 (*uv_to_vsel) (unsigned long uV);
-};
-
-void omap_voltage_get_volttable(struct voltagedomain *voltdm,
-		struct omap_volt_data **volt_data);
-struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
-		unsigned long volt);
-unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
-#ifdef CONFIG_PM
-int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-			       struct omap_voltdm_pmic *pmic);
-void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method);
-int omap_voltage_late_init(void);
-#else
-static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-					     struct omap_voltdm_pmic *pmic)
-{
-	return -EINVAL;
-}
-static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method) {}
-static inline int omap_voltage_late_init(void)
-{
-	return -EINVAL;
-}
-#endif
-
-extern void omap2xxx_voltagedomains_init(void);
-extern void omap3xxx_voltagedomains_init(void);
-extern void omap44xx_voltagedomains_init(void);
-
-struct voltagedomain *voltdm_lookup(const char *name);
-void voltdm_init(struct voltagedomain **voltdm_list);
-int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
-int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
-		    void *user);
-int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
-			  int (*fn)(struct voltagedomain *voltdm,
-				    struct powerdomain *pwrdm));
-int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
-void voltdm_reset(struct voltagedomain *voltdm);
-#endif
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
deleted file mode 100644
index f78752b..0000000
--- a/arch/arm/mach-omap2/vp.h
+++ /dev/null
@@ -1,128 +0,0 @@
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
-struct voltagedomain;
-
-/*
- * Voltage Processor (VP) identifiers
- */
-#define OMAP3_VP_VDD_MPU_ID 0
-#define OMAP3_VP_VDD_CORE_ID 1
-#define OMAP4_VP_VDD_CORE_ID 0
-#define OMAP4_VP_VDD_IVA_ID 1
-#define OMAP4_VP_VDD_MPU_ID 2
-
-/* XXX document */
-#define VP_IDLE_TIMEOUT		200
-#define VP_TRANXDONE_TIMEOUT	300
-
-/**
- * struct omap_vp_ops - per-VP operations
- * @check_txdone: check for VP transaction done
- * @clear_txdone: clear VP transaction done status
- */
-struct omap_vp_ops {
-	u32 (*check_txdone)(u8 vp_id);
-	void (*clear_txdone)(u8 vp_id);
-};
-
-/**
- * struct omap_vp_common - register data common to all VDDs
- * @vpconfig_erroroffset_mask: ERROROFFSET bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_errorgain_mask: ERRORGAIN bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_initvoltage_mask: INITVOLTAGE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_timeouten: TIMEOUT bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_initvdd: INITVDD bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_forceupdate: FORCEUPDATE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_vpenable: VPENABLE bitmask in the PRM_VP*_CONFIG reg
- * @vpconfig_erroroffset_shift: ERROROFFSET field shift in PRM_VP*_CONFIG reg
- * @vpconfig_errorgain_shift: ERRORGAIN field shift in PRM_VP*_CONFIG reg
- * @vpconfig_initvoltage_shift: INITVOLTAGE field shift in PRM_VP*_CONFIG reg
- * @vstepmin_stepmin_shift: VSTEPMIN field shift in the PRM_VP*_VSTEPMIN reg
- * @vstepmin_smpswaittimemin_shift: SMPSWAITTIMEMIN field shift in PRM_VP*_VSTEPMIN reg
- * @vstepmax_stepmax_shift: VSTEPMAX field shift in the PRM_VP*_VSTEPMAX reg
- * @vstepmax_smpswaittimemax_shift: SMPSWAITTIMEMAX field shift in PRM_VP*_VSTEPMAX reg
- * @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
- * @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
- * @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
- * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
- */
-struct omap_vp_common {
-	u32 vpconfig_erroroffset_mask;
-	u32 vpconfig_errorgain_mask;
-	u32 vpconfig_initvoltage_mask;
-	u8 vpconfig_timeouten;
-	u8 vpconfig_initvdd;
-	u8 vpconfig_forceupdate;
-	u8 vpconfig_vpenable;
-	u8 vstepmin_stepmin_shift;
-	u8 vstepmin_smpswaittimemin_shift;
-	u8 vstepmax_stepmax_shift;
-	u8 vstepmax_smpswaittimemax_shift;
-	u8 vlimitto_vddmin_shift;
-	u8 vlimitto_vddmax_shift;
-	u8 vlimitto_timeout_shift;
-	u8 vpvoltage_mask;
-
-	const struct omap_vp_ops *ops;
-};
-
-/**
- * struct omap_vp_instance - VP register offsets (per-VDD)
- * @common: pointer to struct omap_vp_common * for this SoC
- * @vpconfig: PRM_VP*_CONFIG reg offset from PRM start
- * @vstepmin: PRM_VP*_VSTEPMIN reg offset from PRM start
- * @vlimitto: PRM_VP*_VLIMITTO reg offset from PRM start
- * @vstatus: PRM_VP*_VSTATUS reg offset from PRM start
- * @voltage: PRM_VP*_VOLTAGE reg offset from PRM start
- * @enabled: flag to keep track of whether vp is enabled or not
- *
- * XXX vp_common is probably not needed since it is per-SoC
- */
-struct omap_vp_instance {
-	const struct omap_vp_common *common;
-	u8 vpconfig;
-	u8 vstepmin;
-	u8 vstepmax;
-	u8 vlimitto;
-	u8 vstatus;
-	u8 voltage;
-	u8 id;
-	bool enabled;
-};
-
-extern struct omap_vp_instance omap3_vp_mpu;
-extern struct omap_vp_instance omap3_vp_core;
-
-extern struct omap_vp_instance omap4_vp_mpu;
-extern struct omap_vp_instance omap4_vp_iva;
-extern struct omap_vp_instance omap4_vp_core;
-
-void omap_vp_init(struct voltagedomain *voltdm);
-void omap_vp_enable(struct voltagedomain *voltdm);
-void omap_vp_disable(struct voltagedomain *voltdm);
-unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
-int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
-			      unsigned long target_volt);
-int omap_vp_update_errorgain(struct voltagedomain *voltdm,
-			     unsigned long target_volt);
-
-#endif
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
new file mode 100644
index 0000000..23568fd
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -0,0 +1,179 @@
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
+#ifndef __ARCH_ARM_OMAP_VOLTAGE_H
+#define __ARCH_ARM_OMAP_VOLTAGE_H
+
+#include <linux/err.h>
+
+#include <plat/vp.h>
+
+struct powerdomain;
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
+ * struct omap_vfsm_instance - per-voltage manager FSM register/bitfield
+ * data
+ * @voltsetup_mask: SETUP_TIME* bitmask in the PRM_VOLTSETUP* register
+ * @voltsetup_reg: register offset of PRM_VOLTSETUP from PRM base
+ * @voltsetup_shift: SETUP_TIME* field shift in the PRM_VOLTSETUP* register
+ *
+ * XXX What about VOLTOFFSET/VOLTCTRL?
+ * XXX It is not necessary to have both a _mask and a _shift for the same
+ *     bitfield - remove one!
+ */
+struct omap_vfsm_instance {
+	u32 voltsetup_mask;
+	u8 voltsetup_reg;
+	u8 voltsetup_shift;
+};
+
+/**
+ * struct voltagedomain - omap voltage domain global structure.
+ * @name: Name of the voltage domain which can be used as a unique identifier.
+ * @scalable: Whether or not this voltage domain is scalable
+ * @node: list_head linking all voltage domains
+ * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
+ * @vdd: to be removed
+ * @pwrdms: powerdomains in this voltagedomain
+ * @scale: function used to scale the voltage of the voltagedomain
+ * @curr_volt: current nominal voltage for this voltage domain
+ */
+struct voltagedomain {
+	char *name;
+	bool scalable;
+	struct list_head node;
+	struct list_head pwrdm_list;
+	struct omap_vc_channel *vc;
+	const struct omap_vfsm_instance *vfsm;
+	struct omap_vp_instance *vp;
+	struct omap_voltdm_pmic *pmic;
+
+	/* VC/VP register access functions: SoC specific */
+	u32 (*read) (u8 offset);
+	void (*write) (u32 val, u8 offset);
+	u32 (*rmw)(u32 mask, u32 bits, u8 offset);
+
+	union {
+		const char *name;
+		u32 rate;
+	} sys_clk;
+
+	int (*scale) (struct voltagedomain *voltdm,
+		      unsigned long target_volt);
+	u32 curr_volt;
+	struct omap_volt_data *volt_data;
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
+ * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
+ * @slew_rate:	PMIC slew rate (in uv/us)
+ * @step_size:	PMIC voltage step size (in uv)
+ * @i2c_high_speed: whether VC uses I2C high-speed mode to PMIC
+ * @i2c_mcode: master code value for I2C high-speed preamble transmission
+ * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
+ * @uv_to_vsel:	PMIC API to convert voltage in uV to vsel value.
+ */
+struct omap_voltdm_pmic {
+	int slew_rate;
+	int step_size;
+	u32 on_volt;
+	u32 onlp_volt;
+	u32 ret_volt;
+	u32 off_volt;
+	u16 volt_setup_time;
+	u16 i2c_slave_addr;
+	u16 volt_reg_addr;
+	u16 cmd_reg_addr;
+	u8 vp_erroroffset;
+	u8 vp_vstepmin;
+	u8 vp_vstepmax;
+	u8 vp_vddmin;
+	u8 vp_vddmax;
+	u8 vp_timeout_us;
+	bool i2c_high_speed;
+	u8 i2c_mcode;
+	unsigned long (*vsel_to_uv) (const u8 vsel);
+	u8 (*uv_to_vsel) (unsigned long uV);
+};
+
+void omap_voltage_get_volttable(struct voltagedomain *voltdm,
+		struct omap_volt_data **volt_data);
+struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
+		unsigned long volt);
+unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
+#ifdef CONFIG_PM
+int omap_voltage_register_pmic(struct voltagedomain *voltdm,
+			       struct omap_voltdm_pmic *pmic);
+void omap_change_voltscale_method(struct voltagedomain *voltdm,
+		int voltscale_method);
+int omap_voltage_late_init(void);
+#else
+static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
+					     struct omap_voltdm_pmic *pmic)
+{
+	return -EINVAL;
+}
+static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
+		int voltscale_method) {}
+static inline int omap_voltage_late_init(void)
+{
+	return -EINVAL;
+}
+#endif
+
+extern void omap2xxx_voltagedomains_init(void);
+extern void omap3xxx_voltagedomains_init(void);
+extern void omap44xx_voltagedomains_init(void);
+
+struct voltagedomain *voltdm_lookup(const char *name);
+void voltdm_init(struct voltagedomain **voltdm_list);
+int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
+int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
+		    void *user);
+int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
+			  int (*fn)(struct voltagedomain *voltdm,
+				    struct powerdomain *pwrdm));
+int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
+void voltdm_reset(struct voltagedomain *voltdm);
+#endif
diff --git a/arch/arm/plat-omap/include/plat/vp.h b/arch/arm/plat-omap/include/plat/vp.h
new file mode 100644
index 0000000..530fed5
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/vp.h
@@ -0,0 +1,128 @@
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
+#ifndef __ARCH_ARM_OMAP_VP_H
+#define __ARCH_ARM_OMAP_VP_H
+
+#include <linux/kernel.h>
+
+struct voltagedomain;
+
+/*
+ * Voltage Processor (VP) identifiers
+ */
+#define OMAP3_VP_VDD_MPU_ID 0
+#define OMAP3_VP_VDD_CORE_ID 1
+#define OMAP4_VP_VDD_CORE_ID 0
+#define OMAP4_VP_VDD_IVA_ID 1
+#define OMAP4_VP_VDD_MPU_ID 2
+
+/* XXX document */
+#define VP_IDLE_TIMEOUT		200
+#define VP_TRANXDONE_TIMEOUT	300
+
+/**
+ * struct omap_vp_ops - per-VP operations
+ * @check_txdone: check for VP transaction done
+ * @clear_txdone: clear VP transaction done status
+ */
+struct omap_vp_ops {
+	u32 (*check_txdone)(u8 vp_id);
+	void (*clear_txdone)(u8 vp_id);
+};
+
+/**
+ * struct omap_vp_common - register data common to all VDDs
+ * @vpconfig_erroroffset_mask: ERROROFFSET bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_errorgain_mask: ERRORGAIN bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_initvoltage_mask: INITVOLTAGE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_timeouten: TIMEOUT bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_initvdd: INITVDD bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_forceupdate: FORCEUPDATE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_vpenable: VPENABLE bitmask in the PRM_VP*_CONFIG reg
+ * @vpconfig_erroroffset_shift: ERROROFFSET field shift in PRM_VP*_CONFIG reg
+ * @vpconfig_errorgain_shift: ERRORGAIN field shift in PRM_VP*_CONFIG reg
+ * @vpconfig_initvoltage_shift: INITVOLTAGE field shift in PRM_VP*_CONFIG reg
+ * @vstepmin_stepmin_shift: VSTEPMIN field shift in the PRM_VP*_VSTEPMIN reg
+ * @vstepmin_smpswaittimemin_shift: SMPSWAITTIMEMIN field shift in PRM_VP*_VSTEPMIN reg
+ * @vstepmax_stepmax_shift: VSTEPMAX field shift in the PRM_VP*_VSTEPMAX reg
+ * @vstepmax_smpswaittimemax_shift: SMPSWAITTIMEMAX field shift in PRM_VP*_VSTEPMAX reg
+ * @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
+ * @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
+ * @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
+ * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
+ */
+struct omap_vp_common {
+	u32 vpconfig_erroroffset_mask;
+	u32 vpconfig_errorgain_mask;
+	u32 vpconfig_initvoltage_mask;
+	u8 vpconfig_timeouten;
+	u8 vpconfig_initvdd;
+	u8 vpconfig_forceupdate;
+	u8 vpconfig_vpenable;
+	u8 vstepmin_stepmin_shift;
+	u8 vstepmin_smpswaittimemin_shift;
+	u8 vstepmax_stepmax_shift;
+	u8 vstepmax_smpswaittimemax_shift;
+	u8 vlimitto_vddmin_shift;
+	u8 vlimitto_vddmax_shift;
+	u8 vlimitto_timeout_shift;
+	u8 vpvoltage_mask;
+
+	const struct omap_vp_ops *ops;
+};
+
+/**
+ * struct omap_vp_instance - VP register offsets (per-VDD)
+ * @common: pointer to struct omap_vp_common * for this SoC
+ * @vpconfig: PRM_VP*_CONFIG reg offset from PRM start
+ * @vstepmin: PRM_VP*_VSTEPMIN reg offset from PRM start
+ * @vlimitto: PRM_VP*_VLIMITTO reg offset from PRM start
+ * @vstatus: PRM_VP*_VSTATUS reg offset from PRM start
+ * @voltage: PRM_VP*_VOLTAGE reg offset from PRM start
+ * @enabled: flag to keep track of whether vp is enabled or not
+ *
+ * XXX vp_common is probably not needed since it is per-SoC
+ */
+struct omap_vp_instance {
+	const struct omap_vp_common *common;
+	u8 vpconfig;
+	u8 vstepmin;
+	u8 vstepmax;
+	u8 vlimitto;
+	u8 vstatus;
+	u8 voltage;
+	u8 id;
+	bool enabled;
+};
+
+extern struct omap_vp_instance omap3_vp_mpu;
+extern struct omap_vp_instance omap3_vp_core;
+
+extern struct omap_vp_instance omap4_vp_mpu;
+extern struct omap_vp_instance omap4_vp_iva;
+extern struct omap_vp_instance omap4_vp_core;
+
+void omap_vp_init(struct voltagedomain *voltdm);
+void omap_vp_enable(struct voltagedomain *voltdm);
+void omap_vp_disable(struct voltagedomain *voltdm);
+unsigned long omap_vp_get_curr_volt(struct voltagedomain *voltdm);
+int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
+			      unsigned long target_volt);
+int omap_vp_update_errorgain(struct voltagedomain *voltdm,
+			     unsigned long target_volt);
+
+#endif
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

