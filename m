From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/3] serial: omap: Remove the default setting of special character
Date: Wed, 3 Oct 2012 17:24:37 +0530
Message-ID: <1349265278-27763-2-git-send-email-shubhrajyoti@ti.com>
References: <1349265278-27763-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1349265278-27763-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

Special character detect enable if enabled by default.Received data
comparison with XOFF2 data happens by default.

tty provides only XOFF1 no X0FF2 is provided so no need
to enable check for XOFF2.

Keeping this enabled might give some slow transfers due to dummy xoff2
comparison with xoff2 reset value.

Since not all want the XOFF2 support lets not enable it by
default.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index fd0fb8c..caf49a6 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -702,11 +702,7 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	/* Enable special char function UARTi.EFR_REG[5] and
-	 * load the new software flow control mode IXON or IXOFF
-	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
-	 */
-	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
-- 
1.7.5.4

