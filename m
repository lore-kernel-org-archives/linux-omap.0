From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] ARM: OMAP2+: PRM: create PRM reset source API for the
 watchdog timer driver
Date: Mon, 15 Oct 2012 19:32:13 -0600
Message-ID: <20121016013211.21844.21485.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42857 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2JPBe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:28 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP watchdog timer driver needs to determine what caused the SoC
to reset for its GETBOOTSTATUS ioctl.  So, define a set of standard
reset sources across OMAP SoCs.  For OMAP2xxx, 3xxx, and 4xxx SoCs,
define mappings from the SoC-specific reset source register bits to
the standardized reset source IDs.  Create SoC-specific PRM functions
that read the appropriate per-SoC register and use the mapping to
return the standardized reset bits.  Register the SoC-specific PRM
functions with the common PRM code via prm_register().  Create a
function in the common PRM code, prm_read_reset_sources(), that
calls the SoC-specific function, registered during boot.

This patch does not yet handle some SoCs, such as AM33xx.  Those SoCs
were not handled by the code this will replace.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm-regbits-24xx.h |    4 ++
 arch/arm/mach-omap2/prm-regbits-34xx.h |   10 ++++
 arch/arm/mach-omap2/prm.h              |   44 +++++++++++++++++
 arch/arm/mach-omap2/prm2xxx.c          |   68 ++++++++++++++++++++++++=
++
 arch/arm/mach-omap2/prm2xxx.h          |    4 ++
 arch/arm/mach-omap2/prm2xxx_3xxx.h     |    2 +
 arch/arm/mach-omap2/prm3xxx.c          |   65 ++++++++++++++++++++++++=
+
 arch/arm/mach-omap2/prm3xxx.h          |    2 +
 arch/arm/mach-omap2/prm44xx.c          |   83 ++++++++++++++++++++++++=
+++++++-
 arch/arm/mach-omap2/prm44xx.h          |    2 +
 arch/arm/mach-omap2/prm_common.c       |   26 ++++++++++
 11 files changed, 306 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-oma=
p2/prm-regbits-24xx.h
index bd70a5a..638da6d 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -209,9 +209,13 @@
=20
 /* RM_RSTST_WKUP specific bits */
 /* 2430 calls EXTWMPU_RST "EXTWARM_RST" and GLOBALWMPU_RST "GLOBALWARM=
_RST" */
+#define OMAP24XX_EXTWMPU_RST_SHIFT			6
 #define OMAP24XX_EXTWMPU_RST_MASK			(1 << 6)
+#define OMAP24XX_SECU_WD_RST_SHIFT			5
 #define OMAP24XX_SECU_WD_RST_MASK			(1 << 5)
+#define OMAP24XX_MPU_WD_RST_SHIFT			4
 #define OMAP24XX_MPU_WD_RST_MASK			(1 << 4)
+#define OMAP24XX_SECU_VIOL_RST_SHIFT			3
 #define OMAP24XX_SECU_VIOL_RST_MASK			(1 << 3)
=20
 /* PM_WKEN_WKUP specific bits */
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-oma=
p2/prm-regbits-34xx.h
index 073d4db..838b594 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -509,15 +509,25 @@
 #define OMAP3430_RSTTIME1_MASK				(0xff << 0)
=20
 /* PRM_RSTST */
+#define OMAP3430_ICECRUSHER_RST_SHIFT			10
 #define OMAP3430_ICECRUSHER_RST_MASK			(1 << 10)
+#define OMAP3430_ICEPICK_RST_SHIFT			9
 #define OMAP3430_ICEPICK_RST_MASK			(1 << 9)
+#define OMAP3430_VDD2_VOLTAGE_MANAGER_RST_SHIFT		8
 #define OMAP3430_VDD2_VOLTAGE_MANAGER_RST_MASK		(1 << 8)
+#define OMAP3430_VDD1_VOLTAGE_MANAGER_RST_SHIFT		7
 #define OMAP3430_VDD1_VOLTAGE_MANAGER_RST_MASK		(1 << 7)
+#define OMAP3430_EXTERNAL_WARM_RST_SHIFT		6
 #define OMAP3430_EXTERNAL_WARM_RST_MASK			(1 << 6)
+#define OMAP3430_SECURE_WD_RST_SHIFT			5
 #define OMAP3430_SECURE_WD_RST_MASK			(1 << 5)
+#define OMAP3430_MPU_WD_RST_SHIFT			4
 #define OMAP3430_MPU_WD_RST_MASK			(1 << 4)
