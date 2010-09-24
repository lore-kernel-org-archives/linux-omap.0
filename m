From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/12] omap4: control: Add accessor api's for pad control
	module
Date: Fri, 24 Sep 2010 01:08:24 -0600
Message-ID: <20100924070822.14014.90464.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33665 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab0IXHJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 03:09:05 -0400
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4 control pad are not addressable from control
core base. So the common omap_ctrl_read/write APIs breaks
Hence export separate APIs to manage the omap4 pad control
registers.

This APIs will work only for OMAP4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/control.c             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 99c0eb6..8b3c469 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -138,6 +138,7 @@ static struct omap3_control_regs control_context;
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
+#define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
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
+	return __raw_readl(OMAP4_CTRL_PAD_REGADDR(offset));
+}
+
+void omap4_ctrl_pad_writel(u32 val, u16 offset)
+{
+	__raw_writel(val, OMAP4_CTRL_PAD_REGADDR(offset));
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
 


