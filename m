From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 6/6] irqchip: crossbar: fix set_wake functionality
Date: Fri, 14 Aug 2015 15:20:30 +0300
Message-ID: <1439554830-19502-7-git-send-email-grygorii.strashko@ti.com>
References: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

The TI crossbar doesn't provides any facility to configure the wakeup
sources, but it implements .irq_set_wake() callback:
	.irq_set_wake		= irq_chip_set_wake_parent

As result, the irq_chip_set_wake_parent() will try to execute
.irq_set_wake() callback for parent IRQ domain, which is TI OMAP wakeupgen,
but TI OMAP wakeupgen has IRQCHIP_SKIP_SET_WAKE flag set and do not
implement .irq_set_wake() callback. Thus, irq_chip_set_wake_parent() will
fail with -ENOSYS.

In case of TI OMAP DRA7 the issue reproduced with following
configuration:
   ARM GIC<-OMAP wakeupgen<-TI CBAR<-GPIO<-GPIO pcf857x<-gpio_key

gpio_key is wakeup source

Failure is reproduced during suspend/resume to RAM:
 suspend:
  - gpio_keys_suspend
    + enable_irq_wake
      + pcf857x_irq_set_wake
        + omap_gpio_wake_enable
          + TI CBAR irq_chip_set_wake_parent
            + OMAP wakeupgen has no .irq_set_wake() and
              -ENOSYS will be returned

 resume:
  - gpio_keys_resume
    + disable_irq_wake
      + irq_set_irq_wake
         + WARN(1, "Unbalanced IRQ %d wake disable\n", irq);

Hence, fix it by adding IRQCHIP_SKIP_SET_WAKE flag to TI Crossbar and
drop .irq_set_wake() at the same time.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-crossbar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index f5a72cc..c12bb93 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -68,9 +68,9 @@ static struct irq_chip crossbar_chip = {
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_wake		= irq_chip_set_wake_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SKIP_SET_WAKE,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.5.0
