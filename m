From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv4] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Tue,  1 Feb 2011 08:30:41 +0100
Message-ID: <1296545441-17070-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Magic SysRq key is not working for OMAP on new serial
console ttyOx because SUPPORT_SYSRQ is not defined
for omap-serial.

This patch defines SUPPORT_SYSRQ in omap-serial and
enables handling of Magic SysRq character.

Further there is an issue of losing first break character.
Removing the reset of the lsr_break_flag fixes this issue.

Signed-off-by: Thomas Weber <weber@corscience.de>
Acked-by: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Manjunath G Kondaiah <manjugk@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
---
v3->v4
	Rebased to 2.6.38-rc2 after move of drivers/serial to drivers/tty/serial
	Added Acked-by and Tested-by

 drivers/tty/serial/omap-serial.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7f2f010..699b344 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -20,6 +20,10 @@
  * this driver as required for the omap-platform.
  */
 
+#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -190,7 +194,6 @@ static inline void receive_chars(struct uart_omap_port *up, int *status)
 			if (up->port.line == up->port.cons->index) {
 				/* Recover the break flag from console xmit */
 				lsr |= up->lsr_break_flag;
-				up->lsr_break_flag = 0;
 			}
 #endif
 			if (lsr & UART_LSR_BI)
-- 
1.7.4.rc3
