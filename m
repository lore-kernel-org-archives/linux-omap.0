From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/14] omap: mailbox: don't export unecessary symbols
Date: Fri, 11 Jun 2010 18:51:42 +0300
Message-ID: <1276271509-11983-8-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41041 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728Ab0FKPwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:36 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so872602wwb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:36 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap2/mailbox.c |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 211b9fc..590ac66 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -141,7 +141,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f67cb2c..3ff1ad5 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -306,7 +306,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 
 #if defined(CONFIG_ARCH_OMAP2420)
 
@@ -356,7 +355,6 @@ struct omap_mbox mbox_1_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_1_priv,
 };
-EXPORT_SYMBOL(mbox_1_info);
 
 static struct omap_mbox2_priv omap2_mbox_2_priv = {
 	.tx_fifo = {
@@ -379,7 +377,6 @@ struct omap_mbox mbox_2_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_2_priv,
 };
-EXPORT_SYMBOL(mbox_2_info);
 
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
-- 
1.7.1

