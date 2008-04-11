From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 07/23] USB: MUSB: checkpatch.pl fixes to cppi_dma.c
Date: Fri, 11 Apr 2008 11:28:20 +0300
Message-ID: <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40659 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbYDKIaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:09 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8U5RO016374
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:07 +0300
In-Reply-To: <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/cppi_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index 71c42db..e6770d6 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -359,7 +359,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 			"\n",
 		c->index, tag,
 		musb_readl(c->controller->tibase,
-			DAVINCI_RXCPPI_BUFCNT0_REG + 4 *c->index),
+			DAVINCI_RXCPPI_BUFCNT0_REG + 4 * c->index),
 		musb_readw(c->hw_ep->regs, MUSB_RXCSR),
 
 		musb_readl(&rx->rx_skipbytes, 0),
-- 
1.5.5.23.g2a5fe

