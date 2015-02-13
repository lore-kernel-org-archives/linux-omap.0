From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 29/33] ARM: OMAP2+: control: convert to use syscon for register accesses
Date: Fri, 13 Feb 2015 18:12:48 +0200
Message-ID: <1423843973-6050-27-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbbBMQOg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:36 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Control driver now uses syscon for accessing its register space. Also,
the clock driver under control module are using the same syscon
address space now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.h   |    1 +
 arch/arm/mach-omap2/control.c |   89 ++++++++++++++++++++++++++++++++---------
 include/linux/clk/ti.h        |    2 +-
 3 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 6a4dfe7..ddaabf1 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -241,6 +241,7 @@ enum {
 	CLK_MEMMAP_INDEX_CM1,
 	CLK_MEMMAP_INDEX_CM2,
 	CLK_MEMMAP_INDEX_SCRM,
+	CLK_MEMMAP_INDEX_CTRL,
 };
 
 extern struct ti_clk_features ti_clk_features;
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da41288..a6d987b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -34,6 +36,7 @@
 
 static void __iomem *omap2_ctrl_base;
 static void __iomem *omap4_ctrl_pad_base;
+static struct regmap *omap2_ctrl_syscon;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -135,7 +138,6 @@ struct omap3_control_regs {
 static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
-#define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 #define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
 void __init omap2_set_globals_control(void __iomem *ctrl,
@@ -147,32 +149,71 @@ void __init omap2_set_globals_control(void __iomem *ctrl,
 
 u8 omap_ctrl_readb(u16 offset)
 {
-	return readb_relaxed(OMAP_CTRL_REGADDR(offset));
+	u32 val;
+	u8 byte_offset = offset & 0x3;
+
+	val = omap_ctrl_readl(offset);
+
+	return (val >> (byte_offset * 8)) & 0xff;
 }
 
 u16 omap_ctrl_readw(u16 offset)
 {
-	return readw_relaxed(OMAP_CTRL_REGADDR(offset));
+	u32 val;
+	u16 byte_offset = offset & 0x2;
+
+	val = omap_ctrl_readl(offset);
+
+	return (val >> (byte_offset * 8)) & 0xffff;
 }
 
 u32 omap_ctrl_readl(u16 offset)
 {
-	return readl_relaxed(OMAP_CTRL_REGADDR(offset));
+	u32 val;
+
+	offset &= 0xfffc;
+	if (!omap2_ctrl_syscon)
+		val = readl_relaxed(omap2_ctrl_base + offset);
+	else
+		regmap_read(omap2_ctrl_syscon, offset, &val);
+
+	return val;
 }
 
 void omap_ctrl_writeb(u8 val, u16 offset)
 {
-	writeb_relaxed(val, OMAP_CTRL_REGADDR(offset));
+	u32 tmp;
+	u8 byte_offset = offset & 0x3;
+
+	tmp = omap_ctrl_readl(offset);
+
+	tmp &= 0xffffffff ^ (0xff << (byte_offset * 8));
+	tmp |= val << (byte_offset * 8);
+
+	omap_ctrl_writel(tmp, offset);
 }
 
 void omap_ctrl_writew(u16 val, u16 offset)
 {
-	writew_relaxed(val, OMAP_CTRL_REGADDR(offset));
+	u32 tmp;
+	u8 byte_offset = offset & 0x2;
+
+	tmp = omap_ctrl_readl(offset);
+
+	tmp &= 0xffffffff ^ (0xffff << (byte_offset * 8));
+	tmp |= val << (byte_offset * 8);
+
+	omap_ctrl_writel(tmp, offset);
 }
 
 void omap_ctrl_writel(u32 val, u16 offset)
 {
-	writel_relaxed(val, OMAP_CTRL_REGADDR(offset));
+	offset &= 0xfffc;
+	if (!omap2_ctrl_syscon) {
+		pr_err("%s: early write: %04x\n", __func__, offset);
+		return;
+	}
+	regmap_write(omap2_ctrl_syscon, offset, val);
 }
 
 /*
@@ -611,11 +652,10 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
-	void __iomem *mem;
 };
 
 static const struct control_init_data ctrl_data = {
-	.index = CLK_MEMMAP_INDEX_SCRM,
+	.index = CLK_MEMMAP_INDEX_CTRL,
 };
 
 static struct of_device_id omap_scrm_dt_match_table[] = {
@@ -637,18 +677,14 @@ int __init omap2_control_base_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
-	struct control_init_data *data;
-	void __iomem *mem;
+	const struct control_init_data *data;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
-		data = (struct control_init_data *)match->data;
+		data = match->data;
 
-		mem = of_iomap(np, 0);
-		if (!mem)
+		omap2_ctrl_base = of_iomap(np, 0);
+		if (!omap2_ctrl_base)
 			return -ENOMEM;
-
-		omap2_ctrl_base = mem;
-		data->mem = mem;
 	}
 
 	return 0;
@@ -666,13 +702,26 @@ int __init omap_control_init(void)
 	const struct of_device_id *match;
 	const struct control_init_data *data;
 	int ret;
+	struct regmap *syscon;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
-		if (ret)
-			return ret;
+		syscon = syscon_node_to_regmap(np);
+		if (IS_ERR(syscon))
+			return PTR_ERR(syscon);
+
+		if (data->index == CLK_MEMMAP_INDEX_CTRL) {
+			omap2_ctrl_syscon = syscon;
+
+			ret = omap2_clk_provider_init(np, data->index, syscon,
+						      NULL);
+			if (ret)
+				return ret;
+
+			iounmap(omap2_ctrl_base);
+			omap2_ctrl_base = NULL;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 55ef529..00d42a9 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -215,7 +215,7 @@ struct ti_dt_clk {
 	}
 
 /* Maximum number of clock memmaps */
-#define CLK_MAX_MEMMAPS			4
+#define CLK_MAX_MEMMAPS			5
 
 typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
 
-- 
1.7.9.5

