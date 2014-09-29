From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/13] tty: serial: 8250: Fix wording in runtime-PM comments
Date: Mon, 29 Sep 2014 20:06:37 +0200
Message-ID: <1412014009-13315-2-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: tony@atomide.com, gregkh@linuxfoundation.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Frans reworded the two comments with better English for better
understanding. His review hit the mailing list after the patch got
applied so here is an incremental update.

Reported-by: Frans Klaver <frans.klaver@xsens.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 139f3d2b8aa9..a1904628a2a1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -557,7 +557,7 @@ static void serial8250_rpm_put(struct uart_8250_port *p)
 }
 
 /*
- * This two wrapper ensure, that enable_runtime_pm_tx() can be called more than
+ * These two wrappers ensure that enable_runtime_pm_tx() can be called more than
  * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
  * empty and the HW can idle again.
  */
@@ -1532,7 +1532,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	DEBUG_INTR("THRE...");
 
 	/*
-	 * With RPM enabled, we have to wait once the FIFO is empty before the
+	 * With RPM enabled, we have to wait until the FIFO is empty before the
 	 * HW can go idle. So we get here once again with empty FIFO and disable
 	 * the interrupt and RPM in __stop_tx()
 	 */
-- 
2.1.0
