From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/5] omap: mailbox: add omap_device latency information
Date: Tue, 26 Oct 2010 16:53:02 -0500
Message-ID: <1288129984-22957-4-git-send-email-omar.ramirez@ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760542Ab0JZWDR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 18:03:17 -0400
In-Reply-To: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

So that we can enable the main clock.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c             |   19 +++++++++++++++++--
 arch/arm/mach-omap2/mailbox.c             |   21 +++++++++------------
 arch/arm/plat-omap/include/plat/mailbox.h |    6 ++++++
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d977572..337fd7a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -29,6 +29,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/mailbox.h>
 
 #include "mux.h"
 #include "control.h"
@@ -141,10 +142,20 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+static struct omap_device_pm_latency mbox_latencies[] = {
+	[0] = {
+		.activate_func = omap_device_enable_clocks,
+		.activate_lat = 50000, /* FIXME random value */
+		.deactivate_func = omap_device_enable_clocks,
+		.deactivate_lat = 50000, /* FIXME random value */
+	},
+};
+
 static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
+	struct omap_mbox_platform_data pdata;
 
 	oh = omap_hwmod_lookup("mailbox");
 	if (!oh) {
@@ -152,10 +163,14 @@ static inline void omap_init_mbox(void)
 		return;
 	}
 
+	pdata.device_enable = omap_device_enable;
+	pdata.device_disable = omap_device_idle;
+
 	od = omap_device_build("omap-mailbox", -1, oh,
-			NULL, 0,
-			NULL, 0,
+			&pdata, sizeof(pdata),
+			mbox_latencies, ARRAY_SIZE(mbox_latencies),
 			0);
+
 	if (!od) {
 		pr_err("%s: could not build device\n", __func__);
 		return;
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 1ddb82d..61f2149 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -53,6 +53,7 @@
 #define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
 static void __iomem *mbox_base;
+static struct platform_device *mbox_pdev;
 
 struct omap_mbox2_fifo {
 	unsigned long msg;
@@ -71,8 +72,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static struct clk *mbox_ick_handle;
-
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
 				  omap_mbox_type_t irq);
 
@@ -91,14 +90,10 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
 	u32 l;
 	unsigned long timeout;
+	struct omap_mbox_platform_data *pdata = mbox_pdev->dev.platform_data;
 
-	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
-	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
-			PTR_ERR(mbox_ick_handle));
-		return PTR_ERR(mbox_ick_handle);
-	}
-	clk_enable(mbox_ick_handle);
+	if (pdata->device_enable)
+		pdata->device_enable(mbox_pdev);
 
 	if (cpu_is_omap44xx()) {
 		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
@@ -144,9 +139,9 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
-	clk_disable(mbox_ick_handle);
-	clk_put(mbox_ick_handle);
-	mbox_ick_handle = NULL;
+	struct omap_mbox_platform_data *pdata = mbox_pdev->dev.platform_data;
+	if (pdata->device_disable)
+		pdata->device_disable(mbox_pdev);
 }
 
 /* Mailbox FIFO handle functions */
@@ -428,6 +423,8 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 	if (!mbox_base)
 		return -ENOMEM;
 
+	mbox_pdev = pdev;
+
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret) {
 		iounmap(mbox_base);
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..59443b1 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -11,6 +11,7 @@
 
 typedef u32 mbox_msg_t;
 struct omap_mbox;
+struct platform_device;
 
 typedef int __bitwise omap_mbox_irq_t;
 #define IRQ_TX ((__force omap_mbox_irq_t) 1)
@@ -59,6 +60,11 @@ struct omap_mbox {
 	void			*priv;
 };
 
+struct omap_mbox_platform_data {
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_disable)(struct platform_device *pdev);
+};
+
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-- 
1.7.1

