From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/9] ARM: OMAP3/4: PRM: add functions to read pending IRQs,
 PRM barrier
Date: Thu, 15 Dec 2011 14:36:17 -0700
Message-ID: <20111215213615.26632.60191.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759517Ab1LOVhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:40 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>

Add PRM functions to test for pending PRM IRQs.  This will be used in
a subsequent patch to implement the PRM interrupt handler on the MPU.

Add PRM functions to ensure that all outstanding writes from the MPU
to the PRM IP block have completed before continuing execution.  This
will be used in a subsequent patch to ensure that all PRM interrupt
status bits are cleared in the hardware before exiting the ISR.
Normally we would not expose such a low-level function to other code.
But the current implementation of the PRM interrupt code, which uses
the generic IRQ chip code, doesn't give us a choice.

The pending PRM IRQ functions are based on code originally written by
Tero Kristo <t-kristo@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   34 ++++++++++++++++++++++++++++=
-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    7 +++++-
 arch/arm/mach-omap2/prm44xx.c      |   42 ++++++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/prm44xx.h      |    6 ++++-
 4 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.c
index f02d87f..177c3dd 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2/3 PRM module functions
  *
- * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Copyright (C) 2010 Nokia Corporation
  * Beno=C3=AEt Cousson
  * Paul Walmsley
@@ -212,3 +212,35 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offs=
et)
 {
 	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset=
);
 }
+
+/**
+ * omap3xxx_prm_read_pending_irqs - read pending PRM MPU IRQs into @ev=
ents
+ * @events: ptr to a u32, preallocated by caller
+ *
+ * Read PRM_IRQSTATUS_MPU bits, AND'ed with the currently-enabled PRM
+ * MPU IRQs, and store the result into the u32 pointed to by @events.
+ * No return value.
+ */
+void omap3xxx_prm_read_pending_irqs(unsigned long *events)
+{
+	u32 mask, st;
+
+	/* XXX Can the mask read be avoided (e.g., can it come from RAM?) */
+	mask =3D omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFS=
ET);
+	st =3D omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET=
);
+
+	events[0] =3D mask & st;
+}
+
+/**
+ * omap3xxx_prm_ocp_barrier - force buffered MPU writes to the PRM to =
complete
+ *
+ * Force any buffered writes to the PRM IP block to complete.  Needed
+ * by the PRM IRQ handler, which reads and writes directly to the IP
+ * block, to avoid race conditions after acknowledging or clearing IRQ
+ * bits.  No return value.
+ */
+void omap3xxx_prm_ocp_barrier(void)
+{
+	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.h
index cef533d..3ef0e77 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -1,7 +1,7 @@
 /*
  * OMAP2/3 Power/Reset Management (PRM) register definitions
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009, 2011 Texas Instruments, Inc.
  * Copyright (C) 2008-2010 Nokia Corporation
  * Paul Walmsley
  *
@@ -314,6 +314,11 @@ void omap3_prm_vp_clear_txdone(u8 vp_id);
 extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+
+/* PRM interrupt-related functions */
+extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
+extern void omap3xxx_prm_ocp_barrier(void);
+
 #endif	/* CONFIG_ARCH_OMAP4 */
=20
 #endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44x=
x.c
index 495a31a..9b21154 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -121,3 +121,45 @@ u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offs=
et)
 					       OMAP4430_PRM_DEVICE_INST,
 					       offset);
 }
+
+static inline u32 _read_pending_irq_reg(u16 irqen_offs, u16 irqst_offs=
)
+{
+	u32 mask, st;
+
+	/* XXX read mask from RAM? */
+	mask =3D omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqen_offs=
);
+	st =3D omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, irqst_offs);
+
+	return mask & st;
+}
+
+/**
+ * omap44xx_prm_read_pending_irqs - read pending PRM MPU IRQs into @ev=
ents
+ * @events: ptr to two consecutive u32s, preallocated by caller
+ *
+ * Read PRM_IRQSTATUS_MPU* bits, AND'ed with the currently-enabled PRM
+ * MPU IRQs, and store the result into the two u32s pointed to by @eve=
nts.
+ * No return value.
+ */
+void omap44xx_prm_read_pending_irqs(unsigned long *events)
+{
+	events[0] =3D _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_OFFSET,
+					  OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
+
+	events[1] =3D _read_pending_irq_reg(OMAP4_PRM_IRQENABLE_MPU_2_OFFSET,
+					  OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
+}
+
+/**
+ * omap44xx_prm_ocp_barrier - force buffered MPU writes to the PRM to =
complete
+ *
+ * Force any buffered writes to the PRM IP block to complete.  Needed
+ * by the PRM IRQ handler, which reads and writes directly to the IP
+ * block, to avoid race conditions after acknowledging or clearing IRQ
+ * bits.  No return value.
+ */
+void omap44xx_prm_ocp_barrier(void)
+{
+	omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+				OMAP4_REVISION_PRM_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44x=
x.h
index 3d66ccd..bd7f248 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -1,7 +1,7 @@
 /*
  * OMAP44xx PRM instance offset macros
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Paul Walmsley (paul@pwsan.com)
@@ -763,6 +763,10 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
=20
+/* PRM interrupt-related functions */
+extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
+extern void omap44xx_prm_ocp_barrier(void);
+
 # endif
=20
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
