From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 22/26] ARM: omap: move dma channel allocation into plat-omap
 code
Date: Mon, 10 Feb 2014 15:57:45 +0000
Message-ID: <E1WCtEv-0006XW-QU@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60093 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752557AbaBJP5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:57:48 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This really needs to be there, because otherwise the plat-omap code can
kfree() this data structure, and then re-use the pointer later.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c | 17 ++---------------
 arch/arm/mach-omap2/dma.c |  7 -------
 arch/arm/plat-omap/dma.c  | 11 ++++++++---
 include/linux/omap-dma.h  |  1 -
 4 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index c979e3f88bbb..d170f7d0a6ac 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -325,17 +325,6 @@ static int __init omap1_system_dma_init(void)
 	d->dev_caps		|= CLEAR_CSR_ON_READ;
 	d->dev_caps		|= IS_WORD_16;
 
-
-	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
-					(d->lch_count), GFP_KERNEL);
-	if (!d->chan) {
-		dev_err(&pdev->dev,
-			"%s: Memory allocation failed for d->chan!\n",
-			__func__);
-		ret = -ENOMEM;
-		goto exit_release_d;
-	}
-
 	if (cpu_is_omap15xx())
 		d->chan_count = 9;
 	else if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
@@ -359,14 +348,14 @@ static int __init omap1_system_dma_init(void)
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
 
 	ret = platform_device_add(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
 
 	dma_pdev = platform_device_register_full(&omap_dma_dev_info);
@@ -379,8 +368,6 @@ static int __init omap1_system_dma_init(void)
 
 exit_release_pdev:
 	platform_device_del(pdev);
-exit_release_chan:
-	kfree(d->chan);
 exit_release_d:
 	kfree(d);
 exit_release_p:
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 244ff5012aed..9f210d637354 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -251,13 +251,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	}
 
 	d = oh->dev_attr;
-	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
-					(d->lch_count), GFP_KERNEL);
-
-	if (!d->chan) {
-		dev_err(&pdev->dev, "%s: kzalloc fail\n", __func__);
-		return -ENOMEM;
-	}
 
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		d->dev_caps |= HS_CHANNELS_RESERVED;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d4d9a5e62152..5f5b975887fc 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2030,9 +2030,16 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 
 	dma_lch_count		= d->lch_count;
 	dma_chan_count		= dma_lch_count;
-	dma_chan		= d->chan;
 	enable_1510_mode	= d->dev_caps & ENABLE_1510_MODE;
 
+	dma_chan = devm_kcalloc(&pdev->dev, dma_lch_count,
+				sizeof(struct omap_dma_lch), GFP_KERNEL);
+	if (!dma_chan) {
+		dev_err(&pdev->dev, "%s: kzalloc fail\n", __func__);
+		return -ENOMEM;
+	}
+
+
 	if (dma_omap2plus()) {
 		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
 						dma_lch_count, GFP_KERNEL);
@@ -2117,7 +2124,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	}
 
 exit_dma_lch_fail:
-	kfree(dma_chan);
 	return ret;
 }
 
@@ -2137,7 +2143,6 @@ static int omap_system_dma_remove(struct platform_device *pdev)
 			free_irq(dma_irq, (void *)(irq_rel + 1));
 		}
 	}
-	kfree(dma_chan);
 	return 0;
 }
 
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 41328725721a..7813636a193d 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -268,7 +268,6 @@ struct omap_dma_dev_attr {
 	u32 dev_caps;
 	u16 lch_count;
 	u16 chan_count;
-	struct omap_dma_lch *chan;
 };
 
 enum {
-- 
1.8.3.1

