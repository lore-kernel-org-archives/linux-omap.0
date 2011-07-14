From: Nick Pelly <npelly@google.com>
Subject: [PATCH] omap-serial: Allow IXON and IXOFF to be disabled.
Date: Thu, 14 Jul 2011 11:49:20 -0700
Message-ID: <1310669360-752-1-git-send-email-npelly@google.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2164 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab1GNStZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 14:49:25 -0400
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p6EInNsS003052
	for <linux-omap@vger.kernel.org>; Thu, 14 Jul 2011 11:49:24 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>

Fixes logic bug that software flow control cannot be disabled, because
serial_omap_configure_xonxoff() is not called if both IXON and IXOFF bits
are cleared.

Signed-off-by: Nick Pelly <npelly@google.com>
---
 drivers/tty/serial/omap-serial.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 47cadf4..6d3ec14 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -806,8 +806,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 	/* Software Flow Control Configuration */
-	if (termios->c_iflag & (IXON | IXOFF))
-		serial_omap_configure_xonxoff(up, termios);
+	serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
-- 
1.7.5.2

