From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 23/34] ARM: OMAP2+: control: add syscon support for register accesses
Date: Tue, 31 Mar 2015 22:14:16 +0300
Message-ID: <1427829267-32077-24-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbbCaTPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:15:15 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Control module driver needs to support syscon for register accesses, as
the DT hierarchy for control module driver is going to be changed. All
the control module related features will be moved under control module
node, including clocks, pinctrl, and generic configuration register
access. Temporary iomap is still provided very early in the boot for
access while syscon is not yet ready.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |  104 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 202fc72..4970c5c 100644
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
@@ -33,7 +35,9 @@
 #define PADCONF_SAVE_DONE		0x1
 
 static void __iomem *omap2_ctrl_base;
+static s16 omap2_ctrl_offset;
 static void __iomem *omap4_ctrl_pad_base;
+static struct regmap *omap2_ctrl_syscon;
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 struct omap3_scratchpad {
@@ -135,7 +139,6 @@ struct omap3_control_regs {
 static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
-#define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 #define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
 void __init omap2_set_globals_control(void __iomem *ctrl,
@@ -147,32 +150,72 @@ void __init omap2_set_globals_control(void __iomem *ctrl,
 
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
+		regmap_read(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
+			    &val);
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
+	if (!omap2_ctrl_syscon)
+		writel_relaxed(val, omap2_ctrl_base + offset);
+	else
+		regmap_write(omap2_ctrl_syscon, omap2_ctrl_offset + offset,
+			     val);
 }
 
 /*
@@ -611,7 +654,7 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
-	void __iomem *mem;
+	s16 offset;
 };
 
 static struct control_init_data ctrl_data = {
@@ -639,17 +682,15 @@ int __init omap2_control_base_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	struct control_init_data *data;
-	void __iomem *mem;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = (struct control_init_data *)match->data;
 
-		mem = of_iomap(np, 0);
-		if (!mem)
+		omap2_ctrl_base = of_iomap(np, 0);
+		if (!omap2_ctrl_base)
 			return -ENOMEM;
 
-		omap2_ctrl_base = mem;
-		data->mem = mem;
+		omap2_ctrl_offset = data->offset;
 	}
 
 	return 0;
@@ -663,17 +704,46 @@ int __init omap2_control_base_init(void)
  */
 int __init omap_control_init(void)
 {
-	struct device_node *np;
+	struct device_node *np, *scm_conf;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
+	struct regmap *syscon;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
-		if (ret)
-			return ret;
+		/*
+		 * Check if we have scm_conf node, if yes, use this to
+		 * access clock registers.
+		 */
+		scm_conf = of_get_child_by_name(np, "scm_conf");
+
+		if (scm_conf) {
+			syscon = syscon_node_to_regmap(scm_conf);
+
+			if (IS_ERR(syscon))
+				return PTR_ERR(syscon);
+
+			omap2_ctrl_syscon = syscon;
+
+			if (of_get_child_by_name(scm_conf, "clocks")) {
+				ret = omap2_clk_provider_init(scm_conf,
+							      data->index,
+							      syscon, NULL);
+				if (ret)
+					return ret;
+			}
+
+			iounmap(omap2_ctrl_base);
+			omap2_ctrl_base = NULL;
+		} else {
+			/* No scm_conf found, direct access */
+			ret = omap2_clk_provider_init(np, data->index, NULL,
+						      omap2_ctrl_base);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
1.7.9.5

