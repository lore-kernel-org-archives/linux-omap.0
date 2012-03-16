From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 06/12] gpio/omap: fix trigger type to unsigned
Date: Fri, 16 Mar 2012 19:35:54 +0530
Message-ID: <1331906760-5259-7-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964942Ab2CPOGX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 10:06:23 -0400
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The GPIO trigger parameter is of type unsigned.
enum {
        IRQ_TYPE_NONE           = 0x00000000,
        IRQ_TYPE_EDGE_RISING    = 0x00000001,
        IRQ_TYPE_EDGE_FALLING   = 0x00000002,
        IRQ_TYPE_EDGE_BOTH      = (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING),
        IRQ_TYPE_LEVEL_HIGH     = 0x00000004,
        IRQ_TYPE_LEVEL_LOW      = 0x00000008,
        IRQ_TYPE_LEVEL_MASK     = (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
        IRQ_TYPE_SENSE_MASK     = 0x0000000f,

        IRQ_TYPE_PROBE          = 0x00000010,
...
};
Even though gpio_irq_type(struct irq_data *d, unsigned type) has the right type
of parameter, the subsequent called functions set_gpio_triggering() and
set_gpio_trigger() wrongly makes it signed integer. Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 47143b7..4d23da1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -241,7 +241,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 }
 
 static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
-						int trigger)
+						unsigned trigger)
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
@@ -323,7 +323,8 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
 #endif
 
-static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
+static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
+							unsigned trigger)
 {
 	void __iomem *reg = bank->base;
 	void __iomem *base = bank->base;
-- 
1.7.0.4

