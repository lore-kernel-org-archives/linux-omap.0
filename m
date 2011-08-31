From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 04/14] omap: mcbsp: Implement generic register access
Date: Wed, 31 Aug 2011 18:22:51 +0300
Message-ID: <1314804181-17260-5-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:53045 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756446Ab1HaPXZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:23:25 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Register access can be made more generic by calculating register address
offsets runtime from common register definitions and by using reg_size and
reg_step variables that are passed via platform data. Common register
definitions are possible since McBSP registers are ordered similarly between
OMAP versions.

Remove also references to OMAP2+ specific config_type variable from generic
McBSP code since other variables and feature flags are better to carry needed
information from platform code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/mcbsp.c             |    2 +
 arch/arm/mach-omap2/mcbsp.c             |    6 +-
 arch/arm/plat-omap/include/plat/mcbsp.h |  145 ++++++++++++-------------------
 arch/arm/plat-omap/mcbsp.c              |   45 ++++------
 4 files changed, 82 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 3c985ac..36ab5d8 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -391,6 +391,8 @@ static void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
 			continue;
 		platform_device_add_resources(new_mcbsp, &res[i * res_count],
 					res_count);
+		config[i].reg_size = 2;
+		config[i].reg_step = 2;
 		new_mcbsp->dev.platform_data = &config[i];
 		ret = platform_device_add(new_mcbsp);
 		if (ret) {
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 4a6ef6a..a157e3e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -126,7 +126,11 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
-	pdata->mcbsp_config_type = oh->class->rev;
+	pdata->reg_step = 4;
+	if (oh->class->rev < MCBSP_CONFIG_TYPE2)
+		pdata->reg_size = 2;
+	else
+		pdata->reg_size = 4;
 
 	if (oh->class->rev == MCBSP_CONFIG_TYPE3) {
 		if (id == 2)
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 7adfd92..14bc1cb 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -51,93 +51,60 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP1610_MCBSP2_BASE	0xfffb1000
 #define OMAP1610_MCBSP3_BASE	0xe1017000
 
-#ifdef CONFIG_ARCH_OMAP1
-
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x02
-#define OMAP_MCBSP_REG_DXR2	0x04
-#define OMAP_MCBSP_REG_DXR1	0x06
-#define OMAP_MCBSP_REG_DRR	0x02
-#define OMAP_MCBSP_REG_DXR	0x06
-#define OMAP_MCBSP_REG_SPCR2	0x08
-#define OMAP_MCBSP_REG_SPCR1	0x0a
-#define OMAP_MCBSP_REG_RCR2	0x0c
-#define OMAP_MCBSP_REG_RCR1	0x0e
-#define OMAP_MCBSP_REG_XCR2	0x10
-#define OMAP_MCBSP_REG_XCR1	0x12
-#define OMAP_MCBSP_REG_SRGR2	0x14
-#define OMAP_MCBSP_REG_SRGR1	0x16
-#define OMAP_MCBSP_REG_MCR2	0x18
-#define OMAP_MCBSP_REG_MCR1	0x1a
-#define OMAP_MCBSP_REG_RCERA	0x1c
-#define OMAP_MCBSP_REG_RCERB	0x1e
-#define OMAP_MCBSP_REG_XCERA	0x20
-#define OMAP_MCBSP_REG_XCERB	0x22
-#define OMAP_MCBSP_REG_PCR0	0x24
-#define OMAP_MCBSP_REG_RCERC	0x26
-#define OMAP_MCBSP_REG_RCERD	0x28
-#define OMAP_MCBSP_REG_XCERC	0x2A
-#define OMAP_MCBSP_REG_XCERD	0x2C
-#define OMAP_MCBSP_REG_RCERE	0x2E
-#define OMAP_MCBSP_REG_RCERF	0x30
-#define OMAP_MCBSP_REG_XCERE	0x32
-#define OMAP_MCBSP_REG_XCERF	0x34
-#define OMAP_MCBSP_REG_RCERG	0x36
-#define OMAP_MCBSP_REG_RCERH	0x38
-#define OMAP_MCBSP_REG_XCERG	0x3A
-#define OMAP_MCBSP_REG_XCERH	0x3C
-
-/* Dummy defines, these are not available on omap1 */
-#define OMAP_MCBSP_REG_XCCR	0x00
-#define OMAP_MCBSP_REG_RCCR	0x00
-
-#else
-
-#define OMAP_MCBSP_REG_DRR2	0x00
-#define OMAP_MCBSP_REG_DRR1	0x04
-#define OMAP_MCBSP_REG_DXR2	0x08
-#define OMAP_MCBSP_REG_DXR1	0x0C
-#define OMAP_MCBSP_REG_DRR	0x00
-#define OMAP_MCBSP_REG_DXR	0x08
-#define OMAP_MCBSP_REG_SPCR2	0x10
-#define OMAP_MCBSP_REG_SPCR1	0x14
-#define OMAP_MCBSP_REG_RCR2	0x18
-#define OMAP_MCBSP_REG_RCR1	0x1C
-#define OMAP_MCBSP_REG_XCR2	0x20
-#define OMAP_MCBSP_REG_XCR1	0x24
-#define OMAP_MCBSP_REG_SRGR2	0x28
-#define OMAP_MCBSP_REG_SRGR1	0x2C
-#define OMAP_MCBSP_REG_MCR2	0x30
-#define OMAP_MCBSP_REG_MCR1	0x34
-#define OMAP_MCBSP_REG_RCERA	0x38
-#define OMAP_MCBSP_REG_RCERB	0x3C
-#define OMAP_MCBSP_REG_XCERA	0x40
-#define OMAP_MCBSP_REG_XCERB	0x44
-#define OMAP_MCBSP_REG_PCR0	0x48
-#define OMAP_MCBSP_REG_RCERC	0x4C
-#define OMAP_MCBSP_REG_RCERD	0x50
-#define OMAP_MCBSP_REG_XCERC	0x54
-#define OMAP_MCBSP_REG_XCERD	0x58
-#define OMAP_MCBSP_REG_RCERE	0x5C
-#define OMAP_MCBSP_REG_RCERF	0x60
-#define OMAP_MCBSP_REG_XCERE	0x64
-#define OMAP_MCBSP_REG_XCERF	0x68
-#define OMAP_MCBSP_REG_RCERG	0x6C
-#define OMAP_MCBSP_REG_RCERH	0x70
-#define OMAP_MCBSP_REG_XCERG	0x74
-#define OMAP_MCBSP_REG_XCERH	0x78
-#define OMAP_MCBSP_REG_SYSCON	0x8C
-#define OMAP_MCBSP_REG_THRSH2	0x90
-#define OMAP_MCBSP_REG_THRSH1	0x94
-#define OMAP_MCBSP_REG_IRQST	0xA0
-#define OMAP_MCBSP_REG_IRQEN	0xA4
-#define OMAP_MCBSP_REG_WAKEUPEN	0xA8
-#define OMAP_MCBSP_REG_XCCR	0xAC
-#define OMAP_MCBSP_REG_RCCR	0xB0
-#define OMAP_MCBSP_REG_XBUFFSTAT	0xB4
-#define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
-#define OMAP_MCBSP_REG_SSELCR	0xBC
+/* McBSP register numbers. Register address offset = num * reg_step */
+enum {
+	/* Common registers */
+	OMAP_MCBSP_REG_SPCR2 = 4,
+	OMAP_MCBSP_REG_SPCR1,
+	OMAP_MCBSP_REG_RCR2,
+	OMAP_MCBSP_REG_RCR1,
+	OMAP_MCBSP_REG_XCR2,
+	OMAP_MCBSP_REG_XCR1,
+	OMAP_MCBSP_REG_SRGR2,
+	OMAP_MCBSP_REG_SRGR1,
+	OMAP_MCBSP_REG_MCR2,
+	OMAP_MCBSP_REG_MCR1,
+	OMAP_MCBSP_REG_RCERA,
+	OMAP_MCBSP_REG_RCERB,
+	OMAP_MCBSP_REG_XCERA,
+	OMAP_MCBSP_REG_XCERB,
+	OMAP_MCBSP_REG_PCR0,
+	OMAP_MCBSP_REG_RCERC,
+	OMAP_MCBSP_REG_RCERD,
+	OMAP_MCBSP_REG_XCERC,
+	OMAP_MCBSP_REG_XCERD,
+	OMAP_MCBSP_REG_RCERE,
+	OMAP_MCBSP_REG_RCERF,
+	OMAP_MCBSP_REG_XCERE,
+	OMAP_MCBSP_REG_XCERF,
+	OMAP_MCBSP_REG_RCERG,
+	OMAP_MCBSP_REG_RCERH,
+	OMAP_MCBSP_REG_XCERG,
+	OMAP_MCBSP_REG_XCERH,
+
+	/* OMAP1-OMAP2420 registers */
+	OMAP_MCBSP_REG_DRR2 = 0,
+	OMAP_MCBSP_REG_DRR1,
+	OMAP_MCBSP_REG_DXR2,
+	OMAP_MCBSP_REG_DXR1,
+
+	/* OMAP2430 and onwards */
+	OMAP_MCBSP_REG_DRR = 0,
+	OMAP_MCBSP_REG_DXR = 2,
+	OMAP_MCBSP_REG_SYSCON =	35,
+	OMAP_MCBSP_REG_THRSH2,
+	OMAP_MCBSP_REG_THRSH1,
+	OMAP_MCBSP_REG_IRQST = 40,
+	OMAP_MCBSP_REG_IRQEN,
+	OMAP_MCBSP_REG_WAKEUPEN,
+	OMAP_MCBSP_REG_XCCR,
+	OMAP_MCBSP_REG_RCCR,
+	OMAP_MCBSP_REG_XBUFFSTAT,
+	OMAP_MCBSP_REG_RBUFFSTAT,
+	OMAP_MCBSP_REG_SSELCR,
+};
 
+/* OMAP3 sidetone control registers */
 #define OMAP_ST_REG_REV		0x00
 #define OMAP_ST_REG_SYSCONFIG	0x10
 #define OMAP_ST_REG_IRQSTATUS	0x18
@@ -146,8 +113,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_ST_REG_SFIRCR	0x28
 #define OMAP_ST_REG_SSELCR	0x2C
 
-#endif
-
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
 #define RRDY			0x0002
@@ -350,7 +315,8 @@ struct omap_mcbsp_ops {
 struct omap_mcbsp_platform_data {
 	struct omap_mcbsp_ops *ops;
 	u16 buffer_size;
-	unsigned int mcbsp_config_type;
+	u8 reg_size;
+	u8 reg_step;
 };
 
 struct omap_mcbsp_st_data {
@@ -389,7 +355,6 @@ struct omap_mcbsp {
 	u16 max_rx_thres;
 #endif
 	void *reg_cache;
-	unsigned int mcbsp_config_type;
 };
 
 /**
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4b233e8..623f2c1 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -35,29 +35,27 @@ int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
-	if (cpu_class_is_omap1()) {
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
-		__raw_writew((u16)val, mcbsp->io_base + reg);
-	} else if (cpu_is_omap2420()) {
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] = (u16)val;
-		__raw_writew((u16)val, mcbsp->io_base + reg);
+	void __iomem *addr = mcbsp->io_base + reg * mcbsp->pdata->reg_step;
+
+	if (mcbsp->pdata->reg_size == 2) {
+		((u16 *)mcbsp->reg_cache)[reg] = (u16)val;
+		__raw_writew((u16)val, addr);
 	} else {
-		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] = val;
-		__raw_writel(val, mcbsp->io_base + reg);
+		((u32 *)mcbsp->reg_cache)[reg] = val;
+		__raw_writel(val, addr);
 	}
 }
 
 static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
-	if (cpu_class_is_omap1()) {
-		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
-	} else if (cpu_is_omap2420()) {
-		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+	void __iomem *addr = mcbsp->io_base + reg * mcbsp->pdata->reg_step;
+
+	if (mcbsp->pdata->reg_size == 2) {
+		return !from_cache ? __raw_readw(addr) :
+				     ((u16 *)mcbsp->reg_cache)[reg];
 	} else {
-		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
-				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+		return !from_cache ? __raw_readl(addr) :
+				     ((u32 *)mcbsp->reg_cache)[reg];
 	}
 }
 
@@ -238,21 +236,19 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	data_reg = mcbsp->phys_dma_base;
-
-	if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE2) {
+	if (mcbsp->pdata->reg_size == 2) {
 		if (stream)
-			data_reg += OMAP_MCBSP_REG_DRR1;
+			data_reg = OMAP_MCBSP_REG_DRR1;
 		else
-			data_reg += OMAP_MCBSP_REG_DXR1;
+			data_reg = OMAP_MCBSP_REG_DXR1;
 	} else {
 		if (stream)
-			data_reg += OMAP_MCBSP_REG_DRR;
+			data_reg = OMAP_MCBSP_REG_DRR;
 		else
-			data_reg += OMAP_MCBSP_REG_DXR;
+			data_reg = OMAP_MCBSP_REG_DXR;
 	}
 
-	return data_reg;
+	return mcbsp->phys_dma_base + data_reg * mcbsp->pdata->reg_step;
 }
 EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 
@@ -1337,7 +1333,6 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->pdata = pdata;
 	mcbsp->dev = &pdev->dev;
 	mcbsp_ptr[id] = mcbsp;
-	mcbsp->mcbsp_config_type = pdata->mcbsp_config_type;
 	platform_set_drvdata(pdev, mcbsp);
 	pm_runtime_enable(mcbsp->dev);
 
-- 
1.7.5.4

