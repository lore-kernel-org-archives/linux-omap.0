From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 6/6] irqchip: crossbar: fix irq masking at suspend
Date: Wed, 12 Aug 2015 20:46:02 +0300
Message-ID: <1439401562-28874-7-git-send-email-grygorii.strashko@ti.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, jason@lakedaemon.net, nsekhar@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

All ARM GIC IRQs have to masked during suspend if they are not
wakeup source. Now this is not happen, since switching to
use IRQ domain hierarchy, because suspend_device_irq() only checks flags
in the last IRQ chip in hierarchy for IRQCHIP_MASK_ON_SUSPEND
bit set. And in the case of TI OMAP DRA7 the last IRQ chip is TI Crossbar
which do not have this flag set.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
  ARM GIC <- OMAP wakeupgen <- TI CBAR
ARM GIC - IRQCHIP_MASK_ON_SUSPEND=n
OMAP wakeupgen - IRQCHIP_MASK_ON_SUSPEND=y
TI CBAR - IRQCHIP_MASK_ON_SUSPEND=n

Hence, fix by adding IRQCHIP_MASK_ON_SUSPEND for
TI Crossbar IRQ chip.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-crossbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 3ba58e7..f5a72cc 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -70,6 +70,7 @@ static struct irq_chip crossbar_chip = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= irq_chip_set_wake_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.5.0
