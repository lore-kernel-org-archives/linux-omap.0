From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] bus: ti-sysc: Defer suspend as needed
Date: Mon, 24 Sep 2018 15:44:42 -0700
Message-ID: <20180924224445.97239-2-tony@atomide.com>
References: <20180924224445.97239-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924224445.97239-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We don't care when we suspend but some our children do. In order to
avoid tagging various modules with SYSC_QUIRK_RESOURCE_PROVIDER, let's
do it automatically by tagging modules that are busy on suspend for
noirq suspend. This way we can just do module detection on define DEBUG.

Note that we still need to keep SYSC_QUIRK_LEGACY_IDLE flag around so
the our legacy single-child devices that set pm_runtime_irq_safe() can
manage the interconnect target module themselves.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 118 +++++++++++++-------------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -87,6 +87,7 @@ struct sysc {
 	u32 revision;
 	bool enabled;
 	bool needs_resume;
+	unsigned int noirq_suspend:1;
 	bool child_needs_resume;
 	struct delayed_work idle_work;
 };
@@ -712,19 +713,25 @@ static int sysc_suspend(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
-				 SYSC_QUIRK_LEGACY_IDLE))
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (!ddata->enabled)
+	if (!ddata->enabled || ddata->noirq_suspend)
 		return 0;
 
 	dev_dbg(ddata->dev, "%s %s\n", __func__,
 		ddata->name ? ddata->name : "");
 
 	error = pm_runtime_put_sync_suspend(dev);
-	if (error < 0) {
-		dev_warn(ddata->dev, "%s not idle %i %s\n",
+	if (error == -EBUSY) {
+		dev_dbg(ddata->dev, "%s busy, tagging for noirq suspend %s\n",
+			__func__, ddata->name ? ddata->name : "");
+
+		ddata->noirq_suspend = true;
+
+		return 0;
+	} else if (error < 0) {
+		dev_warn(ddata->dev, "%s cannot suspend %i %s\n",
 			 __func__, error,
 			 ddata->name ? ddata->name : "");
 
@@ -743,73 +750,86 @@ static int sysc_resume(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->cfg.quirks & (SYSC_QUIRK_RESOURCE_PROVIDER |
-				 SYSC_QUIRK_LEGACY_IDLE))
+	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (ddata->needs_resume) {
-		dev_dbg(ddata->dev, "%s %s\n", __func__,
-			ddata->name ? ddata->name : "");
+	if (!ddata->needs_resume || ddata->noirq_suspend)
+		return 0;
 
-		error = pm_runtime_get_sync(dev);
-		if (error < 0) {
-			dev_err(ddata->dev, "%s  error %i %s\n",
-				__func__, error,
-				 ddata->name ? ddata->name : "");
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
 
-			return error;
-		}
+	error = pm_runtime_get_sync(dev);
+	if (error < 0) {
+		dev_err(ddata->dev, "%s  error %i %s\n",
+			__func__, error,
+			ddata->name ? ddata->name : "");
 
-		ddata->needs_resume = false;
+		return error;
 	}
 
+	ddata->needs_resume = false;
+
 	return 0;
 }
 
 static int sysc_noirq_suspend(struct device *dev)
 {
 	struct sysc *ddata;
+	int error;
 
 	ddata = dev_get_drvdata(dev);
 
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
-		return 0;
-
-	if (!ddata->enabled)
+	if (!ddata->enabled || !ddata->noirq_suspend)
 		return 0;
 
 	dev_dbg(ddata->dev, "%s %s\n", __func__,
 		ddata->name ? ddata->name : "");
 
+	error = sysc_runtime_suspend(dev);
+	if (error) {
+		dev_warn(ddata->dev, "%s busy %i %s\n",
+			 __func__, error, ddata->name ? ddata->name : "");
+
+		return 0;
+	}
+
 	ddata->needs_resume = true;
 
-	return sysc_runtime_suspend(dev);
+	return 0;
 }
 
 static int sysc_noirq_resume(struct device *dev)
 {
 	struct sysc *ddata;
+	int error;
 
 	ddata = dev_get_drvdata(dev);
 
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (!(ddata->cfg.quirks & SYSC_QUIRK_RESOURCE_PROVIDER))
+	if (!ddata->needs_resume || !ddata->noirq_suspend)
 		return 0;
 
-	if (ddata->needs_resume) {
-		dev_dbg(ddata->dev, "%s %s\n", __func__,
-			ddata->name ? ddata->name : "");
+	dev_dbg(ddata->dev, "%s %s\n", __func__,
+		ddata->name ? ddata->name : "");
 
-		ddata->needs_resume = false;
+	error = sysc_runtime_resume(dev);
+	if (error) {
+		dev_warn(ddata->dev, "%s cannot resume %i %s\n",
+			 __func__, error,
+			 ddata->name ? ddata->name : "");
 
-		return sysc_runtime_resume(dev);
+		return error;
 	}
 
+	/* Maybe also reconsider clearing noirq_suspend at some point */
+	ddata->needs_resume = false;
+
 	return 0;
 }
 #endif
@@ -848,26 +868,6 @@ struct sysc_revision_quirk {
 	}
 
 static const struct sysc_revision_quirk sysc_revision_quirks[] = {
-	/* These need to use noirq_suspend */
-	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("mcspi", 0, 0, 0x10, -1, 0x40300a0b, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-	SYSC_QUIRK("sdma", 0, 0, 0x2c, 0x28, 0x00010900, 0xffffffff,
-		   SYSC_QUIRK_RESOURCE_PROVIDER),
-
 	/* These drivers need to be fixed to not use pm_runtime_irq_safe() */
 	SYSC_QUIRK("gpio", 0, 0, 0x10, 0x114, 0x50600801, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_OPT_CLKS_IN_RESET),
@@ -892,23 +892,25 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 
-	/* These devices don't yet suspend properly without legacy setting */
-	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
-	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
-
 #ifdef DEBUG
 	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
+	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
 	SYSC_QUIRK("gpu", 0, 0x1fc00, 0x1fc10, -1, 0, 0, 0),
 	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff, 0),
 	SYSC_QUIRK("hsi", 0, 0, 0x10, 0x14, 0x50043101, 0xffffffff, 0),
 	SYSC_QUIRK("iss", 0, 0, 0x10, -1, 0x40000101, 0xffffffff, 0),
+	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xffffffff, 0),
 	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44306302, 0xffffffff, 0),
 	SYSC_QUIRK("mcbsp", 0, -1, 0x8c, -1, 0, 0, 0),
+	SYSC_QUIRK("mcspi", 0, 0, 0x10, -1, 0x40300a0b, 0xffffffff, 0),
 	SYSC_QUIRK("mailbox", 0, 0, 0x10, -1, 0x00000400, 0xffffffff, 0),
+	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xffffffff, 0),
+	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff, 0),
+	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff, 0),
+	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
+	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff, 0),
+	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff, 0),
+	SYSC_QUIRK("sdma", 0, 0, 0x2c, 0x28, 0x00010900, 0xffffffff, 0),
 	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40000902, 0xffffffff, 0),
 	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40002903, 0xffffffff, 0),
 	SYSC_QUIRK("spinlock", 0, 0, 0x10, -1, 0x50020000, 0xffffffff, 0),
@@ -916,6 +918,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, 0),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xffffffff, 0),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff, 0),
 #endif
 };
 
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -46,7 +46,6 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
-#define SYSC_QUIRK_RESOURCE_PROVIDER	BIT(9)
 #define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
 #define SYSC_QUIRK_RESET_STATUS		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
-- 
2.19.0
