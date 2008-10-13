From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] n800: usb: fix num_eps and avoid BUG()
Date: Mon, 13 Oct 2008 15:35:45 +0300
Message-ID: <1223901345-25847-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20996 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbYJMMgx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 08:36:53 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9DCZemm026546
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 07:36:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

num_eps is 16, not 32.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
index f8df19e..fc128f2 100644
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -73,7 +73,7 @@ static struct musb_hdrc_config musb_config = {
 	.dyn_fifo	= 1,
 	.soft_con	= 1,
 	.dma		= 1,
-	.num_eps	= 32,
+	.num_eps	= 16,
 	.dma_channels	= 7,
 	.ram_bits	= 12,
 	.eps_bits	= musb_eps,
-- 
1.6.0.2.307.gc427

