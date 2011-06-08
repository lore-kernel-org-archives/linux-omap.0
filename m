From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Wed, 8 Jun 2011 16:53:07 +0530
Message-ID: <1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Acquire console lock before enabling and writing to console-uart
to avoid any recursive prints from console write.
for ex:
        --> printk
          --> uart_console_write
            --> get_sync
              --> printk from omap_device enable
                --> uart_console write

Use RPM_SUSPENDING check to avoid below scenario during bootup
As during bootup console_lock is not available.
       --> uart_add_one_port
           --> console_register
               --> console_lock
                --> console_unlock
                     --> call_console_drivers (here yet console_lock is not released)
                          --> uart_console_write

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 897416f..ee94291 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1008,7 +1008,22 @@ serial_omap_console_write(struct console *co, const char *s,
 	struct uart_omap_port *up = serial_omap_console_ports[co->index];
 	unsigned long flags;
 	unsigned int ier;
-	int locked = 1;
+	int console_lock = 0, locked = 1;
+
+	if (console_trylock())
+		console_lock = 1;
+
+	/*
+	 * If console_lock is not available and we are in suspending
+	 * state then we can avoid the console usage scenario
+	 * as this may introduce recursive prints.
+	 * Basically this scenario occurs during boot while
+	 * printing debug bootlogs.
+	 */
+
+	if (!console_lock &&
+		up->pdev->dev.power.runtime_status == RPM_SUSPENDING)
+		return;
 
 	local_irq_save(flags);
 	if (up->port.sysrq)
@@ -1044,6 +1059,9 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->msr_saved_flags)
 		check_modem_status(up);
 
+	if (console_lock)
+		console_unlock();
+
 	serial_omap_port_disable(up);
 	if (locked)
 		spin_unlock(&up->port.lock);
-- 
1.7.0.4

