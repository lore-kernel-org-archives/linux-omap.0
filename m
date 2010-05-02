From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/8] omap: mailbox: trivial cleanups
Date: Mon,  3 May 2010 02:59:51 +0300
Message-ID: <1272844798-25330-2-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34449 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab0ECAAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:00:18 -0400
Received: by bwz19 with SMTP id 19so1032682bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:00:16 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Also fix a few compilation warnings.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |    7 +++----
 arch/arm/plat-omap/mailbox.c  |    2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

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

