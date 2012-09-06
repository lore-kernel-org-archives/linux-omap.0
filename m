From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v4 14/21] serial: omap: drop "inline" from IRQ handler prototype
Date: Thu,  6 Sep 2012 15:45:33 +0300
Message-ID: <1346935540-1792-15-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

it makes no sense to mark our IRQ handler inline
since it's passed as a function pointer when
enabling the IRQ line.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9068260..d244163 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -345,7 +345,7 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
  * @irq: uart port irq number
  * @dev_id: uart port info
  */
-static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
+static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 {
 	struct uart_omap_port *up = dev_id;
 	struct tty_struct *tty = up->port.state->port.tty;
-- 
1.7.12.rc3
