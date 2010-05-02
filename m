From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/8] omap: mailbox: 2420 should be detected at run-time
Date: Mon,  3 May 2010 02:59:53 +0300
Message-ID: <1272844798-25330-4-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34449 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECAAY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:00:24 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1032682bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:00:24 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 252e53b..a328664 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -287,8 +287,6 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
-#if defined(CONFIG_ARCH_OMAP2420)
-
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -311,7 +309,6 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
-#endif
 
 /* OMAP4 */
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
@@ -401,7 +398,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 			goto err_dsp;
 		}
 	}
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 	if (cpu_is_omap2420()) {
 		/* IVA IRQ */
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
@@ -415,13 +411,10 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_iva1;
 	}
-#endif
 	return 0;
 
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 err_iva1:
 	omap_mbox_unregister(&mbox_dsp_info);
-#endif
 
 err_dsp:
 	iounmap(mbox_base);
@@ -430,9 +423,8 @@ err_dsp:
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
-#if defined(CONFIG_ARCH_OMAP2420)
-	omap_mbox_unregister(&mbox_iva_info);
-#endif
+	if (cpu_is_omap2420())
+		omap_mbox_unregister(&mbox_iva_info);
 
 	if (cpu_is_omap44xx()) {
 		omap_mbox_unregister(&mbox_2_info);
-- 
1.7.1

