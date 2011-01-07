From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest regressions
Date: Fri, 7 Jan 2011 11:57:44 +0000
Message-ID: <20110107115744.GL1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47330 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1AGL5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 06:57:49 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PbAwz-0001bL-Nq
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 11:57:46 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PbAwy-0006Pa-HL
	for linux-omap@vger.kernel.org; Fri, 07 Jan 2011 11:57:44 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:37,
                 from arch/arm/mach-omap2/io.c:45:
arch/arm/plat-omap/include/plat/voltage.h: In function =E2=96=A0omap_vo=
ltage_register_pmic=E2=96=A0:
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return state=
ment in function returning non-void

which gets spammed out all through the build.  voltage.h:137 says:

static inline int omap_voltage_register_pmic(struct voltagedomain *volt=
dm,
                struct omap_volt_pmic_info *pmic_info) {}

but no one checks the return value for this:

arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm, &oma=
p4_mpu_volt_info);
arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm, &oma=
p4_iva_volt_info);
arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm, &oma=
p4_core_volt_info);
arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm, &oma=
p3_mpu_volt_info);
arch/arm/mach-omap2/omap_twl.c: omap_voltage_register_pmic(voltdm, &oma=
p3_core_volt_info);

so I don't see the point of it returning an 'int'.

There's also:
arch/arm/mach-omap2/io.c: In function =E2=96=A0omap_irq_base_init=E2=96=
=A0:
arch/arm/mach-omap2/io.c:322: warning: unused variable =E2=96=A0omap_ir=
q_base=E2=96=A0

This has never been built with !MULTI_OMAP2:

+/*
+ * Initialize asm_irq_base for entry-macro.S
+ */
+static inline void omap_irq_base_init(void)
+{
+       extern void __iomem *omap_irq_base;
+
+#ifdef MULTI_OMAP2
+       if (cpu_is_omap242x())
+               omap_irq_base =3D OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)=
;
+       else if (cpu_is_omap34xx())
+               omap_irq_base =3D OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)=
;
+       else if (cpu_is_omap44xx())
+               omap_irq_base =3D OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_=
BASE);
+       else
+               pr_err("Could not initialize omap_irq_base\n");
+#endif
+}

and given the code and comment in entry-macros.S, it would be far bette=
r
to define omap_irq_base in here, get rid of the ifdef and always
initialize it, thereby eliminating that variability from needing
multiple different configurations get proper build coverage.

arch/arm/mach-omap2/mux.c: In function =E2=96=A0_omap_mux_get_by_name=E2=
=96=A0:
arch/arm/mach-omap2/mux.c:163: warning: =E2=96=A0found_mode=E2=96=A0 ma=
y be used uninitialized in this function

The build ends with:

In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:37,
                 from arch/arm/mach-omap2/omap_hwmod_common_data.c:19:
arch/arm/plat-omap/include/plat/voltage.h: In function =E2=96=A0omap_vo=
ltage_register_pmic=E2=96=A0:
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return state=
ment in function returning non-void
arch/arm/plat-omap/include/plat/voltage.h: In function =E2=96=A0omap_vo=
ltage_late_init=E2=96=A0:
arch/arm/plat-omap/include/plat/voltage.h:142: error: =E2=96=A0EINVAL=E2=
=96=A0 undeclared (first use in this function)
arch/arm/plat-omap/include/plat/voltage.h:142: error: (Each undeclared =
identifier is reported only once
arch/arm/plat-omap/include/plat/voltage.h:142: error: for each function=
 it appears in.)
make[2]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error 1
make[1]: *** [arch/arm/mach-omap2] Error 2
make[1]: *** Waiting for unfinished jobs....

Adding linux/errno.h to that header resolves that.  That gets us down t=
o
the final link, which fails:

arch/arm/mach-omap2/built-in.o: In function `omap2_set_init_voltage':
arch/arm/mach-omap2/pm.c:181: undefined reference to `omap_voltage_doma=
in_lookup'
arch/arm/mach-omap2/built-in.o: In function `omap3_twl_init':
arch/arm/mach-omap2/omap_twl.c:270: undefined reference to `omap_voltag=
e_domain_lookup'
arch/arm/mach-omap2/omap_twl.c:273: undefined reference to `omap_voltag=
e_domain_lookup'

So, this is what I currently have to get that far:

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/=
mach-omap2/include/mach/entry-macro.S
index befa321..81985a6 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -38,20 +38,6 @@
  */
=20
 #ifdef MULTI_OMAP2
-
-/*
- * We use __glue to avoid errors with multiple definitions of
- * .globl omap_irq_base as it's included from entry-armv.S but not
- * from entry-common.S.
- */
-#ifdef __glue
-		.pushsection .data
-		.globl	omap_irq_base
-omap_irq_base:
-		.word	0
-		.popsection
-#endif
-
 		/*
 		 * Configure the interrupt base on the first interrupt.
 		 * See also omap_irq_base_init for setting omap_irq_base.
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..c203204 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -314,14 +314,13 @@ static int _set_hwmod_postsetup_state(struct omap=
_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
=20
+void __iomem *omap_irq_base;
+
 /*
  * Initialize asm_irq_base for entry-macro.S
  */
 static inline void omap_irq_base_init(void)
 {
-	extern void __iomem *omap_irq_base;
-
-#ifdef MULTI_OMAP2
 	if (cpu_is_omap24xx())
 		omap_irq_base =3D OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
 	else if (cpu_is_omap34xx())
@@ -330,7 +329,6 @@ static inline void omap_irq_base_init(void)
 		omap_irq_base =3D OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE);
 	else
 		pr_err("Could not initialize omap_irq_base\n");
-#endif
 }
=20
 void __init omap2_init_common_infrastructure(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 17bd639..9eaa28c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap=
_mux_partition *partition,
 	struct omap_mux *mux =3D NULL;
 	struct omap_mux_entry *e;
 	const char *mode_name;
-	int found =3D 0, found_mode, mode0_len =3D 0;
+	int found =3D 0, found_mode =3D 0, mode0_len =3D 0;
 	struct list_head *muxmodes =3D &partition->muxmodes;
=20
 	mode_name =3D strchr(muxname, '.');
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-=
omap/include/plat/voltage.h
index 0ff1233..ffcdff9 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -14,6 +14,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
 #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
=20
+#include <linux/errno.h>
+
 #define VOLTSCALE_VPFORCEUPDATE		1
 #define VOLTSCALE_VCBYPASS		2
=20
@@ -133,9 +135,9 @@ void omap_change_voltscale_method(struct voltagedom=
ain *voltdm,
 		int voltscale_method);
 int omap_voltage_late_init(void);
 #else
-static inline int omap_voltage_register_pmic(struct voltagedomain *vol=
tdm,
+static inline void omap_voltage_register_pmic(struct voltagedomain *vo=
ltdm,
 		struct omap_volt_pmic_info *pmic_info) {}
-static inline  void omap_change_voltscale_method(struct voltagedomain =
*voltdm,
+static inline void omap_change_voltscale_method(struct voltagedomain *=
voltdm,
 		int voltscale_method) {}
 static inline int omap_voltage_late_init(void)
 {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
