From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 13/15] OMAP2+: UART: Take console_lock in suspend path if not taken
Date: Wed, 21 Sep 2011 17:43:50 +0530
Message-ID: <1316607232-21709-4-git-send-email-govindraj.raja@ti.com>
References: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

In suspend path the console_lock is taken by uart_port_suspend
however when no_console_suspend is used console_lock is not taken.

During system wide suspend omap_pwr_domain hooks cut all
clocks that are left enabled. So its unsafe to proceed printing after
clocks are cut by pwr_domain hooks. Also pm_runtime will be disabled after
dpm_suspend devices happens. So buffer all prints in suspend path by taking
console_lock and print them back safely after power domain hooks re-enable
clocks back.

Use CONFIG_SERIAL_OMAP_CONSOLE macro check to take console_lock since
console ops are available only if omap console is defined.
omap-serial can be built as module without console support.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
 drivers/tty/serial/omap-serial.c              |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 28abc6b..de8de87 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -126,6 +126,7 @@ struct uart_omap_port {
 	u32			context_loss_cnt;
 	u8			wakeups_enabled;
 	u32			errata;
+	u8			console_locked;
 
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 64e4ab5..92a1f10 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1133,8 +1133,15 @@ static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+		if (up->port.line == up->port.cons->index &&
+				!is_console_locked())
+			up->console_locked = console_trylock();
+#endif
+	}
+
 	return 0;
 }
 
@@ -1142,8 +1149,17 @@ static int serial_omap_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_resume_port(&serial_omap_reg, &up->port);
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+		if (up->port.line == up->port.cons->index &&
+					up->console_locked) {
+			console_unlock();
+			up->console_locked = 0;
+		}
+#endif
+	}
+
 	return 0;
 }
 
-- 
1.7.4.1

