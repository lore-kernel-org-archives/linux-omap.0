From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv3] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Fri, 21 Jan 2011 11:01:24 +0100
Message-ID: <1295604084-27761-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, manjugk@ti.com, gadiyar@ti.com, tony@atomide.com, govindraj@ti.com, gregkh@suse.de, andrei.emeltchenko@nokia.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Magic SysRq key is not working for OMAP on new serial
console ttyOx because SUPPORT_SYSRQ is not defined
for omap-serial.

This patch defines SUPPORT_SYSRQ in omap-serial and
enables handling of Magic SysRq character.

Further there is an issue of losing first break character.
Removing the reset of the lsr_break_flag fixes this issue.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/serial/omap-serial.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 7f2f010..699b344 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
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
1.7.4.rc2
