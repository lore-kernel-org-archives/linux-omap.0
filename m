From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip
Date: Wed, 15 Apr 2015 11:14:11 +0300
Message-ID: <552E1DD3.4040106@ti.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: cw00.choi@samsung.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Without this system suspend is broken on systems that have
drivers calling enable/disable_irq_wake() for interrupts based off
the dummy irq hook.
(e.g. drivers/gpio/gpio-pcf857x.c)

http://article.gmane.org/gmane.linux.kernel/1879035

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 kernel/irq/dummychip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 988dc58..2feb6fe 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -57,5 +57,6 @@ struct irq_chip dummy_irq_chip = {
 	.irq_ack	= noop,
 	.irq_mask	= noop,
 	.irq_unmask	= noop,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 EXPORT_SYMBOL_GPL(dummy_irq_chip);
-- 
2.1.0
