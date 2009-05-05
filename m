From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] onenand_init: Allow disabling sync read and write based
	on flags, v3
Date: Mon, 04 May 2009 17:26:42 -0700
Message-ID: <20090505002642.2894.59344.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65056 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbZEEA0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:26:44 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Allow disabling sync read and write based on flags

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n800.c             |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 arch/arm/mach-omap2/gpmc-onenand.c           |   43 ++++++++++++++++++--------
 arch/arm/plat-omap/include/mach/onenand.h    |    4 ++
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index e882e4b..74e7ea4 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -722,6 +722,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.gpio_irq	= 26,
 	.parts		= onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READ,
 };
 
 static void __init board_onenand_init(void)
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 7b1ee3d..55e8568 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -515,6 +515,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 	.gpio_irq	= 65,
 	.parts		= onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READWRITE,
 };
 
 static void __init board_onenand_init(void)
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fc79183..d243228 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -86,15 +86,18 @@ static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
 }
 
 static void set_onenand_cfg(void __iomem *onenand_base, int latency,
-			    int sync_write, int hf)
+				int sync_read, int sync_write, int hf)
 {
 	u32 reg;
 
 	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
 	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
 	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
 		ONENAND_SYS_CFG1_BL_16;
+	if (sync_read)
+		reg |= ONENAND_SYS_CFG1_SYNC_READ;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_READ;
 	if (sync_write)
 		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
 	else
@@ -106,8 +109,9 @@ static void set_onenand_cfg(void __iomem *onenand_base, int latency,
 	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
 }
 
-static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
-				       int freq)
+static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
+					void __iomem *onenand_base,
+					int freq)
 {
 	struct gpmc_timings t;
 	const int t_cer  = 15;
@@ -118,9 +122,17 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int err, ticks_cez, sync_write = 0, first_time = 0, hf = 0;
+	int err, ticks_cez, sync_read = 0, sync_write = 0, first_time = 0, hf = 0;
+	int cs = cfg->cs;
 	u32 reg;
 
+	if (cfg->flags & ONENAND_SYNC_READ) {
+		sync_read = 1;
+	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
+		sync_read = 1;
+		sync_write = 1;
+	}
+
 	if (!freq) {
 		/* Very first call freq is not known */
 		err = omap2_onenand_set_async_mode(cs, onenand_base);
@@ -160,8 +172,6 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 9;
-		if (cpu_is_omap34xx())
-			sync_write = 1;
 		break;
 	case 66:
 		min_gpmc_clk_period = 15; /* 66 MHz */
@@ -171,8 +181,6 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 6;
 		t_aavdh = 6;
 		t_rdyo  = 11;
-		if (cpu_is_omap34xx())
-			sync_write = 1;
 		break;
 	default:
 		min_gpmc_clk_period = 18; /* 54 MHz */
@@ -182,6 +190,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		t_ach   = 9;
 		t_aavdh = 7;
 		t_rdyo  = 15;
+		sync_write = 0;
 		break;
 	}
 
@@ -198,7 +207,8 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 		latency = 4;
 
 	if (first_time)
-		set_onenand_cfg(onenand_base, latency, sync_write, hf);
+		set_onenand_cfg(onenand_base, latency,
+					sync_read, sync_write, hf);
 
 	if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
@@ -272,7 +282,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  GPMC_CONFIG1_READTYPE_SYNC |
+			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
 			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
@@ -288,7 +298,7 @@ static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 	if (err)
 		return err;
 
-	set_onenand_cfg(onenand_base, latency, sync_write, hf);
+	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf);
 
 	return 0;
 }
@@ -298,7 +308,7 @@ static int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
 	struct device *dev = &gpmc_onenand_device.dev;
 
 	/* Set sync timings in GPMC */
-	if (omap2_onenand_set_sync_mode(gpmc_onenand_data->cs, onenand_base,
+	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
 			freq) < 0) {
 		dev_err(dev, "Unable to set synchronous mode\n");
 		return -EINVAL;
@@ -313,6 +323,13 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
 	gpmc_onenand_device.dev.platform_data = gpmc_onenand_data;
 
+	if (cpu_is_omap24xx() &&
+			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
+		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
+		gpmc_onenand_data->flags &= ~ONENAND_SYNC_READWRITE;
+		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
+	}
+
 	if (platform_device_register(&gpmc_onenand_device) < 0) {
 		printk(KERN_ERR "Unable to register OneNAND device\n");
 		return;
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index 2a391fa..bb66d0b 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -14,6 +14,9 @@
 
 #ifndef __ASM_ARCH_OMAP_ONENAND_H__
 
+#define ONENAND_SYNC_READ	(1 << 0)
+#define ONENAND_SYNC_READWRITE	(1 << 1)
+
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
@@ -21,6 +24,7 @@ struct omap_onenand_platform_data {
 	int			nr_parts;
 	int                     (*onenand_setup)(void __iomem *, int freq);
 	int			dma_channel;
+	u8			flags;
 };
 
 int omap2_onenand_rephase(void);

