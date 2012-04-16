From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 3/7] UART: OMAP: fix software flow control
Date: Mon, 16 Apr 2012 20:36:57 +0530
Message-ID: <1334588821-5224-4-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35045 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611Ab2DPPHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 11:07:15 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vikram Pandita <vikram.pandita@ti.com>, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Software flow control register bits were not defined correctly.

Also clarify the IXON and IXOFF logic to reflect what userspace wants.

Cc: stable@vger.kernel.org
Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    4 ++--
 drivers/tty/serial/omap-serial.c              |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index b7fb6dc..6edc30a 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -42,10 +42,10 @@
 #define OMAP_UART_WER_MOD_WKUP	0X7F
 
 /* Enable XON/XOFF flow control on output */
-#define OMAP_UART_SW_TX		0x04
+#define OMAP_UART_SW_TX		0x8
 
 /* Enable XON/XOFF flow control on input */
-#define OMAP_UART_SW_RX		0x04
+#define OMAP_UART_SW_RX		0x2
 
 #define OMAP_UART_SYSC_RESET	0X07
 #define OMAP_UART_TCR_TRIG	0X0F
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 10e80bb..887d578 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -651,19 +651,19 @@ serial_omap_configure_xonxoff
 
 	/*
 	 * IXON Flag:
-	 * Enable XON/XOFF flow control on output.
-	 * Transmit XON1, XOFF1
+	 * Flow control for OMAP.TX
+	 * OMAP.RX should listen for XON/XOFF
 	 */
 	if (termios->c_iflag & IXON)
-		up->efr |= OMAP_UART_SW_TX;
+		up->efr |= OMAP_UART_SW_RX;
 
 	/*
 	 * IXOFF Flag:
-	 * Enable XON/XOFF flow control on input.
-	 * Receiver compares XON1, XOFF1.
+	 * Flow control for OMAP.RX
+	 * OMAP.TX should send XON/XOFF
 	 */
 	if (termios->c_iflag & IXOFF)
-		up->efr |= OMAP_UART_SW_RX;
+		up->efr |= OMAP_UART_SW_TX;
 
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-- 
1.7.4.1

