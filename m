From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.34 4/9] arm: omap: musb: remove unused dma data
Date: Wed, 30 Dec 2009 00:59:22 +0200
Message-ID: <1262127567-15202-5-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50518 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZL2W7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:59:42 -0500
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org

we don't use those anywhere on musb driver, so
let's remove those old stuff.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 600286f..e0050c5 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -50,10 +50,7 @@ static struct resource musb_resources[] = {
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
-	.dma		= 1,
 	.num_eps	= 16,
-	.dma_channels	= 7,
-	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 	.ram_bits	= 12,
 };
 
-- 
1.6.6.35.g1d85d

