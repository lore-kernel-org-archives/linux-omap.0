From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 6/7] ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
Date: Wed, 30 Oct 2013 20:27:19 +0530
Message-ID: <1383145040-15852-7-git-send-email-r.sricharan@ti.com>
References: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383145040-15852-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, santosh.shilimkar@ti.com, r.sricharan@ti.com
List-Id: linux-omap@vger.kernel.org

The wakeup gen mask/unmask callback uses the irq element of the
irq_data to setup. The irq is the linux virtual irq number and
is same as the hardware irq number only when the parent irqchip
is setup as a legacy domain. When it is used as a linear domain,
the virtual irqs are allocated dynamically and wakeup gen code
cannot rely on these numbers to access the irq registers. Instead
use the hwirq element of the irq_data which represent the physical
irq number.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index e3274bb..c9a5b3c 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -137,7 +137,7 @@ static void wakeupgen_mask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
-	_wakeupgen_clear(d->irq, irq_target_cpu[d->irq]);
+	_wakeupgen_clear(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
@@ -149,7 +149,7 @@ static void wakeupgen_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
-	_wakeupgen_set(d->irq, irq_target_cpu[d->irq]);
+	_wakeupgen_set(d->hwirq, irq_target_cpu[d->hwirq]);
 	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
-- 
1.7.9.5
