From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 03/13] OMAP3+: PRM: add register access functions for VC/VP
Date: Fri,  1 Apr 2011 16:41:01 -0700
Message-ID: <1301701271-22096-4-git-send-email-khilman@ti.com>
References: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49593 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1DAXki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:38 -0400
Received: by iyi12 with SMTP id 12so4837252iyi.37
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:37 -0700 (PDT)
In-Reply-To: <1301701271-22096-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On OMAP3+, the voltage controller (VC) and voltage processor (VP) are
inside the PRM.  Add some PRM helper functions for register access to
these module registers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   15 +++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    8 ++++++++
 arch/arm/mach-omap2/prm44xx.c      |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h      |    8 ++++++++
 4 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 58c5c87..3b83763 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -197,3 +197,18 @@ void omap3_prm_vp_clear_txdone(u8 vp_id)
 	omap2_prm_write_mod_reg(vp->tranxdone_status,
 				OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 }
+
+u32 omap3_prm_vcvp_read(u8 offset)
+{
+	return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, offset);
+}
+
+void omap3_prm_vcvp_write(u32 val, u8 offset)
+{
+	omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD, offset);
+}
+
+u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
+{
+	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset);
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 5112526..cef533d 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -307,7 +307,15 @@ extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
 void omap3_prm_vp_clear_txdone(u8 vp_id);
 
+/*
+ * OMAP3 access functions for voltage controller (VC) and
+ * voltage proccessor (VP) in the PRM.
+ */
+extern u32 omap3_prm_vcvp_read(u8 offset);
+extern void omap3_prm_vcvp_write(u32 val, u8 offset);
+extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 #endif	/* CONFIG_ARCH_OMAP4 */
+
 #endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 3bb2f61..8a3bba3 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -24,6 +24,8 @@
 #include "vp.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
+#include "prcm44xx.h"
+#include "prminst44xx.h"
 
 /*
  * Address offset (in bytes) between the reset control and the reset
@@ -242,3 +244,23 @@ void omap4_prm_vp_clear_txdone(u8 vp_id)
 				     OMAP4430_PRM_OCP_SOCKET_INST,
 				     vp->irqstatus_mpu);
 };
+
+u32 omap4_prm_vcvp_read(u8 offset)
+{
+	return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+					   OMAP4430_PRM_DEVICE_INST, offset);
+}
+
+void omap4_prm_vcvp_write(u32 val, u8 offset)
+{
+	omap4_prminst_write_inst_reg(val, OMAP4430_PRM_PARTITION,
+				     OMAP4430_PRM_DEVICE_INST, offset);
+}
+
+u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
+{
+	return omap4_prminst_rmw_inst_reg_bits(mask, bits,
+					       OMAP4430_PRM_PARTITION,
+					       OMAP4430_PRM_DEVICE_INST,
+					       offset);
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index e385366..048c8e5 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -777,6 +777,14 @@ extern void omap4_prm_global_warm_sw_reset(void);
 u32 omap4_prm_vp_check_txdone(u8 vp_id);
 void omap4_prm_vp_clear_txdone(u8 vp_id);
 
+/*
+ * OMAP4 access functions for voltage controller (VC) and
+ * voltage proccessor (VP) in the PRM.
+ */
+extern u32 omap4_prm_vcvp_read(u8 offset);
+extern void omap4_prm_vcvp_write(u32 val, u8 offset);
+extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
+
 # endif
 
 #endif
-- 
1.7.4

