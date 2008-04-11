From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 22/23] USB: MUSB: checkpatch.pl fixed to musb_regs.h
Date: Fri, 11 Apr 2008 11:28:35 +0300
Message-ID: <1207902516-6374-23-git-send-email-felipe.balbi@nokia.com>
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
 <1207902516-6374-20-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-21-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-22-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26628 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506AbYDKIaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:22 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpFO021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:19 +0300
In-Reply-To: <1207902516-6374-22-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_regs.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index d1500a4..9c22866 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -204,10 +204,10 @@
 
 /* CSR0 bits to avoid zeroing (write zero clears, write 1 ignored) */
 #define MUSB_CSR0_P_WZC_BITS	\
-	( MUSB_CSR0_P_SENTSTALL )
+	(MUSB_CSR0_P_SENTSTALL)
 #define MUSB_CSR0_H_WZC_BITS	\
-	( MUSB_CSR0_H_NAKTIMEOUT | MUSB_CSR0_H_RXSTALL \
-	| MUSB_CSR0_RXPKTRDY )
+	(MUSB_CSR0_H_NAKTIMEOUT | MUSB_CSR0_H_RXSTALL \
+	| MUSB_CSR0_RXPKTRDY)
 
 /* TxType/RxType */
 #define MUSB_TYPE_SPEED		0xc0
@@ -253,11 +253,11 @@
 
 /* TXCSR bits to avoid zeroing (write zero clears, write 1 ignored) */
 #define MUSB_TXCSR_P_WZC_BITS	\
-	( MUSB_TXCSR_P_INCOMPTX | MUSB_TXCSR_P_SENTSTALL \
-	| MUSB_TXCSR_P_UNDERRUN | MUSB_TXCSR_FIFONOTEMPTY )
+	(MUSB_TXCSR_P_INCOMPTX | MUSB_TXCSR_P_SENTSTALL \
+	| MUSB_TXCSR_P_UNDERRUN | MUSB_TXCSR_FIFONOTEMPTY)
 #define MUSB_TXCSR_H_WZC_BITS	\
-	( MUSB_TXCSR_H_NAKTIMEOUT | MUSB_TXCSR_H_RXSTALL \
-	| MUSB_TXCSR_H_ERROR | MUSB_TXCSR_FIFONOTEMPTY )
+	(MUSB_TXCSR_H_NAKTIMEOUT | MUSB_TXCSR_H_RXSTALL \
+	| MUSB_TXCSR_H_ERROR | MUSB_TXCSR_FIFONOTEMPTY)
 
 /* RXCSR in Peripheral and Host mode */
 #define MUSB_RXCSR_AUTOCLEAR		0x8000
@@ -288,11 +288,11 @@
 
 /* RXCSR bits to avoid zeroing (write zero clears, write 1 ignored) */
 #define MUSB_RXCSR_P_WZC_BITS	\
-	( MUSB_RXCSR_P_SENTSTALL | MUSB_RXCSR_P_OVERRUN \
-	| MUSB_RXCSR_RXPKTRDY )
+	(MUSB_RXCSR_P_SENTSTALL | MUSB_RXCSR_P_OVERRUN \
+	| MUSB_RXCSR_RXPKTRDY)
 #define MUSB_RXCSR_H_WZC_BITS	\
-	( MUSB_RXCSR_H_RXSTALL | MUSB_RXCSR_H_ERROR \
-	| MUSB_RXCSR_DATAERROR | MUSB_RXCSR_RXPKTRDY )
+	(MUSB_RXCSR_H_RXSTALL | MUSB_RXCSR_H_ERROR \
+	| MUSB_RXCSR_DATAERROR | MUSB_RXCSR_RXPKTRDY)
 
 /* HUBADDR */
 #define MUSB_HUBADDR_MULTI_TT		0x80
-- 
1.5.5.23.g2a5fe

