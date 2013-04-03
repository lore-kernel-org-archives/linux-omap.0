From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: [PATCH] OMAP/serial: Revert bad fix of Rx FIFO threshold granularity
Date: Wed, 3 Apr 2013 14:31:46 -0400
Message-ID: <20130403183146.GA4072@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:48346 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759104Ab3DCSby (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 14:31:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Partially reverts 1776fd059c40907297d6c26c51876575d63fd9e2
that introduced regression reported by Paul Walmsley.

This commit restores setting granularity in SCR register
and adds note about comments below being inconsistent with
actual code.

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-serial@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-omap@vger.kernel.org 

---

Paul, please confirm that this patch solves the regression.

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4dc4140..30d4f7a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -886,6 +886,17 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
 
+	up->scr |= OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
+	/*
+	 * NOTE: Setting OMAP_UART_SCR_RX_TRIG_GRANU1_MASK
+	 * sets Enables the granularity of 1 for TRIGGER RX
+	 * level. Along with setting RX FIFO trigger level
+	 * to 1 (as noted below, 16 characters) and TLR[3:0]
+	 * to zero this will result RX FIFO threshold level
+	 * to 1 character, instead of 16 as noted in comment
+	 * below.
+	 */
+
 	/* Set receive FIFO threshold to 16 characters and
 	 * transmit FIFO threshold to 16 spaces
 	 */
