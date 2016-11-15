From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 2/5] mfd: tps65217: Specify the IRQ name
Date: Tue, 15 Nov 2016 22:02:12 +0900
Message-ID: <20161115130215.3301-3-woogyom.kim@gmail.com>
References: <20161115130215.3301-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115130215.3301-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

TPS65217 MFD is an interrupt controller and MFD slave devices like
tps65217-charger and tps65217-pwrbutton request an interrupt to handle
each HW event.

Currently, TPS65217 IRQ name is not defined, so the result is as below.

root@arm:~# cat /proc/interrupts
...
182:          0      INTC   7 Level     tps65217-irq
183:          0         -   1 Edge      tps65217-charger
185:          0         -   2 Edge      tps65217_pwrbutton

This patch specifies the name of the interrupt controller.

182:          0      INTC   7 Level     tps65217-irq
183:          0  tps65217   1 Edge      tps65217-charger
185:          0  tps65217   2 Edge      tps65217_pwrbutton

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/mfd/tps65217.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index df2e775..77fb812 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -105,6 +105,7 @@ static void tps65217_irq_disable(struct irq_data *data)
 }
 
 static struct irq_chip tps65217_irq_chip = {
+	.name			= "tps65217",
 	.irq_bus_lock		= tps65217_irq_lock,
 	.irq_bus_sync_unlock	= tps65217_irq_sync_unlock,
 	.irq_enable		= tps65217_irq_enable,
-- 
2.9.3
