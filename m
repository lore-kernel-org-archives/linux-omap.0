From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 07/26] irqchip: clps711x: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:22 +0100
Message-ID: <1409047421-27649-8-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@lists.openrisc.net
Cc: mark.rutland@arm.com, tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jonas@southpole.se, lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, shc_work@mail.ru, khilman@linaro.org, jason@lakedaemon.net, marc.zyngier@arm.com, stefan.kristiansson@saunalahti.fi, larry.bassel@linaro.org, shawn.guo@freescale.com, baohua@kernel.org, sboyd@codeaurora.org, kernel@pengutronix.de, sudeep.holla@arm.com, schwidefsky@de.ibm.com, maxime.ripard@free-electrons.com, vkale@apm.com
List-Id: linux-omap@vger.kernel.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-clps711x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 33340dc..33127f1 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -76,24 +76,20 @@ static struct {
 
 static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
 {
-	u32 irqnr, irqstat;
+	u32 irqstat;
 
 	do {
 		irqstat = readw_relaxed(clps711x_intc->intmr[0]) &
 			  readw_relaxed(clps711x_intc->intsr[0]);
-		if (irqstat) {
-			irqnr =	irq_find_mapping(clps711x_intc->domain,
-						 fls(irqstat) - 1);
-			handle_IRQ(irqnr, regs);
-		}
+		if (irqstat)
+			handle_domain_irq(clps711x_intc->domain,
+					  fls(irqstat) - 1, regs);
 
 		irqstat = readw_relaxed(clps711x_intc->intmr[1]) &
 			  readw_relaxed(clps711x_intc->intsr[1]);
-		if (irqstat) {
-			irqnr =	irq_find_mapping(clps711x_intc->domain,
-						 fls(irqstat) - 1 + 16);
-			handle_IRQ(irqnr, regs);
-		}
+		if (irqstat)
+			handle_domain_irq(clps711x_intc->domain,
+					  fls(irqstat) - 1 + 16, regs);
 	} while (irqstat);
 }
 
-- 
2.0.4
