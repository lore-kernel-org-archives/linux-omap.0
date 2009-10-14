From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/27] OMAP3: PM: GPMC context save/restore
Date: Wed, 14 Oct 2009 14:57:44 -0700
Message-ID: <1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

This patch adds the context save restore functions for GPMC

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/gpmc.c             |   98 +++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/gpmc.h |    3 +
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1587682..6ae189d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -62,6 +62,33 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+/* Structure to save gpmc cs context */
+struct gpmc_cs_config {
+	u32 config1;
+	u32 config2;
+	u32 config3;
+	u32 config4;
+	u32 config5;
+	u32 config6;
+	u32 config7;
+	int is_valid;
+};
+
+/*
+ * Structure to save/restore gpmc context
+ * to support core off on OMAP3
+ */
+struct omap3_gpmc_regs {
+	u32 sysconfig;
+	u32 irqenable;
+	u32 timeout_ctrl;
+	u32 config;
+	u32 prefetch_config1;
+	u32 prefetch_config2;
+	u32 prefetch_control;
+	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
+};
+
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
@@ -261,7 +288,7 @@ static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 	l = (base >> GPMC_CHUNK_SHIFT) & 0x3f;
 	l &= ~(0x0f << 8);
 	l |= ((mask >> GPMC_CHUNK_SHIFT) & 0x0f) << 8;
-	l |= 1 << 6;		/* CSVALID */
+	l |= GPMC_CONFIG7_CSVALID;
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
 }
 
@@ -270,7 +297,7 @@ static void gpmc_cs_disable_mem(int cs)
 	u32 l;
 
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
-	l &= ~(1 << 6);		/* CSVALID */
+	l &= ~GPMC_CONFIG7_CSVALID;
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
 }
 
@@ -290,7 +317,7 @@ static int gpmc_cs_mem_enabled(int cs)
 	u32 l;
 
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
-	return l & (1 << 6);
+	return l & GPMC_CONFIG7_CSVALID;
 }
 
 int gpmc_cs_set_reserved(int cs, int reserved)
@@ -516,3 +543,68 @@ void __init gpmc_init(void)
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
 	gpmc_mem_init();
 }
+
+#ifdef CONFIG_ARCH_OMAP3
+static struct omap3_gpmc_regs gpmc_context;
+
+void omap3_gpmc_save_context()
+{
+	int i;
+	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
+	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
+	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
+	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
+	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
+	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
+	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		gpmc_context.cs_context[i].is_valid = gpmc_cs_mem_enabled(i);
+		if (gpmc_context.cs_context[i].is_valid) {
+			gpmc_context.cs_context[i].config1 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
+			gpmc_context.cs_context[i].config2 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
+			gpmc_context.cs_context[i].config3 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
+			gpmc_context.cs_context[i].config4 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
+			gpmc_context.cs_context[i].config5 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
+			gpmc_context.cs_context[i].config6 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
+			gpmc_context.cs_context[i].config7 =
+				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
+		}
+	}
+}
+
+void omap3_gpmc_restore_context()
+{
+	int i;
+	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
+	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
+	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
+	gpmc_write_reg(GPMC_CONFIG, gpmc_context.config);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG1, gpmc_context.prefetch_config1);
+	gpmc_write_reg(GPMC_PREFETCH_CONFIG2, gpmc_context.prefetch_config2);
+	gpmc_write_reg(GPMC_PREFETCH_CONTROL, gpmc_context.prefetch_control);
+	for (i = 0; i < GPMC_CS_NUM; i++) {
+		if (gpmc_context.cs_context[i].is_valid) {
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG1,
+				gpmc_context.cs_context[i].config1);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG2,
+				gpmc_context.cs_context[i].config2);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG3,
+				gpmc_context.cs_context[i].config3);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG4,
+				gpmc_context.cs_context[i].config4);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG5,
+				gpmc_context.cs_context[i].config5);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG6,
+				gpmc_context.cs_context[i].config6);
+			gpmc_cs_write_reg(i, GPMC_CS_CONFIG7,
+				gpmc_context.cs_context[i].config7);
+		}
+	}
+}
+#endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/plat-omap/include/mach/gpmc.h b/arch/arm/plat-omap/include/mach/gpmc.h
index 9c99cda..696e0ca 100644
--- a/arch/arm/plat-omap/include/mach/gpmc.h
+++ b/arch/arm/plat-omap/include/mach/gpmc.h
@@ -52,6 +52,7 @@
 #define GPMC_CONFIG1_FCLK_DIV2          (GPMC_CONFIG1_FCLK_DIV(1))
 #define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
+#define GPMC_CONFIG7_CSVALID		(1 << 6)
 
 /*
  * Note that all values in this struct are in nanoseconds, while
@@ -107,6 +108,8 @@ extern int gpmc_prefetch_enable(int cs, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
+extern void omap3_gpmc_save_context(void);
+extern void omap3_gpmc_restore_context(void);
 extern void __init gpmc_init(void);
 
 #endif
-- 
1.6.4.3
