From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] irqchip/omap-intc: fix missing
 <linux/irqchip/irq-omap-intc.h> include
Date: Wed,  8 Jun 2016 18:44:32 +0100
Message-ID: <1465407872-10299-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@lists.codethink.co.uk
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Fix the missing include of <linux/irqchip/irq-omap-intc.h> which
declares all the missing functions from the following warnings:

drivers/irqchip/irq-omap-intc.c:84:6: warning: symbol 'omap_intc_save_context' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:105:6: warning: symbol 'omap_intc_restore_context' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:124:6: warning: symbol 'omap3_intc_prepare_idle' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:134:6: warning: symbol 'omap3_intc_resume_idle' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:173:5: warning: symbol 'omap_irq_pending' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:183:6: warning: symbol 'omap3_intc_suspend' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:365:13: warning: symbol 'omap3_init_irq' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---
 drivers/irqchip/irq-omap-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 9d1bcfc..b04a8ac 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -23,6 +23,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <linux/irqchip/irq-omap-intc.h>
+
 /* Define these here for now until we drop all board-files */
 #define OMAP24XX_IC_BASE	0x480fe000
 #define OMAP34XX_IC_BASE	0x48200000
-- 
2.8.1
