From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 12/26] irqchip: sirfsoc: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:27 +0100
Message-ID: <1409047421-27649-13-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-sirfsoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 5e54f6d..a469355 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -50,12 +50,10 @@ sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
 {
 	void __iomem *base = sirfsoc_irqdomain->host_data;
-	u32 irqstat, irqnr;
+	u32 irqstat;
 
 	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
-	irqnr = irq_find_mapping(sirfsoc_irqdomain, irqstat & 0xff);
-
-	handle_IRQ(irqnr, regs);
+	handle_domain_irq(sirfsoc_irqdomain, irqstat & 0xff, regs);
 }
 
 static int __init sirfsoc_irq_init(struct device_node *np,
-- 
2.0.4
