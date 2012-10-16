From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/11] SERIAL: omap: no need to re-read EFR
Date: Tue, 16 Oct 2012 12:00:26 +0100
Message-ID: <E1TO4ss-0000WR-0l@rmk-PC.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53229 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2JPLAd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 07:00:33 -0400
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

There's no need to re-read EFR after we've recently written it; the
register is a configuration register which doesn't change its value
without us writing to it.  The last value which was written to this
register was up->efr.

Removing this re-reading avoids the possibility that we end up with
up->efr having unintended bits set, which should only be temporarily
set when accessing the enhanced features.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 71db4e6..c8a0425 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -873,8 +873,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-
-	up->efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, 0);
-- 
1.7.4.4

