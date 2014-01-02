From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 19/26] ARM: omap: remove almost-const variables
Date: Thu, 02 Jan 2014 15:12:01 +0000
Message-ID: <E1VyjwH-0005FD-Na@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54137 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751675AbaABPM2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:12:28 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

dma_stride and dma_common_ch_start are only ever initialised to one
known value at initialisation, and are private to each of these files.
There's no point these being variables at all.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c |   14 ++++----------
 arch/arm/mach-omap2/dma.c |   14 +++++---------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index d292055d3117..11f0b0ee67a3 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -36,8 +36,6 @@
 
 static u32 errata;
 static u32 enable_1510_mode;
-static u8 dma_stride;
-static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
 
 static u16 reg_map[] = {
 	[GCR]		= 0x400,
@@ -184,7 +182,7 @@ static inline void dma_write(u32 val, int reg, int lch)
 	u8  stride;
 	u32 offset;
 
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	stride = (reg >= CPC) ? OMAP1_DMA_STRIDE : 0;
 	offset = reg_map[reg] + (stride * lch);
 
 	__raw_writew(val, dma_base + offset);
@@ -200,7 +198,7 @@ static inline u32 dma_read(int reg, int lch)
 	u8 stride;
 	u32 offset, val;
 
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	stride = (reg >= CPC) ? OMAP1_DMA_STRIDE : 0;
 	offset = reg_map[reg] + (stride * lch);
 
 	val = __raw_readw(dma_base + offset);
@@ -216,9 +214,9 @@ static inline u32 dma_read(int reg, int lch)
 
 static void omap1_clear_lch_regs(int lch)
 {
-	int i = dma_common_ch_start;
+	int i;
 
-	for (; i <= dma_common_ch_end; i += 1)
+	for (i = CPC; i <= COLOR; i += 1)
 		dma_write(0, i, lch);
 }
 
@@ -380,10 +378,6 @@ static int __init omap1_system_dma_init(void)
 		goto exit_release_chan;
 	}
 
-	dma_stride		= OMAP1_DMA_STRIDE;
-	dma_common_ch_start	= CPC;
-	dma_common_ch_end	= COLOR;
-
 	dma_pdev = platform_device_register_full(&omap_dma_dev_info);
 	if (IS_ERR(dma_pdev)) {
 		ret = PTR_ERR(dma_pdev);
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 81c2d3383bc5..e4ac7ac9a228 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -38,11 +38,10 @@
 #define OMAP2_DMA_STRIDE	0x60
 
 static u32 errata;
-static u8 dma_stride;
 
 static struct omap_dma_dev_attr *d;
 
-static enum omap_reg_offsets dma_common_ch_start, dma_common_ch_end;
+static enum omap_reg_offsets dma_common_ch_end;
 
 static u16 reg_map[] = {
 	[REVISION]		= 0x00,
@@ -96,7 +95,7 @@ static inline void dma_write(u32 val, int reg, int lch)
 	u8  stride;
 	u32 offset;
 
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	stride = (reg >= CSDP) ? OMAP2_DMA_STRIDE : 0;
 	offset = reg_map[reg] + (stride * lch);
 	__raw_writel(val, dma_base + offset);
 }
@@ -106,7 +105,7 @@ static inline u32 dma_read(int reg, int lch)
 	u8 stride;
 	u32 offset, val;
 
-	stride = (reg >= dma_common_ch_start) ? dma_stride : 0;
+	stride = (reg >= CSDP) ? OMAP2_DMA_STRIDE : 0;
 	offset = reg_map[reg] + (stride * lch);
 	val = __raw_readl(dma_base + offset);
 	return val;
@@ -114,9 +113,9 @@ static inline u32 dma_read(int reg, int lch)
 
 static void omap2_clear_dma(int lch)
 {
-	int i = dma_common_ch_start;
+	int i;
 
-	for (; i <= dma_common_ch_end; i += 1)
+	for (i = CSDP; i <= dma_common_ch_end; i += 1)
 		dma_write(0, i, lch);
 }
 
@@ -219,9 +218,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	struct resource				*mem;
 	char					*name = "omap_dma_system";
 
-	dma_stride		= OMAP2_DMA_STRIDE;
-	dma_common_ch_start	= CSDP;
-
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
 	if (!p) {
 		pr_err("%s: Unable to allocate pdata for %s:%s\n",
-- 
1.7.4.4

