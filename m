From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 15/17] omap: mailbox: don't export unecessary symbols
Date: Sat, 22 May 2010 00:44:47 +0300
Message-ID: <1274478289-22188-16-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0EUVpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:45:35 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so202277bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:45:34 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap2/mailbox.c |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index f6376b9..7e6aea3 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -140,7 +140,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index c1a732e..f230edb 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -306,7 +306,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3430)
@@ -363,7 +362,6 @@ struct omap_mbox mbox_1_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_1_priv,
 };
-EXPORT_SYMBOL(mbox_1_info);
 
 static struct omap_mbox2_priv omap2_mbox_2_priv = {
 	.tx_fifo = {
@@ -386,7 +384,6 @@ struct omap_mbox mbox_2_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_2_priv,
 };
-EXPORT_SYMBOL(mbox_2_info);
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
-- 
1.7.1

