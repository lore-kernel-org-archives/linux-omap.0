From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 19/23] USB: MUSB: checkpatch.pl fixes to davinci.h
Date: Fri, 11 Apr 2008 11:28:32 +0300
Message-ID: <1207902516-6374-20-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-19-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26609 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757822AbYDKIaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:14 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpFC021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:12 +0300
In-Reply-To: <1207902516-6374-19-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/davinci.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/davinci.h b/drivers/usb/musb/davinci.h
index dc37a19..7fb6238 100644
--- a/drivers/usb/musb/davinci.h
+++ b/drivers/usb/musb/davinci.h
@@ -67,9 +67,9 @@
 #define DAVINCI_CPPI_STATERAM_BASE_OFFSET   0x100
 
 #define DAVINCI_TXCPPI_STATERAM_OFFSET(chnum) \
-	(DAVINCI_CPPI_STATERAM_BASE_OFFSET +       ((chnum)* 0x40))
+	(DAVINCI_CPPI_STATERAM_BASE_OFFSET +       ((chnum) * 0x40))
 #define DAVINCI_RXCPPI_STATERAM_OFFSET(chnum) \
-	(DAVINCI_CPPI_STATERAM_BASE_OFFSET + 0x20 +((chnum)* 0x40))
+	(DAVINCI_CPPI_STATERAM_BASE_OFFSET + 0x20 + ((chnum) * 0x40))
 
 /* CPPI masks */
 #define DAVINCI_DMA_CTRL_ENABLE		1
-- 
1.5.5.23.g2a5fe

