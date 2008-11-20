From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM-20081119] OMAP: PM: Check both, IOPAD and UART wakeup always
Date: Thu, 20 Nov 2008 10:43:46 +0200
Message-ID: <1227170626-22021-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61871 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYKTInz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 03:43:55 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAK8hljo023350
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 10:43:52 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Uart RX might not always generate IOPAD wake-up. E.g. IOPAD is not
enabled or core was not in sleep state.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 745ae5c..8d2f0b1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -281,7 +281,7 @@ void omap_uart_resume_idle(int num)
 			}
 
 			/* Check for normal UART wakeup */
-			else if (__raw_readl(uart->wk_st) & uart->wk_mask)
+			if (__raw_readl(uart->wk_st) & uart->wk_mask)
 				omap_uart_block_sleep(uart);
 
 			return;
-- 
1.6.0.1

