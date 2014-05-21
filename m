From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 05/16] ARM: OMAP2+: gpmc: Use low level read/write for
 context save/restore
Date: Wed, 21 May 2014 14:20:53 +0300
Message-ID: <1400671264-10702-6-git-send-email-rogerq@ti.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1400671264-10702-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, robertcnelson@gmail.com, jg1.han@samsung.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This will make it easier to move the GPMC driver out of arch/arm/mach-omap2.
Just the context save/restore code can remain there without any dependency
with the GPMC driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 121 +++++++++++++++++++++++++++++++--------------
 arch/arm/mach-omap2/gpmc.h |   1 +
 arch/arm/mach-omap2/io.c   |   2 +
 3 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 04bae67..26b26ec 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1976,34 +1976,80 @@ static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 
 static struct omap3_gpmc_regs gpmc_context;
 
+/*
+ * Below code only for OMAP3 OFF mode support.
+ * This code must be left back in mach-omap2.
+ */
+void __iomem *omap2_gpmc_base;
+
+void __init omap2_set_globals_gpmc(void __iomem *gpmc)
+{
+	omap2_gpmc_base = gpmc;
+}
+
+static u32 _gpmc_read_reg(u16 reg)
+{
+	return __raw_readl(omap2_gpmc_base + reg);
+}
+
+static void _gpmc_write_reg(u32 val, u16 reg)
+{
+	__raw_readl(omap2_gpmc_base + reg);
+}
+
+static u32 _gpmc_cs_read_reg(int cs, int idx)
+{
+	u16 reg;
+
+	reg = GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+
+	return _gpmc_read_reg(reg);
+}
+
+static void _gpmc_cs_write_reg(int cs, int idx, u32 val)
+{
+	u16 reg;
+
+	reg = GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+	_gpmc_write_reg(val, reg);
+}
+
 void omap3_gpmc_save_context(void)
 {
 	int i;
+	u32 val;
+
+	if (!omap2_gpmc_base)
+		return;
 
-	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
-	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
-	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
-	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
-	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
-	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
-	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
+	gpmc_context.sysconfig = _gpmc_read_reg(GPMC_SYSCONFIG);
+	gpmc_context.irqenable = _gpmc_read_reg(GPMC_IRQENABLE);
+	gpmc_context.timeout_ctrl = _gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
+	gpmc_context.config = _gpmc_read_reg(GPMC_CONFIG);
+	gpmc_context.prefetch_config1 = _gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	gpmc_context.prefetch_config2 = _gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
+	gpmc_context.prefetch_control = _gpmc_read_reg(GPMC_PREFETCH_CONTROL);
 	for (i = 0; i < gpmc_cs_num; i++) {
-		gpmc_context.cs_context[i].is_valid = gpmc_cs_mem_enabled(i);
+		/* check if valid */
+		val = _gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
+		gpmc_context.cs_context[i].is_valid =
+						val & GPMC_CONFIG7_CSVALID;
+
 		if (gpmc_context.cs_context[i].is_valid) {
 			gpmc_context.cs_context[i].config1 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
 			gpmc_context.cs_context[i].config2 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
 			gpmc_context.cs_context[i].config3 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
 			gpmc_context.cs_context[i].config4 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
 			gpmc_context.cs_context[i].config5 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
 			gpmc_context.cs_context[i].config6 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
 			gpmc_context.cs_context[i].config7 =
-				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
+				_gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
 		}
 	}
 }
@@ -2012,29 +2058,32 @@ void omap3_gpmc_restore_context(void)
 {
 	int i;
 
-	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
-	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
-	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
-	gpmc_write_reg(GPMC_CONFIG, gpmc_context.config);
-	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_context.prefetch_config1);
-	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_context.prefetch_config2);
-	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_context.prefetch_control);
+	if (!omap2_gpmc_base)
+		return;
+
+	_gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
+	_gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
+	_gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
+	_gpmc_write_reg(GPMC_CONFIG, gpmc_context.config);
+	_gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_context.prefetch_config1);
+	_gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_context.prefetch_config2);
+	_gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_context.prefetch_control);
 	for (i = 0; i < gpmc_cs_num; i++) {
 		if (gpmc_context.cs_context[i].is_valid) {
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
-				gpmc_context.cs_context[i].config1);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
-				gpmc_context.cs_context[i].config2);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
-				gpmc_context.cs_context[i].config3);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
-				gpmc_context.cs_context[i].config4);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
-				gpmc_context.cs_context[i].config5);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
-				gpmc_context.cs_context[i].config6);
-			gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
-				gpmc_context.cs_context[i].config7);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
+					   gpmc_context.cs_context[i].config1);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
+					   gpmc_context.cs_context[i].config2);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
+					   gpmc_context.cs_context[i].config3);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
+					   gpmc_context.cs_context[i].config4);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
+					   gpmc_context.cs_context[i].config5);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
+					   gpmc_context.cs_context[i].config6);
+			_gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
+					   gpmc_context.cs_context[i].config7);
 		}
 	}
 }
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index c18b022..795502f 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -107,4 +107,5 @@ extern int gpmc_generic_init(int cs, enum gpmc_omap_type type,
 			     struct platform_device *pdev,
 			     unsigned pdata_size);
 
+void __init omap2_set_globals_gpmc(void __iomem *gpmc);
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f14f9ac..e3321fd 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -53,6 +53,7 @@
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
+#include "gpmc.h"
 
 /*
  * omap_clk_soc_init: points to a function that does the SoC-specific
@@ -464,6 +465,7 @@ void __init omap3_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
+	omap2_set_globals_gpmc(OMAP2_L3_IO_ADDRESS(OMAP34XX_GPMC_BASE));
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap3xxx_prm_init();
-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
