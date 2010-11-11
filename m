From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Subject: [PATCHv2] OMAP: Serial: Define OMAP uart MDR1 register definitions
Date: Thu, 11 Nov 2010 16:13:32 +0200
Message-ID: <1289484812-17278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Define MDR1 register serial definitions used in serial and
bluetooth drivers. Remove magic numbers there.
*v2	added OMAP keyword

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/linux/serial_reg.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index c7a0ce1..6f38234 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -341,5 +341,17 @@
 #define UART_OMAP_SYSS		0x16	/* System status register */
 #define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
+/*
+ * These are the definitions for the MDR1 register
+ */
+#define UART_OMAP_MDR1_16X_MODE		0x00	/* UART 16x mode */
+#define UART_OMAP_MDR1_SIR_MODE		0x01	/* SIR mode */
+#define UART_OMAP_MDR1_16X_ABAUD_MODE	0x02	/* UART 16x auto-baud */
+#define UART_OMAP_MDR1_13X_MODE		0x03	/* UART 13x mode */
+#define UART_OMAP_MDR1_MIR_MODE		0x04	/* MIR mode */
+#define UART_OMAP_MDR1_FIR_MODE		0x05	/* FIR mode */
+#define UART_OMAP_MDR1_CIR_MODE		0x06	/* CIR mode */
+#define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.7.0.4
