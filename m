From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/14] omap: mailbox: trivial cleanups
Date: Sat, 22 May 2010 20:14:13 +0300
Message-ID: <1274548465-20208-3-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0EVROg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:36 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383709bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:36 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

And fix a few compilation warnings.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    6 ++----
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |   10 ++++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 379100c..462b59c 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -73,12 +73,10 @@ static inline void omap_init_rtc(void) {}
 #  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
 #endif
 
-#define OMAP1_MBOX_BASE		OMAP16XX_MAILBOX_BASE
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
index 4f5b3da..15bf2a2 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -83,7 +83,7 @@ static int omap1_mbox_fifo_full(struct omap_mbox *mbox)
 	struct omap_mbox1_fifo *fifo =
 		&((struct omap_mbox1_priv *)mbox->priv)->rx_fifo;
 
-	return (mbox_read_reg(fifo->flag));
+	return mbox_read_reg(fifo->flag);
 }
 
 /* irq */
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 763272c..8c1070c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -131,7 +131,7 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	}
 
 	l = mbox_read_reg(MAILBOX_REVISION);
-	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
+	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
 	if (cpu_is_omap44xx())
 		l = OMAP4_SMARTIDLE;
@@ -300,8 +300,6 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.irqdisable	= MAILBOX_IRQENABLE(0),
 };
 
-
-
 /* OMAP4 specific data structure. Use the cpu_is_omap4xxx()
 to use this*/
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
@@ -357,7 +355,6 @@ struct omap_mbox mbox_2_info = {
 };
 EXPORT_SYMBOL(mbox_2_info);
 
-
 #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -443,6 +440,11 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 #endif
 	return 0;
 
+#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
+err_iva1:
+	omap_mbox_unregister(&mbox_dsp_info);
+#endif
+
 err_dsp:
 	iounmap(mbox_base);
 	return ret;
-- 
1.7.1

