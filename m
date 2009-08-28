From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 11:28:09 +0530
Message-ID: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43236 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbZH1F6f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 01:58:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net, sshtylyov@ru.mvista.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Swaminathan S <swami.iyer@ti.com>, Babu Ravi <ravibabu@ti.com>

Isochronous Tx DMA is getting programmed but never getting started
for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.

Fixing it by starting DMAs using musb_h_tx_dma_start().

Signed-off-by: Swaminathan S <swami.iyer@ti.com>
Signed-off-by: Babu Ravi <ravibabu@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_host.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index cf94511..e3ab40a 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1301,8 +1301,11 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		return;
 	} else	if (usb_pipeisoc(pipe) && dma) {
 		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
-				offset, length))
+				offset, length)) {
+			if (is_cppi_enabled() || tusb_dma_omap())
+				musb_h_tx_dma_start(hw_ep);
 			return;
+		}
 	} else	if (tx_csr & MUSB_TXCSR_DMAENAB) {
 		DBG(1, "not complete, but DMA enabled?\n");
 		return;
-- 
1.6.2.4

