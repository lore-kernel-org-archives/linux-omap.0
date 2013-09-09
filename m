From: Phil Carmody <phil.carmody@partner.samsung.com>
Subject: [PATCH 1/1] OMAP2+: mux: fix trivial typo in name
Date: Mon, 09 Sep 2013 16:18:00 +0300
Message-ID: <1378732680-13159-1-git-send-email-phil.carmody@partner.samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35286 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3IINST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 09:18:19 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSV004NJ0Y6Z080@mailout2.w1.samsung.com> for
 linux-omap@vger.kernel.org; Mon, 09 Sep 2013 14:18:17 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Phil Carmody <phil.carmody@partner.samsung.com>

Signed-off-by: Phil Carmody <phil.carmody@partner.samsung.com>
---
 arch/arm/mach-omap2/mux34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index c53609f4..be271f1 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -620,7 +620,7 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 		"uart1_rts", "ssi1_flag_tx", NULL, NULL,
 		"gpio_149", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_RX, 151,
-		"uart1_rx", "ss1_wake_tx", "mcbsp1_clkr", "mcspi4_clk",
+		"uart1_rx", "ssi1_wake_tx", "mcbsp1_clkr", "mcspi4_clk",
 		"gpio_151", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(UART1_TX, 148,
 		"uart1_tx", "ssi1_dat_tx", NULL, NULL,
-- 
1.7.9.5

