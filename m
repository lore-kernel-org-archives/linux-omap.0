From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 23/26] ARM: omap: dma: get rid of 'p' allocation and
 clean up
Date: Thu, 02 Jan 2014 15:12:42 +0000
Message-ID: <E1Vyjww-0005FT-5U@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54154 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751966AbaABPNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:13:08 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

The omap_system_dma_plat_info structure is only seven words, it's not
worth the expense of kmalloc()'ing backing store for this only to
release it later.  Note that platform_device_add_data() copies the
data anyway.  Clean up the initialisation of this structure - we don't
even need code to initialise most of this structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c |   36 ++++++++++++++----------------------
 arch/arm/mach-omap2/dma.c |   34 +++++++++++++---------------------
 2 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 3e93d0a323a4..8b1b914d0a6f 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -263,9 +263,17 @@ static const struct platform_device_info omap_dma_dev_info = {
 	.dma_mask = DMA_BIT_MASK(32),
 };
 
+static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+	.show_dma_caps	= omap1_show_dma_caps,
+	.clear_lch_regs	= omap1_clear_lch_regs,
+	.clear_dma	= omap1_clear_dma,
+	.dma_write	= dma_write,
+	.dma_read	= dma_read,
+};
+
 static int __init omap1_system_dma_init(void)
 {
-	struct omap_system_dma_plat_info	*p;
+	struct omap_system_dma_plat_info	p;
 	struct omap_dma_dev_attr		*d;
 	struct platform_device			*pdev, *dma_pdev;
 	int ret;
@@ -291,20 +299,12 @@ static int __init omap1_system_dma_init(void)
 		goto exit_iounmap;
 	}
 
-	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
-	if (!p) {
-		dev_err(&pdev->dev, "%s: Unable to allocate 'p' for %s\n",
-			__func__, pdev->name);
-		ret = -ENOMEM;
-		goto exit_iounmap;
-	}
-
 	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
 	if (!d) {
 		dev_err(&pdev->dev, "%s: Unable to allocate 'd' for %s\n",
 			__func__, pdev->name);
 		ret = -ENOMEM;
-		goto exit_release_p;
+		goto exit_iounmap;
 	}
 
 	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
@@ -334,17 +334,11 @@ static int __init omap1_system_dma_init(void)
 			d->chan_count = 9;
 	}
 
-	p->dma_attr = d;
-
-	p->show_dma_caps	= omap1_show_dma_caps;
-	p->clear_lch_regs	= omap1_clear_lch_regs;
-	p->clear_dma		= omap1_clear_dma;
-	p->dma_write		= dma_write;
-	p->dma_read		= dma_read;
-
-	p->errata = configure_dma_errata();
+	p = dma_plat_info;
+	p.dma_attr = d;
+	p.errata = configure_dma_errata();
 
-	ret = platform_device_add_data(pdev, p, sizeof(*p));
+	ret = platform_device_add_data(pdev, &p, sizeof(p));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
@@ -372,8 +366,6 @@ static int __init omap1_system_dma_init(void)
 	kfree(d->chan);
 exit_release_d:
 	kfree(d);
-exit_release_p:
-	kfree(p);
 exit_iounmap:
 	iounmap(dma_base);
 exit_device_put:
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 9f210d637354..6331fc4b4054 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -35,8 +35,6 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 
-static struct omap_dma_dev_attr *d;
-
 static enum omap_reg_offsets dma_common_ch_end;
 
 static const struct omap_dma_reg reg_map[] = {
@@ -206,33 +204,27 @@ static unsigned configure_dma_errata(void)
 	return errata;
 }
 
+static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+	.show_dma_caps	= omap2_show_dma_caps,
+	.clear_dma	= omap2_clear_dma,
+	.dma_write	= dma_write,
+	.dma_read	= dma_read,
+};
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device			*pdev;
-	struct omap_system_dma_plat_info	*p;
+	struct omap_system_dma_plat_info	p;
+	struct omap_dma_dev_attr		*d;
 	struct resource				*mem;
 	char					*name = "omap_dma_system";
 
-	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
-	if (!p) {
-		pr_err("%s: Unable to allocate pdata for %s:%s\n",
-			__func__, name, oh->name);
-		return -ENOMEM;
-	}
-
-	p->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
-	p->show_dma_caps	= omap2_show_dma_caps;
-	p->clear_dma		= omap2_clear_dma;
-	p->dma_write		= dma_write;
-	p->dma_read		= dma_read;
-
-	p->clear_lch_regs	= NULL;
-
-	p->errata		= configure_dma_errata();
+	p = dma_plat_info;
+	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
+	p.errata = configure_dma_errata();
 
-	pdev = omap_device_build(name, 0, oh, p, sizeof(*p));
-	kfree(p);
+	pdev = omap_device_build(name, 0, oh, &p, sizeof(p));
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
 			__func__, name, oh->name);
-- 
1.7.4.4

