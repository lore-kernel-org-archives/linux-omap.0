From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/15] omap: mailbox: only compile for configured archs
Date: Thu, 13 May 2010 20:47:28 +0300
Message-ID: <1273772856-10881-8-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0EMRsh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1239991fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:37 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 0902965..103c670 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -265,6 +265,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 
 /* FIXME: the following structs should be filled automatically by the user id */
 
+#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
@@ -288,11 +289,13 @@ struct omap_mbox mbox_dsp_info = {
 	.priv	= &omap2_mbox_dsp_priv,
 };
 EXPORT_SYMBOL(mbox_dsp_info);
+#endif
 
+#if defined(CONFIG_ARCH_OMAP3430)
 struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
+#endif
 
 #if defined(CONFIG_ARCH_OMAP2420)
-
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -319,6 +322,7 @@ static struct omap_mbox mbox_iva_info = {
 struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
 /* OMAP4 */
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
 	.tx_fifo = {
@@ -367,6 +371,7 @@ struct omap_mbox mbox_2_info = {
 EXPORT_SYMBOL(mbox_2_info);
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
+#endif
 
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
@@ -380,11 +385,15 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 	if (!mbox_base)
 		return -ENOMEM;
 
-	if (cpu_is_omap3430()) {
+	if (false) {
+	}
+#if defined(CONFIG_ARCH_OMAP3430)
+	else if (cpu_is_omap3430()) {
 		list = omap3_mboxes;
 
 		list[0]->irq = res[1].start;
 	}
+#endif
 #if defined(CONFIG_ARCH_OMAP2420)
 	else if (cpu_is_omap2420()) {
 		list = omap2_mboxes;
@@ -393,12 +402,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		list[1]->irq = res[2].start;
 	}
 #endif
+#if defined(CONFIG_ARCH_OMAP4)
 	else if (cpu_is_omap44xx()) {
 		list = omap4_mboxes;
 
 		list[0]->irq = res[1].start;
 		list[1]->irq = res[1].start;
 	}
+#endif
 	else {
 		pr_err("%s: platform not supported\n", __func__);
 		return -ENODEV;
-- 
1.7.1

