From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 18/26] irqchip: GICv3: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 11:03:33 +0100
Message-ID: <1409047421-27649-19-git-send-email-marc.zyngier@arm.com>
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
 drivers/irqchip/irq-gic-v3.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 57eaa5a..9e31449 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -274,14 +274,13 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		irqnr = gic_read_iar();
 
 		if (likely(irqnr > 15 && irqnr < 1020)) {
-			u64 irq = irq_find_mapping(gic_data.domain, irqnr);
-			if (likely(irq)) {
-				handle_IRQ(irq, regs);
-				continue;
+			int err;
+			err = handle_domain_irq(gic_data.domain, irqnr, regs);
+			if (err) {
+				WARN_ONCE(true, "Unexpected SPI received!\n");
+				gic_write_eoir(irqnr);
 			}
-
-			WARN_ONCE(true, "Unexpected SPI received!\n");
-			gic_write_eoir(irqnr);
+			continue;
 		}
 		if (irqnr < 16) {
 			gic_write_eoir(irqnr);
-- 
2.0.4
