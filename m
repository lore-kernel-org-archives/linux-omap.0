From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 3/3] serial: omap: Remove the hardcode serial_omap_console_ports array.
Date: Wed, 3 Oct 2012 17:24:38 +0530
Message-ID: <1349265278-27763-3-git-send-email-shubhrajyoti@ti.com>
References: <1349265278-27763-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1349265278-27763-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the array serial_omap_console_ports is hard coded to 4.
Make it depend on the maximum uart count.
Post to [cfc55bc ARM: OMAP2+: serial: Change MAX_HSUART_PORTS to 6]
the max ports is 6.

Cc: AnilKumar Ch <anilkumar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index caf49a6..478383d 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1077,7 +1077,7 @@ out:
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
 
-static struct uart_omap_port *serial_omap_console_ports[4];
+static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSUART_PORTS];
 
 static struct uart_driver serial_omap_reg;
 
-- 
1.7.5.4

