From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 05/24] SERIAL: omap: no need to re-read EFR
Date: Sat, 06 Oct 2012 13:40:42 +0100
Message-ID: <E1TKTgQ-0002mf-6v@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47228 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805Ab2JFMkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 08:40:51 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

There's no need to re-read EFR after we've recently written it; the
register is a configuration register which doesn't change its value
without us writing to it.

Removing this re-reading avoids the possibility that we end up with
up->efr having the ECB bit set, which should only be temporarily set
when accessing the enhanced features.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 391087e..654dd78 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -872,8 +872,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-
-	up->efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, 0);
-- 
1.7.4.4

