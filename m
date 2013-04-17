From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFT/PATCH 2/6] driver: serial: mpc52xx_uart: Remove "uart_console" defintion
Date: Wed, 17 Apr 2013 17:04:23 +0530
Message-ID: <1366198467-6757-3-git-send-email-sourav.poddar@ti.com>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Sylvain Munaut <tnt@246tNt.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Since "uart_console" definition is now moved to serial core
haeder file . Serial drivers need not define them.

Cc: Sylvain Munaut <tnt@246tNt.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/tty/serial/mpc52xx_uart.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 018bad9..d74ac06 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -84,16 +84,6 @@ static void mpc52xx_uart_of_enumerate(void);
 static irqreturn_t mpc52xx_uart_int(int irq, void *dev_id);
 static irqreturn_t mpc5xxx_uart_process_int(struct uart_port *port);
 
-
-/* Simple macro to test if a port is console or not. This one is taken
- * for serial_core.c and maybe should be moved to serial_core.h ? */
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-#define uart_console(port) \
-	((port)->cons && (port)->cons->index == (port)->line)
-#else
-#define uart_console(port)	(0)
-#endif
-
 /* ======================================================================== */
 /* PSC fifo operations for isolating differences between 52xx and 512x      */
 /* ======================================================================== */
-- 
1.7.1
