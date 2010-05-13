From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/15] omap: mailbox: trivial cleanups
Date: Thu, 13 May 2010 20:47:22 +0300
Message-ID: <1273772856-10881-2-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:11171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0EMRsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2624632fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:12 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

And fix a few compilation warnings.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    6 ++----
 arch/arm/mach-omap1/mailbox.c |    3 +--
 arch/arm/mach-omap2/mailbox.c |    7 +++----
 arch/arm/plat-omap/mailbox.c  |    2 --
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index a2d07aa..462b59c 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -73,12 +73,10 @@ static inline void omap_init_rtc(void) {}
 #  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
 #endif
 
-#define OMAP1_MBOX_BASE		OMAP1_IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
-
 static struct resource mbox_resources[] = {
 	{
-		.start		= OMAP1_MBOX_BASE,
-		.end		= OMAP1_MBOX_BASE + OMAP1_MBOX_SIZE,
+		.start		= OMAP16XX_MAILBOX_BASE,
+		.end		= OMAP16XX_MAILBOX_BASE + OMAP1_MBOX_SIZE,
 		.flags		= IORESOURCE_MEM,
 	},
 	{
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index caf889a..f3266dd 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -146,7 +146,6 @@ EXPORT_SYMBOL(mbox_dsp_info);
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret = 0;
 
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid number of resources: %d\n",
@@ -160,7 +159,7 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid mem resource\n");
 		return -ENODEV;
 	}
-	mbox_base = res->start;
+	mbox_base = OMAP1_IO_ADDRESS(res->start);
 
 	/* DSP IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 281ab63..7263b9b 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -93,7 +93,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
 	if (IS_ERR(mbox_ick_handle)) {
-		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
+		printk(KERN_ERR "Could not get mailboxes_ick: %ld\n",
 			PTR_ERR(mbox_ick_handle));
 		return PTR_ERR(mbox_ick_handle);
 	}
@@ -279,8 +279,6 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.irqdisable	= MAILBOX_IRQENABLE(0),
 };
 
-
-
 /* OMAP4 specific data structure. Use the cpu_is_omap4xxx()
 to use this*/
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
@@ -336,7 +334,6 @@ struct omap_mbox mbox_2_info = {
 };
 EXPORT_SYMBOL(mbox_2_info);
 
-
 #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -419,8 +416,10 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 #endif
 	return 0;
 
+#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 err_iva1:
 	omap_mbox_unregister(&mbox_dsp_info);
+#endif
 
 err_dsp:
 	iounmap(mbox_base);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8d86b0b..822c377 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -82,7 +82,6 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 	return ret;
 }
 
-
 int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 
@@ -108,7 +107,6 @@ static void mbox_tx_tasklet(unsigned long tx_data)
 	struct request_queue *q = mbox->txq->queue;
 
 	while (1) {
-
 		rq = blk_fetch_request(q);
 
 		if (!rq)
-- 
1.7.1