+#define OMAP3430_SECURITY_VIOL_RST_SHIFT		3
 #define OMAP3430_SECURITY_VIOL_RST_MASK			(1 << 3)
+#define OMAP3430_GLOBAL_SW_RST_SHIFT			1
 #define OMAP3430_GLOBAL_SW_RST_MASK			(1 << 1)
+#define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
 #define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
=20
 /* PRM_VOLTCTRL */
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 3e51c1d..c30ab5d 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -52,16 +52,58 @@
 #define OMAP_POWERSTATE_SHIFT				0
 #define OMAP_POWERSTATE_MASK				(0x3 << 0)
=20
+/*
+ * Standardized OMAP reset source bits
+ *
+ * To the extent these happen to match the hardware register bit
+ * shifts, it's purely coincidental.  Used by omap-wdt.c.
+ * OMAP_UNKNOWN_RST_SRC_ID_SHIFT is a special value, used whenever
+ * there are any bits remaining in the global PRM_RSTST register that
+ * haven't been identified, or when the PRM code for the current SoC
+ * doesn't know how to interpret the register.
+ */
+#define OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT			0
+#define OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT			1
+#define OMAP_SECU_VIOL_RST_SRC_ID_SHIFT				2
+#define OMAP_MPU_WD_RST_SRC_ID_SHIFT				3
+#define OMAP_SECU_WD_RST_SRC_ID_SHIFT				4
+#define OMAP_EXTWARM_RST_SRC_ID_SHIFT				5
+#define OMAP_VDD_MPU_VM_RST_SRC_ID_SHIFT			6
+#define OMAP_VDD_IVA_VM_RST_SRC_ID_SHIFT			7
+#define OMAP_VDD_CORE_VM_RST_SRC_ID_SHIFT			8
+#define OMAP_ICEPICK_RST_SRC_ID_SHIFT				9
+#define OMAP_ICECRUSHER_RST_SRC_ID_SHIFT			10
+#define OMAP_C2C_RST_SRC_ID_SHIFT				11
+#define OMAP_UNKNOWN_RST_SRC_ID_SHIFT				12
+
 #ifndef __ASSEMBLER__
=20
 /**
+ * struct prm_reset_src_map - map register bitshifts to standard bitsh=
ifts
+ * @reg_shift: bitshift in the PRM reset source register
+ * @std_shift: bitshift equivalent in the standard reset source list
+ *
+ * The fields are signed because -1 is used as a terminator.
+ */
+struct prm_reset_src_map {
+	s8 reg_shift;
+	s8 std_shift;
+};
+
+/**
  * struct prm_ll_data - fn ptrs to per-SoC PRM function implementation=
s
+ * @read_reset_sources: ptr to the Soc PRM-specific get_reset_source i=
mpl
  */
-struct prm_ll_data {};
+struct prm_ll_data {
+	u32 (*read_reset_sources)(void);
+};
=20
 extern int prm_register(struct prm_ll_data *pld);
 extern int prm_unregister(struct prm_ll_data *pld);
=20
+extern u32 prm_read_reset_sources(void);
+
 #endif
