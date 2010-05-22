From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/2] omap: mailbox: add omap_device latency information
Date: Sat, 22 May 2010 20:25:22 +0300
Message-ID: <1274549122-26521-3-git-send-email-felipe.contreras@gmail.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:59392 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab0EVRZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:25:40 -0400
Received: by fg-out-1718.google.com with SMTP id 22so789246fge.1
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:25:38 -0700 (PDT)
In-Reply-To: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

So that we can enable the main clock.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/devices.c             |   12 +++++++++++-
 arch/arm/mach-omap2/mailbox.c             |   20 ++++++++------------
 arch/arm/plat-omap/include/plat/mailbox.h |    3 +++
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 89f6cbc..e6cb1d3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -139,6 +139,14 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
+static struct omap_device_pm_latency mbox_latencies[] = {
+	[0] = { .activate_func = omap_device_enable_clocks,
+		.activate_lat = 50000, /* FIXME random value */
+		.deactivate_func = omap_device_enable_clocks,
+		.deactivate_lat = 50000, /* FIXME random value */
+	},
+};
+
 static inline void omap_init_mbox(void)
 {
 	struct omap_hwmod *hwmod;
@@ -152,10 +160,12 @@ static inline void omap_init_mbox(void)
 	}
 
 	pdata.base_addr = hwmod->_rt_va;
+	pdata.device_enable = omap_device_enable;
+	pdata.device_disable = omap_device_idle;
 
 	odev = omap_device_build("omap-mailbox", -1, hwmod,
 			&pdata, sizeof(pdata),
-			NULL, 0,
+			mbox_latencies, ARRAY_SIZE(mbox_latencies),
 			0);
 	if (!odev) {
 		pr_err("%s: could not build device\n", __func__);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index baaaa5a..157a764 100644
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
@@ -423,6 +418,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 	}
 
 	mbox_base = pdata->base_addr;
+	mbox_pdev = pdev;
 
 	ret = omap_mbox_register(&pdev->dev, list);
 	if (ret)
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 78060bd..a68fdda 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -11,6 +11,7 @@
 
 typedef u32 mbox_msg_t;
 struct omap_mbox;
+struct platform_device;
 
 typedef int __bitwise omap_mbox_irq_t;
 #define IRQ_TX ((__force omap_mbox_irq_t) 1)
@@ -61,6 +62,8 @@ struct omap_mbox {
 
 struct omap_mbox_platform_data {
 	void __iomem *base_addr;
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_disable)(struct platform_device *pdev);
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
-- 
1.7.1

