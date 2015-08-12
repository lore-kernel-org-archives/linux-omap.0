From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/6] genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
Date: Wed, 12 Aug 2015 20:45:58 +0300
Message-ID: <1439401562-28874-3-git-send-email-grygorii.strashko@ti.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The irqchip_set_wake_parent should not fail if IRQ chip
specifies IRQCHIP_SKIP_SET_WAKE. Otherwise, IRQ wakeup
configuration can't be propagated properly through IRQ
domains hierarchy.

In case of TI OMAP DRA7 the issue reproduced with following
configuration:
ARM GIC<-OMAP wakeupgen<-TI CBAR<-GPIO<-GPIO pcf857x<-gpio_key

gpio_key is wakeup source

Failure is reproduced during suspend/resume to RAM:
suspend:
 - gpio_keys_suspend
   enable_irq_wake
     + pcf857x_irq_set_wake
       + omap_gpio_wake_enable
         + TI CBAR irq_chip_set_wake_parent
           + OMAP wakeupgen has no .irq_set_wake()
           and -ENOSYS will be returned

resume:
 - gpio_keys_resume
   + disable_irq_wake
     + irq_set_irq_wake
       + WARN(1, "Unbalanced IRQ %d wake disable\n", irq);

Fixes: 08b55e2a9208 ('genirq: Add irqchip_set_wake_parent')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 kernel/irq/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6de638b..bdb1b9d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1024,6 +1024,10 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 {
 	data = data->parent_data;
+
+	if (irq_data_get_irq_chip(data)->flags & IRQCHIP_SKIP_SET_WAKE)
+		return 0;
+
 	if (data->chip->irq_set_wake)
 		return data->chip->irq_set_wake(data, on);
 
-- 
2.5.0
