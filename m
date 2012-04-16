From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 6/7] UART: OMAP: Remove the hardcode serial_omap_console_ports array.
Date: Mon, 16 Apr 2012 20:37:00 +0530
Message-ID: <1334588821-5224-7-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48415 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2DPPHN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 11:07:13 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Currently the array serial_omap_console_ports is hard coded to 4.
Make it depend on the maximum uart count.
Also fixes OMAP5 which has 6 instances of uart.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1593986..cbc9d64 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1040,7 +1040,7 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
 
-static struct uart_omap_port *serial_omap_console_ports[4];
+static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSUART_PORTS];
 
 static struct uart_driver serial_omap_reg;
 
-- 
1.7.4.1

