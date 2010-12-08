From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/11] OMAP4: PRCM: move global reset function for OMAP4 to an
	OMAP4-specific file
Date: Tue, 07 Dec 2010 23:18:36 -0700
Message-ID: <20101208061835.30541.28012.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37175 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0LHGTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:53 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move the OMAP4 global software reset function to the OMAP4-specific
prm44xx.c file, where it belongs.  Part of the long-term process of
moving all of the direct PRCM register writes into lower-layer code.

Also add OCP barriers on OMAP2/3/4 to reduce the chance that the MPU
will continue executing while the system is supposed to be resetting
itself.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c    |   17 ++++++++---------
 arch/arm/mach-omap2/prm44xx.c |   14 ++++++++++++++
 arch/arm/mach-omap2/prm44xx.h |    2 ++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index fe0865b..68c541f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -68,17 +68,16 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 	} else if (cpu_is_omap34xx()) {
 		prcm_offs = OMAP3430_GR_MOD;
 		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
-	} else if (cpu_is_omap44xx())
-		prcm_offs = OMAP4430_PRM_DEVICE_INST;
-	else
+	} else if (cpu_is_omap44xx()) {
+		omap4_prm_global_warm_sw_reset(); /* never returns */
+	} else {
 		WARN_ON(1);
+	}
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
-						 OMAP2_RM_RSTCTRL);
-	if (cpu_is_omap44xx())
-		prm_set_mod_reg_bits(OMAP4430_RST_GLOBAL_WARM_SW_MASK,
-				     prcm_offs, OMAP4_RM_RSTCTRL);
+	/* XXX should be moved to some OMAP2/3 specific code */
+	prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
+			     OMAP2_RM_RSTCTRL);
+	prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index c016ae4..a2a04bf 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -179,3 +179,17 @@ int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift)
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
 
+void omap4_prm_global_warm_sw_reset(void)
+{
+	u32 v;
+
+	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+				    OMAP4_RM_RSTCTRL);
+	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
+	omap4_prm_write_inst_reg(v, OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_RM_RSTCTRL);
+
+	/* OCP barrier */
+	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+				    OMAP4_RM_RSTCTRL);
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3588653..95542ae 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -756,6 +756,8 @@ extern int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shift);
 extern int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
 extern int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);
 
+extern void omap4_prm_global_warm_sw_reset(void);
+
 # endif
 
 #endif


