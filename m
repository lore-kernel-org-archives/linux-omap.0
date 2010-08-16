From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/4] omap4: control: Add accessor api's for pad control module
Date: Mon, 16 Aug 2010 19:35:41 +0530
Message-ID: <1281967541-9677-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab0HPOFs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 10:05:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4 control pad are not addressable from control
core base. So the common omap_ctrl_read/write APIs breaks
Hence export separate APIs to manage the omap4 pad control
registers.

This APIs will work only for OMAP4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/control.c             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 99c0eb6..4ace2d1 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -138,6 +138,7 @@ static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
+#define OMAP_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 {
@@ -189,6 +190,23 @@ void omap_ctrl_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
 
+/*
+ * On OMAP4 control pad are not addressable from control
+ * core base. So the common omap_ctrl_read/write APIs breaks
+ * Hence export separate APIs to manage the omap4 pad control
+ * registers. This APIs will work only for OMAP4
+ */
+
+u32 omap4_ctrl_pad_readl(u16 offset)
+{
+	return __raw_readl(OMAP_CTRL_PAD_REGADDR(offset));
+}
+
+void omap4_ctrl_pad_writel(u32 val, u16 offset)
+{
+	__raw_writel(val, OMAP_CTRL_PAD_REGADDR(offset));
+}
+
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 /*
  * Clears the scratchpad contents in case of cold boot-
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 131bf40..2916b7e 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -354,9 +354,11 @@ extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
 extern u32 omap_ctrl_readl(u16 offset);
+extern u32 omap4_ctrl_pad_readl(u16 offset);
 extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
+extern void omap4_ctrl_pad_writel(u32 val, u16 offset);
 
 extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
@@ -371,9 +373,11 @@ extern void omap3_control_restore_context(void);
 #define omap_ctrl_readb(x)		0
 #define omap_ctrl_readw(x)		0
 #define omap_ctrl_readl(x)		0
+#define omap4_ctrl_pad_readl(x)		0
 #define omap_ctrl_writeb(x, y)		WARN_ON(1)
 #define omap_ctrl_writew(x, y)		WARN_ON(1)
 #define omap_ctrl_writel(x, y)		WARN_ON(1)
+#define omap4_ctrl_pad_writel(x, y)	WARN_ON(1)
 #endif
 #endif	/* __ASSEMBLY__ */
 
-- 
1.6.0.4

