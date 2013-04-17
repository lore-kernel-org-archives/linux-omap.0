From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 1/6] driver: tty: serial: Move "uart_console" def to core header file.
Date: Wed, 17 Apr 2013 17:04:22 +0530
Message-ID: <1366198467-6757-2-git-send-email-sourav.poddar@ti.com>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Move "uart_console" definition to serial core header file, so that it can be
used by serial drivers.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/tty/serial/serial_core.c |    6 ------
 include/linux/serial_core.h      |    6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a400002..b5f74bf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -50,12 +50,6 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
-#ifdef CONFIG_SERIAL_CORE_CONSOLE
-#define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
-#else
-#define uart_console(port)	(0)
-#endif
-
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 87d4bbc..a6f27f2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -31,6 +31,12 @@
 #include <linux/sysrq.h>
 #include <uapi/linux/serial_core.h>
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+#define uart_console(port)      ((port)->cons && (port)->cons->index == (port)->line)
+#else
+#define uart_console(port)      (0)
+#endif
+
 struct uart_port;
 struct serial_struct;
 struct device;
-- 
1.7.1

