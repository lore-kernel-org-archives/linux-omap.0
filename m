From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/5] OMAP McSPI: Adapt McSPI driver to use omap hwmod
Date: Fri, 13 Aug 2010 19:35:23 +0530
Message-ID: <1281708323-18989-6-git-send-email-charu@ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com>
 <1281708323-18989-3-git-send-email-charu@ti.com>
 <1281708323-18989-4-git-send-email-charu@ti.com>
 <1281708323-18989-5-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34381 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934415Ab0HMODK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 10:03:10 -0400
In-Reply-To: <1281708323-18989-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com

From: Govindraj.R <govindraj.raja@ti.com>

This patch converts the McSPI driver to use pm_runtime apis while
implementing it in HWMOD FW way.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c    |    4 +
 arch/arm/mach-omap2/devices.c           |  233 ++++++++++-----------------
 arch/arm/plat-omap/include/plat/mcspi.h |   27 +++
 drivers/spi/omap2_mcspi.c               |  273 ++++++++++---------------------
 4 files changed, 204 insertions(+), 333 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 138646d..9482e4d 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1558,6 +1558,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };
 
 static struct clk mcspi3_fck = {
@@ -1567,6 +1568,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };
 
 static struct clk mcspi2_fck = {
@@ -1576,6 +1578,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };
 
 static struct clk mcspi1_fck = {
@@ -1585,6 +1588,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };
 
 static struct clk uart2_fck = {
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index fa99da1..a869c35 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -239,170 +241,103 @@ static inline void omap_init_sti(void) {}
 
 #include <plat/mcspi.h>
 
-#define OMAP2_MCSPI1_BASE		0x48098000
-#define OMAP2_MCSPI2_BASE		0x4809a000
-#define OMAP2_MCSPI3_BASE		0x480b8000
-#define OMAP2_MCSPI4_BASE		0x480ba000
-
-#define OMAP4_MCSPI1_BASE		0x48098100
-#define OMAP4_MCSPI2_BASE		0x4809a100
-#define OMAP4_MCSPI3_BASE		0x480b8100
-#define OMAP4_MCSPI4_BASE		0x480ba100
-
-static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
-	.num_cs		= 4,
-	.force_cs_mode	= 1,
-};
-
-static struct resource omap2_mcspi1_resources[] = {
-	{
-		.start		= OMAP2_MCSPI1_BASE,
-		.end		= OMAP2_MCSPI1_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi1 = {
-	.name		= "omap2_mcspi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi1_resources),
-	.resource	= omap2_mcspi1_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi1_config,
-	},
-};
-
-static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
-	.num_cs		= 2,
-	.mode		= OMAP2_MCSPI_MASTER,
-	.dma_mode	= 0,
-	.force_cs_mode	= 0,
-	.fifo_depth	= 0,
-};
-
-static struct resource omap2_mcspi2_resources[] = {
-	{
-		.start		= OMAP2_MCSPI2_BASE,
-		.end		= OMAP2_MCSPI2_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi2 = {
-	.name		= "omap2_mcspi",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi2_resources),
-	.resource	= omap2_mcspi2_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi2_config,
-	},
-};
-
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
-	defined(CONFIG_ARCH_OMAP4)
-static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
-	.num_cs		= 2,
-};
-
-static struct resource omap2_mcspi3_resources[] = {
-	{
-	.start		= OMAP2_MCSPI3_BASE,
-	.end		= OMAP2_MCSPI3_BASE + 0xff,
-	.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi3 = {
-	.name		= "omap2_mcspi",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi3_resources),
-	.resource	= omap2_mcspi3_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi3_config,
-	},
-};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
-	.num_cs		= 1,
-};
-
-static struct resource omap2_mcspi4_resources[] = {
-	{
-		.start		= OMAP2_MCSPI4_BASE,
-		.end		= OMAP2_MCSPI4_BASE + 0xff,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_mcspi4 = {
-	.name		= "omap2_mcspi",
-	.id		= 4,
-	.num_resources	= ARRAY_SIZE(omap2_mcspi4_resources),
-	.resource	= omap2_mcspi4_resources,
-	.dev		= {
-		.platform_data = &omap2_mcspi4_config,
-	},
-};
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static inline void omap4_mcspi_fixup(void)
+struct omap_device_pm_latency omap_mcspi_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static const u16 omap2_reg_map[] = {
+	[OMAP2_MCSPI_REVISION]		= 0x00,
+	[OMAP2_MCSPI_SYSCONFIG]		= 0x10,
+	[OMAP2_MCSPI_SYSSTATUS]		= 0x14,
+	[OMAP2_MCSPI_IRQSTATUS]		= 0x18,
+	[OMAP2_MCSPI_IRQENABLE]		= 0x1c,
+	[OMAP2_MCSPI_WAKEUPENABLE]	= 0x20,
+	[OMAP2_MCSPI_SYST]		= 0x24,
+	[OMAP2_MCSPI_MODULCTRL]		= 0x28,
+	[OMAP2_MCSPI_XFERLEVEL]		= 0x7c,
+	[OMAP2_MCSPI_CHCONF0]		= 0x2c,
+	[OMAP2_MCSPI_CHSTAT0]		= 0x30,
+	[OMAP2_MCSPI_CHCTRL0]		= 0x34,
+	[OMAP2_MCSPI_TX0]		= 0x38,
+	[OMAP2_MCSPI_RX0]		= 0x3c,
+};
+
+static const u16 omap4_reg_map[] = {
+	[OMAP2_MCSPI_REVISION]		= 0x100,
+	[OMAP2_MCSPI_SYSCONFIG]		= 0x110,
+	[OMAP2_MCSPI_SYSSTATUS]		= 0x114,
+	[OMAP2_MCSPI_IRQSTATUS]		= 0x118,
+	[OMAP2_MCSPI_IRQENABLE]		= 0x01c,
+	[OMAP2_MCSPI_WAKEUPENABLE]	= 0x120,
+	[OMAP2_MCSPI_SYST]		= 0x124,
+	[OMAP2_MCSPI_MODULCTRL]		= 0x128,
+	[OMAP2_MCSPI_XFERLEVEL]		= 0x17c,
+	[OMAP2_MCSPI_CHCONF0]		= 0x12c,
+	[OMAP2_MCSPI_CHSTAT0]		= 0x130,
+	[OMAP2_MCSPI_CHCTRL0]		= 0x134,
+	[OMAP2_MCSPI_TX0]		= 0x138,
+	[OMAP2_MCSPI_RX0]		= 0x13c,
+	[OMAP2_MCSPI_HL_REV]		= 0x000,
+	[OMAP2_MCSPI_HL_HWINFO]		= 0x004,
+	[OMAP2_MCSPI_HL_SYSCONFIG]	= 0x010,
+};
+
+static int omap_mcspi_init(struct omap_hwmod *oh, void *user)
 {
-	omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
-	omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
-	omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
-	omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
-	omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
-	omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
-	omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
-	omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
-}
-#else
-static inline void omap4_mcspi_fixup(void)
-{
-}
-#endif
+	struct omap_device *od;
+	char *name = "omap2_mcspi";
+	struct omap2_mcspi_platform_config *pdata;
+	static int spi_num;
+
+	pdata = kzalloc(sizeof(struct omap2_mcspi_platform_config),
+				GFP_KERNEL);
+	if (!pdata) {
+		pr_err("\nMemory allocation for Mcspi device failed\n");
+		return -ENOMEM;
+	}
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
-	defined(CONFIG_ARCH_OMAP4)
-static inline void omap2_mcspi3_init(void)
-{
-	platform_device_register(&omap2_mcspi3);
-}
-#else
-static inline void omap2_mcspi3_init(void)
-{
-}
-#endif
+	switch (spi_num) {
+	case 0:
+		pdata->num_cs = 4;
+		pdata->force_cs_mode = 1;
+		break;
+	case 1:
+		pdata->num_cs = 2;
+		pdata->mode = OMAP2_MCSPI_MASTER;
+		pdata->dma_mode = 1;
+		pdata->force_cs_mode = 0;
+		pdata->fifo_depth = 0;
+		break;
+	case 2:
+		pdata->num_cs = 2;
+		break;
+	case 3:
+		pdata->num_cs = 1;
+		break;
+	}
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static inline void omap2_mcspi4_init(void)
-{
-	platform_device_register(&omap2_mcspi4);
-}
-#else
-static inline void omap2_mcspi4_init(void)
-{
+	if (cpu_is_omap44xx())
+		pdata->regs_data = (u16 *)omap4_reg_map;
+	else
+		pdata->regs_data = (u16 *)omap2_reg_map;
+
+	od = omap_device_build(name, spi_num + 1, oh, pdata,
+				sizeof(*pdata),	omap_mcspi_latency,
+				ARRAY_SIZE(omap_mcspi_latency), 0);
+	WARN(IS_ERR(od), "\nCant build omap_device for %s:%s\n",
+				name, oh->name);
+	spi_num++;
+	return 0;
 }
-#endif
 
 static void omap_init_mcspi(void)
 {
-	if (cpu_is_omap44xx())
-		omap4_mcspi_fixup();
-
-	platform_device_register(&omap2_mcspi1);
-	platform_device_register(&omap2_mcspi2);
-
-	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
-		omap2_mcspi3_init();
-
-	if (cpu_is_omap343x() || cpu_is_omap44xx())
-		omap2_mcspi4_init();
+	omap_hwmod_for_each_by_class("mcspi", omap_mcspi_init, NULL);
 }
-
 #else
 static inline void omap_init_mcspi(void) {}
 #endif
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 23b928b..27161be 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,6 +1,10 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H
 
+#if defined CONFIG_ARCH_OMAP2PLUS
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
 #define OMAP2_MCSPI_MASTER		0
 #define OMAP2_MCSPI_SLAVE		1
 
@@ -30,6 +34,7 @@ struct omap2_mcspi_platform_config {
 	u8	dma_mode;
 	u8	force_cs_mode;
 	unsigned short fifo_depth;
+	u16	*regs_data;
 };
 
 struct omap2_mcspi_device_config {
@@ -39,4 +44,26 @@ struct omap2_mcspi_device_config {
 	unsigned single_channel:1;
 };
 
+enum {
+	OMAP2_MCSPI_REVISION = 0,
+	OMAP2_MCSPI_SYSCONFIG,
+	OMAP2_MCSPI_SYSSTATUS,
+	OMAP2_MCSPI_IRQSTATUS,
+	OMAP2_MCSPI_IRQENABLE,
+	OMAP2_MCSPI_WAKEUPENABLE,
+	OMAP2_MCSPI_SYST,
+	OMAP2_MCSPI_MODULCTRL,
+	OMAP2_MCSPI_XFERLEVEL,
+	OMAP2_MCSPI_CHCONF0,
+	OMAP2_MCSPI_CHSTAT0,
+	OMAP2_MCSPI_CHCTRL0,
+	OMAP2_MCSPI_TX0,
+	OMAP2_MCSPI_RX0,
+	OMAP2_MCSPI_HL_REV,
+	OMAP2_MCSPI_HL_HWINFO,
+	OMAP2_MCSPI_HL_SYSCONFIG,
+};
+
+#endif
+
 #endif
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 0c9d1be..44a8bb0 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -33,6 +33,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/spi/spi.h>
 
@@ -43,35 +44,11 @@
 #define OMAP2_MCSPI_MAX_FREQ		48000000
 #define OMAP2_MCSPI_MAX_FIFODEPTH       64
 
-/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
+/* OMAP2 has 3 SPI controllers, while OMAP3/4 has 4 */
 #define OMAP2_MCSPI_MAX_CTRL 		4
 
-#define OMAP2_MCSPI_REVISION		0x00
-#define OMAP2_MCSPI_SYSCONFIG		0x10
-#define OMAP2_MCSPI_SYSSTATUS		0x14
-#define OMAP2_MCSPI_IRQSTATUS		0x18
-#define OMAP2_MCSPI_IRQENABLE		0x1c
-#define OMAP2_MCSPI_WAKEUPENABLE	0x20
-#define OMAP2_MCSPI_SYST		0x24
-#define OMAP2_MCSPI_MODULCTRL		0x28
-#define OMAP2_MCSPI_XFERLEVEL		0x7c
-
-/* per-channel banks, 0x14 bytes each, first is: */
-#define OMAP2_MCSPI_CHCONF0		0x2c
-#define OMAP2_MCSPI_CHSTAT0		0x30
-#define OMAP2_MCSPI_CHCTRL0		0x34
-#define OMAP2_MCSPI_TX0			0x38
-#define OMAP2_MCSPI_RX0			0x3c
-
 /* per-register bitmasks: */
 
-#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	BIT(4)
-#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	BIT(2)
-#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	BIT(0)
-#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	BIT(1)
-
-#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	BIT(0)
-
 #define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
 #define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
 #define OMAP2_MCSPI_MODULCTRL_STEST	BIT(3)
@@ -127,10 +104,9 @@ struct omap2_mcspi {
 	spinlock_t		lock;
 	struct list_head	msg_queue;
 	struct spi_master	*master;
-	struct clk		*ick;
-	struct clk		*fck;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
+	u16			*regs;
 	unsigned long		phys;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
@@ -138,6 +114,7 @@ struct omap2_mcspi {
 	u8			dma_mode;
 	u8			force_cs_mode;
 	u16			fifo_depth;
+	struct  device          *dev;
 };
 
 struct omap2_mcspi_cs {
@@ -153,7 +130,6 @@ struct omap2_mcspi_cs {
  * corresponding registers are modified.
  */
 struct omap2_mcspi_regs {
-	u32 sysconfig;
 	u32 modulctrl;
 	u32 wakeupenable;
 	struct list_head cs;
@@ -206,29 +182,33 @@ static inline void mcspi_write_reg(struct spi_master *master,
 {
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
-	__raw_writel(val, mcspi->base + idx);
+	__raw_writel(val, mcspi->base + mcspi->regs[idx]);
 }
 
 static inline u32 mcspi_read_reg(struct spi_master *master, int idx)
 {
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
-	return __raw_readl(mcspi->base + idx);
+	return __raw_readl(mcspi->base + mcspi->regs[idx]);
 }
 
 static inline void mcspi_write_cs_reg(const struct spi_device *spi,
 		int idx, u32 val)
 {
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	struct spi_master *master = spi->master;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
-	__raw_writel(val, cs->base +  idx);
+	__raw_writel(val, cs->base + mcspi->regs[idx]);
 }
 
 static inline u32 mcspi_read_cs_reg(const struct spi_device *spi, int idx)
 {
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	struct spi_master *master = spi->master;
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
-	return __raw_readl(cs->base + idx);
+	return __raw_readl(cs->base + mcspi->regs[idx]);
 }
 
 static inline u32 mcspi_cached_chconf0(const struct spi_device *spi)
@@ -454,32 +434,23 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
 
-	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
-			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
-
 	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
 			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
 
 	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
 			node)
-		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
+		__raw_writel(cs->chconf0, cs->base +
+				mcspi->regs[OMAP2_MCSPI_CHCONF0]);
 }
-static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
+
+static inline void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
-	clk_disable(mcspi->ick);
-	clk_disable(mcspi->fck);
+	pm_runtime_put_sync(mcspi->dev);
 }
 
-static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
+static inline int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
 {
-	if (clk_enable(mcspi->ick))
-		return -ENODEV;
-	if (clk_enable(mcspi->fck))
-		return -ENODEV;
-
-	omap2_mcspi_restore_ctx(mcspi);
-
-	return 0;
+	return pm_runtime_get_sync(mcspi->dev);
 }
 
 static unsigned
@@ -499,7 +470,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-	irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
+	irqstat_reg = mcspi->base + mcspi->regs[OMAP2_MCSPI_IRQSTATUS];
 	l = mcspi_cached_chconf0(spi);
 
 	count = xfer->len;
@@ -507,8 +478,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	word_len = cs->word_len;
 
 	base = cs->phys;
-	tx_reg = base + OMAP2_MCSPI_TX0;
-	rx_reg = base + OMAP2_MCSPI_RX0;
+	tx_reg = base + mcspi->regs[OMAP2_MCSPI_TX0];
+	rx_reg = base + mcspi->regs[OMAP2_MCSPI_RX0];
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
 
@@ -692,9 +663,9 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 
 	/* We store the pre-calculated register addresses on stack to speed
 	 * up the transfer loop. */
-	tx_reg		= base + OMAP2_MCSPI_TX0;
-	rx_reg		= base + OMAP2_MCSPI_RX0;
-	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
+	tx_reg		= base + mcspi->regs[OMAP2_MCSPI_TX0];
+	rx_reg		= base + mcspi->regs[OMAP2_MCSPI_RX0];
+	chstat_reg	= base + mcspi->regs[OMAP2_MCSPI_CHSTAT0];
 
 	if (word_len <= 8) {
 		u8		*rx;
@@ -1047,7 +1018,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return ret;
 	}
 
-	if (omap2_mcspi_enable_clocks(mcspi))
+	if (omap2_mcspi_enable_clocks(mcspi) < 0)
 		return -ENODEV;
 
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
@@ -1091,10 +1062,11 @@ static void omap2_mcspi_work(struct work_struct *work)
 	struct omap2_mcspi	*mcspi;
 
 	mcspi = container_of(work, struct omap2_mcspi, work);
-	spin_lock_irq(&mcspi->lock);
 
 	if (omap2_mcspi_enable_clocks(mcspi))
-		goto out;
+		return;
+
+	spin_lock_irq(&mcspi->lock);
 
 	/* We only enable one channel at a time -- the one whose message is
 	 * at the head of the queue -- although this controller would gladly
@@ -1169,7 +1141,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 				/* RX_ONLY mode needs dummy data in TX reg */
 				if (t->tx_buf == NULL)
 					__raw_writel(0, cs->base
-							+ OMAP2_MCSPI_TX0);
+						+ mcspi->regs[OMAP2_MCSPI_TX0]);
 
 				if (m->is_dma_mapped ||
 					t->len >= DMA_MIN_BYTES ||
@@ -1218,10 +1190,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 		spin_lock_irq(&mcspi->lock);
 	}
 
-	omap2_mcspi_disable_clocks(mcspi);
-
-out:
 	spin_unlock_irq(&mcspi->lock);
+
+	omap2_mcspi_disable_clocks(mcspi);
 }
 
 static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
@@ -1315,21 +1286,9 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	u32			tmp;
 	u32			error = 0;
 
-	if (omap2_mcspi_enable_clocks(mcspi))
+	if (omap2_mcspi_enable_clocks(mcspi) < 0)
 		return -1;
 
-	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
-			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
-	do {
-		tmp = mcspi_read_reg(master, OMAP2_MCSPI_SYSSTATUS);
-	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
-
-	tmp = OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
-		OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
-		OMAP2_MCSPI_SYSCONFIG_SMARTIDLE;
-	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG, tmp);
-	omap2_mcspi_ctx[master->bus_num - 1].sysconfig = tmp;
-
 	tmp = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp);
 	omap2_mcspi_ctx[master->bus_num - 1].wakeupenable = tmp;
@@ -1343,52 +1302,22 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	return error;
 }
 
-static u8 __initdata spi1_rxdma_id [] = {
-	OMAP24XX_DMA_SPI1_RX0,
-	OMAP24XX_DMA_SPI1_RX1,
-	OMAP24XX_DMA_SPI1_RX2,
-	OMAP24XX_DMA_SPI1_RX3,
-};
-
-static u8 __initdata spi1_txdma_id [] = {
-	OMAP24XX_DMA_SPI1_TX0,
-	OMAP24XX_DMA_SPI1_TX1,
-	OMAP24XX_DMA_SPI1_TX2,
-	OMAP24XX_DMA_SPI1_TX3,
-};
-
-static u8 __initdata spi2_rxdma_id[] = {
-	OMAP24XX_DMA_SPI2_RX0,
-	OMAP24XX_DMA_SPI2_RX1,
-};
-
-static u8 __initdata spi2_txdma_id[] = {
-	OMAP24XX_DMA_SPI2_TX0,
-	OMAP24XX_DMA_SPI2_TX1,
-};
-
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
-	|| defined(CONFIG_ARCH_OMAP4)
-static u8 __initdata spi3_rxdma_id[] = {
-	OMAP24XX_DMA_SPI3_RX0,
-	OMAP24XX_DMA_SPI3_RX1,
-};
+static int omap_mcspi_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
 
-static u8 __initdata spi3_txdma_id[] = {
-	OMAP24XX_DMA_SPI3_TX0,
-	OMAP24XX_DMA_SPI3_TX1,
-};
-#endif
+static int omap_mcspi_runtime_resume(struct device *dev)
+{
+	struct omap2_mcspi	*mcspi;
+	struct spi_master	*master;
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static u8 __initdata spi4_rxdma_id[] = {
-	OMAP34XX_DMA_SPI4_RX0,
-};
+	master = dev_get_drvdata(dev);
+	mcspi = spi_master_get_devdata(master);
+	omap2_mcspi_restore_ctx(mcspi);
 
-static u8 __initdata spi4_txdma_id[] = {
-	OMAP34XX_DMA_SPI4_TX0,
-};
-#endif
+	return 0;
+}
 
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
@@ -1398,38 +1327,6 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
-	const u8		*rxdma_id, *txdma_id;
-	unsigned		num_chipselect;
-
-	switch (pdev->id) {
-	case 1:
-		rxdma_id = spi1_rxdma_id;
-		txdma_id = spi1_txdma_id;
-		num_chipselect = 4;
-		break;
-	case 2:
-		rxdma_id = spi2_rxdma_id;
-		txdma_id = spi2_txdma_id;
-		num_chipselect = 2;
-		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
-	|| defined(CONFIG_ARCH_OMAP4)
-	case 3:
-		rxdma_id = spi3_rxdma_id;
-		txdma_id = spi3_txdma_id;
-		num_chipselect = 2;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	case 4:
-		rxdma_id = spi4_rxdma_id;
-		txdma_id = spi4_txdma_id;
-		num_chipselect = 1;
-		break;
-#endif
-	default:
-		return -EINVAL;
-	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
 	if (master == NULL) {
@@ -1446,7 +1343,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->transfer = omap2_mcspi_transfer;
 	master->cleanup = omap2_mcspi_cleanup;
-	master->num_chipselect = num_chipselect;
+	master->num_chipselect = pdata->num_cs;
 
 	dev_set_drvdata(&pdev->dev, master);
 
@@ -1455,6 +1352,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi->mcspi_mode = OMAP2_MCSPI_MASTER;
 	mcspi->dma_mode = pdata->dma_mode;
 	mcspi->force_cs_mode = pdata->force_cs_mode;
+	mcspi->regs = pdata->regs_data;
 
 	if (pdata->fifo_depth <= OMAP2_MCSPI_MAX_FIFODEPTH)
 		mcspi->fifo_depth = pdata->fifo_depth;
@@ -1479,63 +1377,67 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 	if (!mcspi->base) {
 		dev_dbg(&pdev->dev, "can't ioremap MCSPI\n");
 		status = -ENOMEM;
-		goto err1aa;
+		goto err2;
 	}
 
+	mcspi->dev = &pdev->dev;
 	INIT_WORK(&mcspi->work, omap2_mcspi_work);
 
 	spin_lock_init(&mcspi->lock);
 	INIT_LIST_HEAD(&mcspi->msg_queue);
 	INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs);
 
-	mcspi->ick = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(mcspi->ick)) {
-		dev_dbg(&pdev->dev, "can't get mcspi_ick\n");
-		status = PTR_ERR(mcspi->ick);
-		goto err1a;
-	}
-	mcspi->fck = clk_get(&pdev->dev, "fck");
-	if (IS_ERR(mcspi->fck)) {
-		dev_dbg(&pdev->dev, "can't get mcspi_fck\n");
-		status = PTR_ERR(mcspi->fck);
-		goto err2;
-	}
-
 	mcspi->dma_channels = kcalloc(master->num_chipselect,
 			sizeof(struct omap2_mcspi_dma),
 			GFP_KERNEL);
 
 	if (mcspi->dma_channels == NULL)
-		goto err3;
+		goto err2;
 
-	for (i = 0; i < num_chipselect; i++) {
+	for (i = 0; i < pdata->num_cs; i++) {
+		char dma_ch_name[14];
+		struct resource *dma_res;
+
+		sprintf(dma_ch_name, "rx%d", i);
+		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+							dma_ch_name);
+		if (!dma_res) {
+			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
+			status = -ENODEV;
+			break;
+		}
 		mcspi->dma_channels[i].dma_rx_channel = -1;
-		mcspi->dma_channels[i].dma_rx_sync_dev = rxdma_id[i];
+		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
+
+		sprintf(dma_ch_name, "tx%d", i);
+		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+							dma_ch_name);
+		if (!dma_res) {
+			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
+			status = -ENODEV;
+			break;
+		}
 		mcspi->dma_channels[i].dma_tx_channel = -1;
-		mcspi->dma_channels[i].dma_tx_sync_dev = txdma_id[i];
+		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
 	}
 
