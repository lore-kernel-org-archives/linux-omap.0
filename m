From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] serial: omap: add the functionality of a 9-bit UART with userspaces CMSPAR
Date: Thu,  6 Dec 2012 09:45:04 +0100
Message-ID: <1354783504-7826-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42224 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab2LFIpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Dec 2012 03:45:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Some systems require the additional communication functionality of a
9-bit UART. For that we could use the "stick" (mark/space) parity
bit supported on omap serial device. When is set, if PARODD is set the
parity bit is always 1; if PARODD is not set, then the parity bit is
always 0.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/tty/serial/omap-serial.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6d3d26a..197fb71 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -756,6 +756,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		cval |= UART_LCR_PARITY;
 	if (!(termios->c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
+	if (termios->c_cflag & CMSPAR)
+		cval |= UART_LCR_SPAR;
 
 	/*
 	 * Ask the core to calculate the divisor for us.
-- 
1.7.10.4

