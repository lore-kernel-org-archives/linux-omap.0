From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] omap: Disable omap_read/write functions for omap2+
Date: Sat, 04 Dec 2010 13:36:51 -0800
Message-ID: <20101204213651.32208.8915.stgit@baageli.muru.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38885 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab0LDVgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 16:36:55 -0500
In-Reply-To: <20101204213358.32208.4195.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These should be now long gone and break multi-omap support for omap1
as the cpu_class_is_omap1() won't work until the SOC is detected.

So just disable and warn for omap2+ in case somebody still attampts
to use these.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/io.h |   45 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/io.c              |   36 ++++++++-------------------
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..af20a9e 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -247,6 +247,8 @@
  * NOTE: Please use ioremap + __raw_read/write where possible instead of these
  */
 
+#ifdef CONFIG_ARCH_OMAP1
+
 extern u8 omap_readb(u32 pa);
 extern u16 omap_readw(u32 pa);
 extern u32 omap_readl(u32 pa);
@@ -254,6 +256,49 @@ extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
+#else
+
+static inline void _bad_access(u32 pa)
+{
+	pr_err("Bad register access at pa 0x%08x\n", pa);
+	WARN_ON(1);
+}
+
+static inline u8 omap_readb(u32 pa)
+{
+	_bad_access(pa);
+	return 0;
+}
+
+static inline u16 omap_readw(u32 pa)
+{
+	_bad_access(pa);
+	return 0;
+}
+
+static inline u16 omap_readl(u32 pa)
+{
+	_bad_access(pa);
+	return 0;
+}
+
+static inline void omap_writeb(u8 v, u32 pa)
+{
+	_bad_access(pa);
+}
+
+static inline void omap_writew(u8 v, u32 pa)
+{
+	_bad_access(pa);
+}
+
+static inline void omap_writel(u8 v, u32 pa)
+{
+	_bad_access(pa);
+}
+
+#endif
+
 struct omap_sdrc_params;
 
 extern void omap1_map_common_io(void);
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b0078cf..b89182b 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -138,59 +138,45 @@ void omap_iounmap(volatile void __iomem *addr)
 EXPORT_SYMBOL(omap_iounmap);
 
 /*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these.
+ * These are only working for omap1 and will disappear eventually.
  */
+#ifdef CONFIG_ARCH_OMAP1
 
 u8 omap_readb(u32 pa)
 {
-	if (cpu_class_is_omap1())
-		return __raw_readb(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
+	return __raw_readb(OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readb);
 
 u16 omap_readw(u32 pa)
 {
-	if (cpu_class_is_omap1())
-		return __raw_readw(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
+	return __raw_readw(OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readw);
 
 u32 omap_readl(u32 pa)
 {
-	if (cpu_class_is_omap1())
-		return __raw_readl(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
+	return __raw_readl(OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readl);
 
 void omap_writeb(u8 v, u32 pa)
 {
-	if (cpu_class_is_omap1())
-		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
+	__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writeb);
 
 void omap_writew(u16 v, u32 pa)
 {
-	if (cpu_class_is_omap1())
-		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
+	__raw_writew(v, OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writew);
 
 void omap_writel(u32 v, u32 pa)
 {
-	if (cpu_class_is_omap1())
-		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
+	__raw_writel(v, OMAP1_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writel);
+
+#endif

