From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 35/59] omap: namespace cleanup to drivers/net/irda/omap-ir.c
Date: Wed, 12 Nov 2008 00:56:54 +0200
Message-ID: <1226444238-14614-36-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56667 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYKKXFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:35 -0500
In-Reply-To: <1226444238-14614-35-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/net/irda/omap-ir.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
index b706253..3652ff3 100644
--- a/drivers/net/irda/omap-ir.c
+++ b/drivers/net/irda/omap-ir.c
@@ -138,12 +138,12 @@ struct omap_irda {
 
 static void inline uart_reg_out(int idx, u8 val)
 {
-	omap_writeb(val, idx);
+	__raw_writeb(val, idx);
 }
 
 static u8 inline uart_reg_in(int idx)
 {
-	u8 b = omap_readb(idx);
+	u8 b = __raw_readb(idx);
 	return b;
 }
 
@@ -232,14 +232,14 @@ static int omap_irda_startup(struct net_device *dev)
 	/* FIXME: use clk_* apis for UART3 clock*/
 	/* Enable UART3 clock and set UART3 to IrDA mode */
 	if (machine_is_omap_h2() || machine_is_omap_h3())
-		omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
+		__raw_writel(__raw_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
 				MOD_CONF_CTRL_0);
 
 	/* Only for H2?
 	 */
 	if (omap_ir->pdata->transceiver_mode && machine_is_omap_h2()) {
 		/* Is it select_irda on H2 ? */
-		omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7,
+		__raw_writel(__raw_readl(FUNC_MUX_CTRL_A) | 7,
 					FUNC_MUX_CTRL_A);
 		omap_ir->pdata->transceiver_mode(omap_ir->dev, IR_SIRMODE);
 	}
-- 
1.6.0.2.307.gc427

