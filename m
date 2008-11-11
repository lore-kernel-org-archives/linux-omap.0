From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 02/59] omap: namespace cleanup to arch/arm/mach-omap1/board-h2.c
Date: Wed, 12 Nov 2008 00:56:21 +0200
Message-ID: <1226444238-14614-3-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56869 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYKKW5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:57:55 -0500
In-Reply-To: <1226444238-14614-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-h2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 2c12dfa..84012d6 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -534,7 +534,7 @@ static void __init h2_init(void)
 
 	/* Irda */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
+	__raw_writel(__raw_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
 	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
 		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
 		h2_irda_data.transceiver_mode = h2_transceiver_mode;
-- 
1.6.0.2.307.gc427