-	if (omap2_mcspi_reset(mcspi) < 0)
-		goto err4;
+	pm_runtime_enable(&pdev->dev);
+	if (status || omap2_mcspi_reset(mcspi) < 0)
+		goto err3;
 
 	status = spi_register_master(master);
 	if (status < 0)
 		goto err4;
 
 	return status;
-
 err4:
-	kfree(mcspi->dma_channels);
+	spi_master_put(master);
 err3:
-	clk_put(mcspi->fck);
+	kfree(mcspi->dma_channels);
 err2:
-	clk_put(mcspi->ick);
-err1a:
-	iounmap(mcspi->base);
-err1aa:
 	release_mem_region(r->start, (r->end - r->start) + 1);
+	iounmap(mcspi->base);
 err1:
-	spi_master_put(master);
 	return status;
 }
 
@@ -1551,9 +1453,7 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
 	mcspi = spi_master_get_devdata(master);
 	dma_channels = mcspi->dma_channels;
 
-	clk_put(mcspi->fck);
-	clk_put(mcspi->ick);
-
+	omap2_mcspi_disable_clocks(mcspi);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, (r->end - r->start) + 1);
 
@@ -1568,15 +1468,20 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:omap2_mcspi");
 
+static const struct dev_pm_ops omap_mcspi_dev_pm_ops = {
+	.runtime_suspend = omap_mcspi_runtime_suspend,
+	.runtime_resume	= omap_mcspi_runtime_resume,
+};
+
 static struct platform_driver omap2_mcspi_driver = {
 	.driver = {
-		.name =		"omap2_mcspi",
-		.owner =	THIS_MODULE,
+		.name	= "omap2_mcspi",
+		.owner	= THIS_MODULE,
+		.pm	= &omap_mcspi_dev_pm_ops,
 	},
 	.remove =	__exit_p(omap2_mcspi_remove),
 };
 
-
 static int __init omap2_mcspi_init(void)
 {
 	omap2_mcspi_wq = create_singlethread_workqueue(
-- 
1.6.3.3

