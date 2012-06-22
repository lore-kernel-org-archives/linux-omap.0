From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 13/13] ARM: OMAP2+: gpmc: configure writeprotect
Date: Fri, 22 Jun 2012 18:27:47 +0530
Message-ID: <0e5d76d0159cb558801515eb2b6957ee581fa305.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932779Ab2FVNNH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:13:07 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

GPMC has a writeprotect pin that can be connected to
peripherals. Default is to disable writeprotect. In
case of conflicting requirement of writeprotect, it
will be left in enabled state to be on safer side,
along with a warning to attract user attention.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   42 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    2 ++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c8e967f..1b0b526 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -110,6 +110,12 @@ enum {
 	GPMC_MAX_NR_WAITPIN
 };
 
+enum {
+	NONE,
+	OFF,
+	ON
+};
+
 struct gpmc_client_irq	{
 	unsigned		irq;
 	u32			bitmask;
@@ -161,6 +167,7 @@ static struct gpmc_peripheral gpmc_peripheral[GPMC_CS_NUM];
 static unsigned gpmc_num_peripheral;
 static unsigned gpmc_waitpin_map;
 static unsigned gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
+static unsigned gpmc_writeprotect;
 
 static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
 static struct irq_chip gpmc_irq_chip;
@@ -192,6 +199,18 @@ static u32 gpmc_read_reg(int idx)
 	return __raw_readl(gpmc_base + idx);
 }
 
+static inline void gpmc_modify_reg(int idx, u32 mask, bool value)
+{
+	u32 l;
+
+	l = gpmc_read_reg(idx);
+	if (value)
+		l |= mask;
+	else
+		l &= ~mask;
+	gpmc_write_reg(idx, l);
+}
+
 static void gpmc_cs_write_byte(int cs, int idx, u8 val)
 {
 	void __iomem *reg_addr;
@@ -991,6 +1010,7 @@ static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
 static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
 {
 	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+	unsigned wp;
 
 	l &= ~(GPMC_CONFIG1_MUXADDDATA |
 		GPMC_CONFIG1_WRITETYPE_SYNC |
@@ -1025,6 +1045,19 @@ static void gpmc_setup_cs_config(unsigned cs, unsigned conf)
 	l |= conf;
 
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+
+	if (conf & GPMC_CONFIG_ENABLE_WRITEPROTECT)
+		wp = ON;
+	else
+		wp = OFF;
+
+	if (gpmc_writeprotect) {
+		if (gpmc_writeprotect != wp) {
+			dev_warn(gpmc_dev, "conflicting writeprotect requests, writeprotect is left enabled\n");
+			gpmc_writeprotect = ON;
+		}
+	} else
+		gpmc_writeprotect = wp;
 }
 
 static inline void gpmc_set_one_timing(int cs, int reg, int start,
@@ -1453,6 +1486,12 @@ int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c)
 }
 EXPORT_SYMBOL_GPL(gpmc_cs_reconfigure);
 
+static inline void gpmc_setup_writeprotect(void)
+{
+	gpmc_modify_reg(GPMC_CONFIG, GPMC_CONFIG_WRITEPROTECT,
+					gpmc_writeprotect == ON ? false : true);
+}
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
@@ -1512,6 +1551,8 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	}
 	gpmc_num_peripheral = g_per - gpmc_peripheral;
 
+	gpmc_setup_writeprotect();
+
 	for (l = 0, g_per = gpmc_peripheral;
 			l < gpmc_num_peripheral; l++, g_per++)
 		if (IS_ERR(gpmc_create_device(g_per)))
@@ -1528,6 +1569,7 @@ static __exit int gpmc_remove(struct platform_device *pdev)
 	for (; gpmc_num_peripheral; g_per++, gpmc_num_peripheral--)
 		platform_device_unregister(g_per->pdev);
 
+	gpmc_writeprotect = NONE;
 	gpmc_waitpin_map = 0;
 	gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
 	gpmc_free_irq();
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 0085a01..3de05dc 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -79,6 +79,8 @@
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
 
+#define	GPMC_CONFIG_ENABLE_WRITEPROTECT	(1 << 5)
+
 #define	GPMC_WAITPIN_ACTIVE_HIGH	(1 << 4)
 #define	GPMC_WAITPIN_ACTIVE_LOW		(0 << 4)
 #define	GPMC_WAITPIN_0			(1 << 0)
-- 
1.7.10.2

