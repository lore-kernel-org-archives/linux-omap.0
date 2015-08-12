From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 5/6] ARM: OMAP: wakeupgen: fix arm gic irq type
 configuration
Date: Wed, 12 Aug 2015 20:46:01 +0300
Message-ID: <1439401562-28874-6-git-send-email-grygorii.strashko@ti.com>
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

It's observed that ARM GIC IRQ triggering type is not configured
properly when IRQ is routed through IRQ domain hierarchy and
system started using DT. As result, system will start using default
ARM GIC configuration, ignore DT IRQ triggering configuration,
and value of desc->irq_data.state_use_accessors = 0.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
ARM GIC <- OMAP wakeupgen <- TI CBAR

Failed call chain:
     irq_create_of_mapping
     irq_set_irq_type
     __irq_set_trigger
     if (!chip || !chip->irq_set_type) {
        return 0; <- return here
     }
OMAP wakeupgen has no .irq_set_type() defined and, so, IRQ triggering
configuration will not be propagated to parent IRQ domain.

Hence, fix it by using irq_chip_set_type_parent() for
propagation IRQ triggering type to parent IRQ domains.

Fixes: 7136d457f365 ('ARM: omap: convert wakeupgen to stacked domains')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 8e52621..e1d2e99 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -392,6 +392,7 @@ static struct irq_chip wakeupgen_chip = {
 	.irq_mask		= wakeupgen_mask,
 	.irq_unmask		= wakeupgen_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-- 
2.5.0
