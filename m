From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/13] serial: fix UART_IIR_ID
Date: Wed, 23 Apr 2014 09:58:28 -0500
Message-ID: <1398265117-11793-4-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
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
1.9.2.459.g68773ac
