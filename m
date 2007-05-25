From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] omap2: add OMAP3430 Power/Reset Management register
	defines to prm.h
Date: Fri, 25 May 2007 02:31:49 -0600
Message-ID: <20070525083243.416578065@pwsan.com>
References: <20070525083145.236366049@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0004-omap2-add-OMAP3430-Power-Reset-Management-register.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants to prm.h for Power/Reset Management registers
on the OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm.h |   52 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 7e1738c..cf2348f 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -2,7 +2,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM_H
 
 /*
- * OMAP2 Power/Reset Management (PRM) register definitions
+ * OMAP2/3 Power/Reset Management (PRM) register definitions
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Copyright (C) 2007 Nokia Corporation
@@ -48,6 +48,45 @@
 #define OMAP24XX_PRCM_CLKSSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0094)
 #define OMAP24XX_PRCM_POLCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0098)
 
+#define OMAP3430_PRM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP3430_PRM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
+
+
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
+#define OMAP3430_PRM_VC_CH_CONF		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
+#define OMAP3430_PRM_RSTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
+#define OMAP3430_PRM_RSTTIME		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
+#define OMAP3430_PRM_RSTST		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define OMAP3430_PRM_VOLTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+#define OMAP3430_PRM_VOLTSETUP1		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
+#define OMAP3430_PRM_VOLTOFFSET		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
+#define OMAP3430_PRM_CLKSETUP		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
+#define OMAP3430_PRM_POLCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
+#define OMAP3430_PRM_VOLTSETUP2		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
+#define OMAP3430_PRM_VP1_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
+#define OMAP3430_PRM_VP1_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
+#define OMAP3430_PRM_VP2_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
+#define OMAP3430_PRM_VP2_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+
 
 /* Power/reset management global register get/set */
 
@@ -92,6 +131,17 @@ static u32 __attribute__((unused)) prm_read_reg(void __iomem *addr)
 #define PM_PWSTCTRL					0x00e0
 #define PM_PWSTST					0x00e4
 
+#define OMAP3430_PM_MPUGRPSEL				0x00a4
+#define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
+
+#define OMAP3430_PM_IVAGRPSEL				0x00a8
+#define OMAP3430_PM_IVAGRPSEL1				OMAP3430_PM_IVAGRPSEL
+
+#define OMAP3430_PM_PREPWSTST				0x00e8
+
+#define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
+#define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
+
 
 /* Architecture-specific registers */
 
-- 
1.5.1.3

-- 
