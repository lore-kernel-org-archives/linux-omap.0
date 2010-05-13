From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/15] omap: mailbox: reorganize structures
Date: Thu, 13 May 2010 20:47:23 +0300
Message-ID: <1273772856-10881-3-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0EMRsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:17 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1239991fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:15 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
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
index 7263b9b..252e53b 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -262,6 +262,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
  */
 
 /* FIXME: the following structs should be filled automatically by the user id */
+
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
@@ -279,8 +280,40 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
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
@@ -304,13 +337,6 @@ struct omap_mbox mbox_1_info = {
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
@@ -334,30 +360,6 @@ struct omap_mbox mbox_2_info = {
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

