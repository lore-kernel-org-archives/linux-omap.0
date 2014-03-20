From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 11/11] serial: fix UART_IIR_ID
Date: Thu, 20 Mar 2014 14:30:07 -0500
Message-ID: <1395343807-21618-11-git-send-email-balbi@ti.com>
References: <1395343807-21618-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395343807-21618-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org, peter@hurleysoftware.com, m-karicheri2@ti.com, b32955@freescale.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

UART IRQ Identification bitfield is 3
bits long (bits 3:1) but current mask only
masks 2 bits. Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/uapi/linux/serial_reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index e632260..99b4705 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -32,7 +32,7 @@
 
 #define UART_IIR	2	/* In:  Interrupt ID Register */
 #define UART_IIR_NO_INT		0x01 /* No interrupts pending */
-#define UART_IIR_ID		0x06 /* Mask for the interrupt ID */
+#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
 #define UART_IIR_MSI		0x00 /* Modem status interrupt */
 #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
 #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
-- 
1.9.1.286.g5172cb3