=20
+
 #endif
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xx=
x.c
index d08a2b9..1fc06b0 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -28,6 +28,46 @@
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
=20
+/*
+ * omap2xxx_prm_reset_src_map - map from bits in the PRM_RSTST_WKUP
+ *   hardware register (which are specific to the OMAP2xxx SoCs) to
+ *   reset source ID bit shifts (which is an OMAP SoC-independent
+ *   enumeration)
+ */
+static struct prm_reset_src_map omap2xxx_prm_reset_src_map[] =3D {
+	{ OMAP_GLOBALCOLD_RST_SHIFT, OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT },
+	{ OMAP_GLOBALWARM_RST_SHIFT, OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT },
+	{ OMAP24XX_SECU_VIOL_RST_SHIFT, OMAP_SECU_VIOL_RST_SRC_ID_SHIFT },
+	{ OMAP24XX_MPU_WD_RST_SHIFT, OMAP_MPU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP24XX_SECU_WD_RST_SHIFT, OMAP_SECU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP24XX_EXTWMPU_RST_SHIFT, OMAP_EXTWARM_RST_SRC_ID_SHIFT },
+	{ -1, -1 },
+};
+
+/**
+ * omap2xxx_prm_read_reset_sources - return the last SoC reset source
+ *
+ * Return a u32 representing the last reset sources of the SoC.  The
+ * returned reset source bits are standardized across OMAP SoCs.
+ */
+static u32 omap2xxx_prm_read_reset_sources(void)
+{
+	struct prm_reset_src_map *p;
+	u32 r =3D 0;
+	u32 v;
+
+	v =3D omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST);
+
+	p =3D omap2xxx_prm_reset_src_map;
+	while (p->reg_shift >=3D 0 && p->std_shift >=3D 0) {
+		if (v & (1 << p->reg_shift))
+			r |=3D 1 << p->std_shift;
+		p++;
+	}
+
+	return r;
+}
+
 int omap2xxx_clkdm_sleep(struct clockdomain *clkdm)
 {
 	omap2_prm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
@@ -55,3 +95,31 @@ struct pwrdm_ops omap2_pwrdm_operations =3D {
 	.pwrdm_read_mem_retst	=3D omap2_pwrdm_read_mem_retst,
 	.pwrdm_wait_transition	=3D omap2_pwrdm_wait_transition,
 };
+
+/*
+ *
+ */
+
+static struct prm_ll_data omap2xxx_prm_ll_data =3D {
+	.read_reset_sources =3D &omap2xxx_prm_read_reset_sources,
+};
+
+static int __init omap2xxx_prm_init(void)
+{
+	if (!cpu_is_omap24xx())
+		return 0;
+
+	return prm_register(&omap2xxx_prm_ll_data);
+}
+subsys_initcall(omap2xxx_prm_init);
+
+static void __exit omap2xxx_prm_exit(void)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	/* Should never happen */
+	WARN(prm_unregister(&omap2xxx_prm_ll_data),
+	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+}
+__exitcall(omap2xxx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xx=
x.h
index 6d76716..1d97112 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -123,6 +123,10 @@
 /* Function prototypes */
 extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
 extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
+
+extern int __init prm2xxx_init(void);
+extern int __exit prm2xxx_exit(void);
+
 #endif
=20
 #endif
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.h
index 22a405a..3330b1b 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -211,7 +211,9 @@ extern int omap2_clkdm_clear_all_wkdeps(struct cloc=
kdomain *clkdm);
  *
  * 3430: RM_RSTST_CORE, RM_RSTST_EMU
  */
+#define OMAP_GLOBALWARM_RST_SHIFT			1
 #define OMAP_GLOBALWARM_RST_MASK			(1 << 1)
+#define OMAP_GLOBALCOLD_RST_SHIFT			0
 #define OMAP_GLOBALCOLD_RST_MASK			(1 << 0)
=20
 /*
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xx=
x.c
index b2c5fd9..e96446c 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -46,6 +46,27 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_set=
up =3D {
 	.restore_irqen		=3D &omap3xxx_prm_restore_irqen,
 };
=20
+/*
+ * omap3_prm_reset_src_map - map from bits in the PRM_RSTST hardware
+ *   register (which are specific to OMAP3xxx SoCs) to reset source ID
+ *   bit shifts (which is an OMAP SoC-independent enumeration)
+ */
+static struct prm_reset_src_map omap3xxx_prm_reset_src_map[] =3D {
+	{ OMAP3430_GLOBAL_COLD_RST_SHIFT, OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT }=
,
+	{ OMAP3430_GLOBAL_SW_RST_SHIFT, OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT },
+	{ OMAP3430_SECURITY_VIOL_RST_SHIFT, OMAP_SECU_VIOL_RST_SRC_ID_SHIFT }=
,
+	{ OMAP3430_MPU_WD_RST_SHIFT, OMAP_MPU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP3430_SECURE_WD_RST_SHIFT, OMAP_MPU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP3430_EXTERNAL_WARM_RST_SHIFT, OMAP_EXTWARM_RST_SRC_ID_SHIFT },
+	{ OMAP3430_VDD1_VOLTAGE_MANAGER_RST_SHIFT,
+	  OMAP_VDD_MPU_VM_RST_SRC_ID_SHIFT },
+	{ OMAP3430_VDD2_VOLTAGE_MANAGER_RST_SHIFT,
+	  OMAP_VDD_CORE_VM_RST_SRC_ID_SHIFT },
+	{ OMAP3430_ICEPICK_RST_SHIFT, OMAP_ICEPICK_RST_SRC_ID_SHIFT },
+	{ OMAP3430_ICECRUSHER_RST_SHIFT, OMAP_ICECRUSHER_RST_SRC_ID_SHIFT },
+	{ -1, -1 },
+};
+
 /* PRM VP */
=20
 /*
@@ -216,6 +237,30 @@ static void __init omap3xxx_prm_enable_io_wakeup(v=
oid)
 					   PM_WKEN);
 }
=20
+/**
+ * omap3xxx_prm_read_reset_sources - return the last SoC reset source
+ *
+ * Return a u32 representing the last reset sources of the SoC.  The
+ * returned reset source bits are standardized across OMAP SoCs.
+ */
+static u32 omap3xxx_prm_read_reset_sources(void)
+{
+	struct prm_reset_src_map *p;
+	u32 r =3D 0;
+	u32 v;
+
+	v =3D omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST);
+
+	p =3D omap3xxx_prm_reset_src_map;
+	while (p->reg_shift >=3D 0 && p->std_shift >=3D 0) {
+		if (v & (1 << p->reg_shift))
+			r |=3D 1 << p->std_shift;
+		p++;
+	}
+
+	return r;
+}
+
 /* Powerdomain low-level functions */
=20
 /* Applicable only for OMAP3. Not supported on OMAP2 */
@@ -319,6 +364,10 @@ struct pwrdm_ops omap3_pwrdm_operations =3D {
  *
  */
=20
+static struct prm_ll_data omap3xxx_prm_ll_data =3D {
+	.read_reset_sources =3D &omap3xxx_prm_read_reset_sources,
+};
+
 static int __init omap3xxx_prm_init(void)
 {
 	int ret;
@@ -326,12 +375,28 @@ static int __init omap3xxx_prm_init(void)
 	if (!cpu_is_omap34xx())
 		return 0;
=20
+	ret =3D prm_register(&omap3xxx_prm_ll_data);
+	if (ret)
+		return ret;
+
 	omap3xxx_prm_enable_io_wakeup();
 	ret =3D omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
 		irq_set_status_flags(omap_prcm_event_to_irq("io"),
 				     IRQ_NOAUTOEN);
=20
+
 	return ret;
 }
 subsys_initcall(omap3xxx_prm_init);
+
+static void __exit omap3xxx_prm_exit(void)
+{
+	if (!cpu_is_omap34xx())
+		return;
+
+	/* Should never happen */
+	WARN(prm_unregister(&omap3xxx_prm_ll_data),
+	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+}
+__exitcall(omap3xxx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xx=
x.h
index 6821e83..a3c28a8 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -152,6 +152,8 @@ extern void omap3xxx_prm_ocp_barrier(void);
 extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
=20
+extern u32 omap3xxx_prm_get_reset_sources(void);
+
 #endif /* __ASSEMBLER */
=20
=20
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
index 9231fe5..beb4502 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 PRM module functions
  *
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  * Copyright (C) 2010 Nokia Corporation
  * Beno=C3=AEt Cousson
  * Paul Walmsley
@@ -29,6 +29,8 @@
 #include "prminst44xx.h"
 #include "powerdomain.h"
=20
+/* Static data */
+
 static const struct omap_prcm_irq omap4_prcm_irqs[] =3D {
 	OMAP_PRCM_IRQ("wkup",   0,      0),
 	OMAP_PRCM_IRQ("io",     9,      1),
@@ -47,6 +49,33 @@ static struct omap_prcm_irq_setup omap4_prcm_irq_set=
up =3D {
 	.restore_irqen		=3D &omap44xx_prm_restore_irqen,
 };
=20
+/*
+ * omap44xx_prm_reset_src_map - map from bits in the PRM_RSTST
+ *   hardware register (which are specific to OMAP44xx SoCs) to reset
+ *   source ID bit shifts (which is an OMAP SoC-independent
+ *   enumeration)
+ */
+static struct prm_reset_src_map omap44xx_prm_reset_src_map[] =3D {
+	{ OMAP4430_RST_GLOBAL_WARM_SW_SHIFT,
+	  OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT },
+	{ OMAP4430_RST_GLOBAL_COLD_SW_SHIFT,
+	  OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT },
+	{ OMAP4430_MPU_SECURITY_VIOL_RST_SHIFT,
+	  OMAP_SECU_VIOL_RST_SRC_ID_SHIFT },
+	{ OMAP4430_MPU_WDT_RST_SHIFT, OMAP_MPU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP4430_SECURE_WDT_RST_SHIFT, OMAP_SECU_WD_RST_SRC_ID_SHIFT },
+	{ OMAP4430_EXTERNAL_WARM_RST_SHIFT, OMAP_EXTWARM_RST_SRC_ID_SHIFT },
+	{ OMAP4430_VDD_MPU_VOLT_MGR_RST_SHIFT,
+	  OMAP_VDD_MPU_VM_RST_SRC_ID_SHIFT },
+	{ OMAP4430_VDD_IVA_VOLT_MGR_RST_SHIFT,
+	  OMAP_VDD_IVA_VM_RST_SRC_ID_SHIFT },
+	{ OMAP4430_VDD_CORE_VOLT_MGR_RST_SHIFT,
+	  OMAP_VDD_CORE_VM_RST_SRC_ID_SHIFT },
+	{ OMAP4430_ICEPICK_RST_SHIFT, OMAP_ICEPICK_RST_SRC_ID_SHIFT },
+	{ OMAP4430_C2C_RST_SHIFT, OMAP_C2C_RST_SRC_ID_SHIFT },
+	{ -1, -1 },
+};
+
 /* PRM low-level functions */
=20
 /* Read a register in a CM/PRM instance in the PRM module */
@@ -292,6 +321,31 @@ static void __init omap44xx_prm_enable_io_wakeup(v=
oid)
 				    OMAP4_PRM_IO_PMCTRL_OFFSET);
 }
=20
+/**
+ * omap44xx_prm_read_reset_sources - return the last SoC reset source
+ *
+ * Return a u32 representing the last reset sources of the SoC.  The
+ * returned reset source bits are standardized across OMAP SoCs.
+ */
+static u32 omap44xx_prm_read_reset_sources(void)
+{
+	struct prm_reset_src_map *p;
+	u32 r =3D 0;
+	u32 v;
+
+	v =3D omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+				    OMAP4_RM_RSTST);
+
+	p =3D omap44xx_prm_reset_src_map;
+	while (p->reg_shift >=3D 0 && p->std_shift >=3D 0) {
+		if (v & (1 << p->reg_shift))
+			r |=3D 1 << p->std_shift;
+		p++;
+	}
+
+	return r;
+}
+
 /* Powerdomain low-level functions */
=20
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pw=
rst)
@@ -554,14 +608,37 @@ struct pwrdm_ops omap4_pwrdm_operations =3D {
 	.pwrdm_wait_transition	=3D omap4_pwrdm_wait_transition,
 };
=20
+/*
+ * XXX document
+ */
+static struct prm_ll_data omap44xx_prm_ll_data =3D {
+	.read_reset_sources =3D &omap44xx_prm_read_reset_sources,
+};
=20
-static int __init omap4xxx_prm_init(void)
+static int __init omap44xx_prm_init(void)
 {
+	int ret;
+
 	if (!cpu_is_omap44xx())
 		return 0;
=20
+	ret =3D prm_register(&omap44xx_prm_ll_data);
+	if (ret)
+		return ret;
+
 	omap44xx_prm_enable_io_wakeup();
=20
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
 }
-subsys_initcall(omap4xxx_prm_init);
+subsys_initcall(omap44xx_prm_init);
+
+static void __exit omap44xx_prm_exit(void)
+{
+	if (!cpu_is_omap44xx())
+		return;
+
+	/* Should never happen */
+	WARN(prm_unregister(&omap44xx_prm_ll_data),
+	     "%s: prm_ll_data function pointer mismatch\n", __func__);
+}
+__exitcall(omap44xx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44x=
x.h
index ee72ae6..c8e1acc 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -771,6 +771,8 @@ extern void omap44xx_prm_ocp_barrier(void);
 extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
=20
+extern u32 omap44xx_prm_get_reset_sources(void);
+
 # endif
=20
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm=
_common.c
index 8670a3c..e200e4f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -28,6 +28,8 @@
 #include <plat/prcm.h>
=20
 #include "prm2xxx_3xxx.h"
+#include "prm2xxx.h"
+#include "prm3xxx.h"
 #include "prm44xx.h"
=20
 /*
@@ -327,6 +329,30 @@ err:
 }
=20
 /**
+ * prm_read_reset_sources - return the sources of the SoC's last reset
+ *
+ * Return a u32 bitmask representing the reset sources that caused the
+ * SoC to reset.  The low-level per-SoC functions called by this
+ * function remap the SoC-specific reset source bits into an
+ * OMAP-common set of reset source bits, defined in
+ * arch/arm/mach-omap2/prm.h.  Returns the standardized reset source
+ * u32 bitmask from the hardware upon success, or returns (1 <<
+ * OMAP_UNKNOWN_RST_SRC_ID_SHIFT) if no low-level read_reset_sources()
+ * function was registered.
+ */
+u32 prm_read_reset_sources(void)
+{
+	u32 ret =3D 1 << OMAP_UNKNOWN_RST_SRC_ID_SHIFT;
+
+	if (prm_ll_data->read_reset_sources)
+		ret =3D prm_ll_data->read_reset_sources();
+	else
+		WARN_ONCE(1, "prm: %s: no mapping function defined for reset sources=
\n", __func__);
+
+	return ret;
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to regist=
er
  *


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
