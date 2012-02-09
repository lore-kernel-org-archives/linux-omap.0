From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] OMAP: serial: Remove the hardcode serial_omap_console_ports array.
Date: Thu, 9 Feb 2012 19:18:16 +0530
Message-ID: <1328795296-22935-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Govindraj Raja <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the array serial_omap_console_ports is hard coded to 4.
Make it depend on the macro OMAP_MAX_HSUART_PORTS(which is 4) which
the maximum uart count.

Cc: Govindraj Raja <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1c24269..c570696 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1021,7 +1021,7 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
 
-static struct uart_omap_port *serial_omap_console_ports[4];
+static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSUART_PORTS];
 
 static struct uart_driver serial_omap_reg;
 
-- 
1.7.1

