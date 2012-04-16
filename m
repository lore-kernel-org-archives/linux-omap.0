From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 4/7] UART: OMAP: Remove the default setting of special character
Date: Mon, 16 Apr 2012 20:36:58 +0530
Message-ID: <1334588821-5224-5-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35043 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab2DPPHP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 11:07:15 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Special character detect enable if enabled by default.Received data
comparison with XOFF2 data happens by default.

tty provides only XOFF1 no X0FF2 is provided so no need
to enable check for XOFF2.

Keeping this enabled might give some slow transfers due to dummy xoff2
comparison with xoff2 reset value.

Since not all want the XOFF2 support lets not enable it by
default.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 887d578..7c69b21 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -682,11 +682,7 @@ serial_omap_configure_xonxoff
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
1.7.4.1

