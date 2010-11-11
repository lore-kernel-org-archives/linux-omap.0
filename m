From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Subject: [PATCH] OMAP: Serial: Define OMAP uart MDR1 register definitions
Date: Thu, 11 Nov 2010 11:38:31 +0200
Message-ID: <1289468311-30538-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:61658 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab0KKJkS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 04:40:18 -0500
Received: from niko (esdhcp034153.research.nokia.com [172.21.34.153])
	by mgw-sa01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id oAB9eGwJ003685
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 11:40:16 +0200
Received: from niko by niko with local (Exim 4.71)
	(envelope-from <andrei.emeltchenko.news@gmail.com>)
	id 1PGTbz-0007x1-IA
	for linux-omap@vger.kernel.org; Thu, 11 Nov 2010 11:38:31 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Define MDR1 register serial definitions used in serial and
bluetooth drivers. Remove magic numbers there.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/linux/serial_reg.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index c7a0ce1..b62968c 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -341,5 +341,17 @@
 #define UART_OMAP_SYSS		0x16	/* System status register */
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
+/*
+ * These are the definitions for the MDR1 register
+ */
+#define UART_MDR1_16X_MODE		0x00	/* UART 16x mode */
+#define UART_MDR1_SIR_MODE		0x01	/* SIR mode */
+#define UART_MDR1_16X_AUTOBAUD_MODE	0x02	/* UART 16x auto-baud */
+#define UART_MDR1_13X_MODE		0x03	/* UART 13x mode */
+#define UART_MDR1_MIR_MODE		0x04	/* MIR mode */
+#define UART_MDR1_FIR_MODE		0x05	/* FIR mode */
+#define UART_MDR1_CIR_MODE		0x06	/* CIR mode */
+#define UART_MDR1_DISABLE		0x07	/* Disable (default state) */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.7.0.4

