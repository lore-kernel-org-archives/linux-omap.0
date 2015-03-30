From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] genirq: provide dummy set_irq_wake()
Date: Mon, 30 Mar 2015 16:15:45 +0300
Message-ID: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: cw00.choi@samsung.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Without this system suspend is broken on systems that have
drivers calling enable/disable_irq_wake() for interrupts based off
the dummy irq hook.
(e.g. drivers/gpio/gpio-pcf857x.c)

http://article.gmane.org/gmane.linux.kernel/1879035

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 kernel/irq/dummychip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 988dc58..2405d7a 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
 	return 0;
 }
 
+static int noop_int_ret(struct irq_data *data, unsigned int val)
+{
+	return 0;
+}
+
 /*
  * Generic no controller implementation
  */
@@ -57,5 +62,6 @@ struct irq_chip dummy_irq_chip = {
 	.irq_ack	= noop,
 	.irq_mask	= noop,
 	.irq_unmask	= noop,
+	.irq_set_wake	= noop_int_ret,
 };
 EXPORT_SYMBOL_GPL(dummy_irq_chip);
-- 
2.1.0
