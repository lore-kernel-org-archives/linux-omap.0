From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 03/17] omap: mailbox: reorganize structures
Date: Sat, 22 May 2010 00:44:35 +0300
Message-ID: <1274478289-22188-4-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0EUVpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:45:01 -0400
Received: by mail-fx0-f46.google.com with SMTP id 5so1251271fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:45:00 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

OMAP4 ones messed up the organization.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   68 +++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index c9f3d39..7d42034 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -283,6 +283,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
  */
 
 /* FIXME: the following structs should be filled automatically by the user id */
+
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
@@ -300,8 +301,40 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.irqdisable	= MAILBOX_IRQENABLE(0),
 };
 
-/* OMAP4 specific data structure. Use the cpu_is_omap4xxx()
-to use this*/
+struct omap_mbox mbox_dsp_info = {
+	.name	= "dsp",
+	.ops	= &omap2_mbox_ops,
+	.priv	= &omap2_mbox_dsp_priv,
+};
+EXPORT_SYMBOL(mbox_dsp_info);
+
+#if defined(CONFIG_ARCH_OMAP2420)
+
+/* IVA */
+static struct omap_mbox2_priv omap2_mbox_iva_priv = {
+	.tx_fifo = {
+		.msg		= MAILBOX_MESSAGE(2),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(2),
+	},
+	.rx_fifo = {
+		.msg		= MAILBOX_MESSAGE(3),
+		.msg_stat	= MAILBOX_MSGSTATUS(3),
+	},
+	.irqenable	= MAILBOX_IRQENABLE(3),
+	.irqstatus	= MAILBOX_IRQSTATUS(3),
+	.notfull_bit	= MAILBOX_IRQ_NOTFULL(2),
+	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(3),
+	.irqdisable	= MAILBOX_IRQENABLE(3),
+};
+
+static struct omap_mbox mbox_iva_info = {
+	.name	= "iva",
+	.ops	= &omap2_mbox_ops,
+	.priv	= &omap2_mbox_iva_priv,
+};
+#endif
+
+/* OMAP4 */
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
 	.tx_fifo = {
 		.msg		= MAILBOX_MESSAGE(0),
@@ -325,13 +358,6 @@ struct omap_mbox mbox_1_info = {
 };
 EXPORT_SYMBOL(mbox_1_info);
 
-struct omap_mbox mbox_dsp_info = {
-	.name	= "dsp",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_dsp_priv,
-};
-EXPORT_SYMBOL(mbox_dsp_info);
-
 static struct omap_mbox2_priv omap2_mbox_2_priv = {
 	.tx_fifo = {
 		.msg		= MAILBOX_MESSAGE(3),
@@ -355,30 +381,6 @@ struct omap_mbox mbox_2_info = {
 };
 EXPORT_SYMBOL(mbox_2_info);
 
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-static struct omap_mbox2_priv omap2_mbox_iva_priv = {
-	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE(2),
-		.fifo_stat	= MAILBOX_FIFOSTATUS(2),
-	},
-	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE(3),
-		.msg_stat	= MAILBOX_MSGSTATUS(3),
-	},
-	.irqenable	= MAILBOX_IRQENABLE(3),
-	.irqstatus	= MAILBOX_IRQSTATUS(3),
-	.notfull_bit	= MAILBOX_IRQ_NOTFULL(2),
-	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(3),
-	.irqdisable	= MAILBOX_IRQENABLE(3),
-};
-
-static struct omap_mbox mbox_iva_info = {
-	.name	= "iva",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_iva_priv,
-};
-#endif
-
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-- 
1.7.1

