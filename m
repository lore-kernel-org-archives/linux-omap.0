From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] omap: Disable omap_read/write functions for omap2+
Date: Tue, 7 Dec 2010 20:17:16 -0800
Message-ID: <20101208041716.GP17435@atomide.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
 <20101204213651.32208.8915.stgit@baageli.muru.com>
 <20101208012933.GI17435@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0LHERX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 23:17:23 -0500
Content-Disposition: inline
In-Reply-To: <20101208012933.GI17435@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101207 17:32]:
> * Tony Lindgren <tony@atomide.com> [101204 13:27]:
> > These should be now long gone and break multi-omap support for omap1
> > as the cpu_class_is_omap1() won't work until the SOC is detected.
> > 
> > So just disable and warn for omap2+ in case somebody still attampts
> > to use these.
> 
> Heh this was totally not working and had several copy paste bugs..
> Instead of including more files, let's just make them dummy inline
> functions.

One more time, this time let's just split it for omap1 and omap2,
at least omap2 still depends on it.. Fixing it is another series.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Dec 2010 16:57:01 -0800
Subject: [PATCH] omap: Split omap_read/write functions for omap1 and omap2+

Otherwise multi-omap1 support for omap1 won't work as the cpu_class_is_omap1()
won't work until the SoC is detected.

Note that eventually these will go away, please use ioremap + read/write instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 0ce3fec..870886a 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -142,3 +142,42 @@ void __init omap1_init_common_hw(void)
 	omap1_mux_init();
 }
 
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+
+u8 omap_readb(u32 pa)
+{
+	return __raw_readb(OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readb);
+
+u16 omap_readw(u32 pa)
+{
+	return __raw_readw(OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readw);
+
+u32 omap_readl(u32 pa)
+{
+	return __raw_readl(OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readl);
+
+void omap_writeb(u8 v, u32 pa)
+{
+	__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writeb);
+
+void omap_writew(u16 v, u32 pa)
+{
+	__raw_writew(v, OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writew);
+
+void omap_writel(u32 v, u32 pa)
+{
+	__raw_writel(v, OMAP1_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3d18349..9804385 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -375,3 +375,43 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 
 	omap_irq_base_init();
 }
+
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+
+u8 omap_readb(u32 pa)
+{
+	return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readb);
+
+u16 omap_readw(u32 pa)
+{
+	return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readw);
+
+u32 omap_readl(u32 pa)
+{
+	return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readl);
+
+void omap_writeb(u8 v, u32 pa)
+{
+	__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writeb);
+
+void omap_writew(u16 v, u32 pa)
+{
+	__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writew);
+
+void omap_writel(u32 v, u32 pa)
+{
+	__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b0078cf..f1295fa 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -136,61 +136,3 @@ void omap_iounmap(volatile void __iomem *addr)
 		__iounmap(addr);
 }
 EXPORT_SYMBOL(omap_iounmap);
-
-/*
- * NOTE: Please use ioremap + __raw_read/write where possible instead of these
- */
-
-u8 omap_readb(u32 pa)
-{
-	if (cpu_class_is_omap1())
-		return __raw_readb(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readb);
-
-u16 omap_readw(u32 pa)
-{
-	if (cpu_class_is_omap1())
-		return __raw_readw(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readw);
-
-u32 omap_readl(u32 pa)
-{
-	if (cpu_class_is_omap1())
-		return __raw_readl(OMAP1_IO_ADDRESS(pa));
-	else
-		return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_readl);
-
-void omap_writeb(u8 v, u32 pa)
-{
-	if (cpu_class_is_omap1())
-		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writeb);
-
-void omap_writew(u16 v, u32 pa)
-{
-	if (cpu_class_is_omap1())
-		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writew);
-
-void omap_writel(u32 v, u32 pa)
-{
-	if (cpu_class_is_omap1())
-		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
-	else
-		__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
-}
-EXPORT_SYMBOL(omap_writel);
