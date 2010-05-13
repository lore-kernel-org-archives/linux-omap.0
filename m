From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/15] omap: mailbox: don't export unecessary symbols
Date: Thu, 13 May 2010 20:47:35 +0300
Message-ID: <1273772856-10881-15-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659Ab0EMRtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:49:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1239991fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:49:04 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
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
index 8eea651..b01d3c3 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -140,7 +140,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 2817103..b0d7740 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -285,7 +285,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3430)
@@ -342,7 +341,6 @@ struct omap_mbox mbox_1_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_1_priv,
 };
-EXPORT_SYMBOL(mbox_1_info);
 
 static struct omap_mbox2_priv omap2_mbox_2_priv = {
 	.tx_fifo = {
@@ -365,7 +363,6 @@ struct omap_mbox mbox_2_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_2_priv,
 };
-EXPORT_SYMBOL(mbox_2_info);
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
-- 
1.7.1

