From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/14] omap: mailbox: reorganize structures
Date: Fri, 11 Jun 2010 18:51:38 +0300
Message-ID: <1276271509-11983-4-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f204.google.com ([209.85.211.204]:59033 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565Ab0FKPwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:30 -0400
Received: by ywh42 with SMTP id 42so1257641ywh.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:26 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

OMAP4 ones messed up the organization.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   68 +++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 8c1070c..edcfec6 100644
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

