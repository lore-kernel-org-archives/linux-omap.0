From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
Date: Fri, 10 Dec 2010 19:51:06 -0600
Message-ID: <1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44320 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab0LKCC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 21:02:27 -0500
In-Reply-To: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Felipe Contreras <felipe.contreras@gmail.com>

So that we can enable the main clock.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c |   10 +++++++++-
 arch/arm/mach-omap2/mailbox.c |   18 ++++++------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3bb7724..9478cb3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -142,6 +142,14 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+static struct omap_device_pm_latency mbox_latencies[] = {
+	[0] = {
+		.activate_func = omap_device_enable_clocks,
+		.deactivate_func = omap_device_enable_clocks,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
 static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
@@ -155,7 +163,7 @@ static inline void omap_init_mbox(void)
 
 	od = omap_device_build("omap-mailbox", -1, oh,
 			NULL, 0,
-			NULL, 0,
+			mbox_latencies, ARRAY_SIZE(mbox_latencies),
 			0);
 	if (!od) {
 		pr_err("%s: could not build device\n", __func__);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 40ddeca..6dd59b3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
@@ -52,6 +53,7 @@
 #define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
 static void __iomem *mbox_base;
+static struct platform_device *mbox_pdev;
 
 struct omap_mbox2_fifo {
 	unsigned long msg;
@@ -70,8 +72,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static struct clk *mbox_ick_handle;
-
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 				  omap_mbox_type_t irq);
 
@@ -91,13 +91,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	u32 l;
 	unsigned long timeout;
 
-	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
-	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
-			PTR_ERR(mbox_ick_handle));
-		return PTR_ERR(mbox_ick_handle);
-	}
-	clk_enable(mbox_ick_handle);
+	pm_runtime_get_sync(&mbox_pdev->dev);
 
 	if (cpu_is_omap44xx()) {
 		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
@@ -143,9 +137,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
-	clk_disable(mbox_ick_handle);
-	clk_put(mbox_ick_handle);
-	mbox_ick_handle = NULL;
+	pm_runtime_put_sync(&mbox_pdev->dev);
 }
 
 /* Mailbox FIFO handle functions */
@@ -427,6 +419,8 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 	if (!mbox_base)
 		return -ENOMEM;
 
+	mbox_pdev = pdev;
+
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret) {
 		iounmap(mbox_base);
-- 
1.7.1

