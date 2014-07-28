From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/35] arm: omap: irq: add a global omap_nr_irqs variable
Date: Mon, 28 Jul 2014 16:15:52 -0500
Message-ID: <1406582183-696-5-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, jason@lakedaemon.net, khilman@deeprootsystems.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, bcousson@baylibre.com, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

this will cache number of irqs. Also in preparation
for removal of irq_banks array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 83163d0..3870853 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -70,6 +70,7 @@ static struct omap_irq_bank {
 
 static struct irq_domain *domain;
 static void __iomem *omap_irq_base;
+static int omap_nr_irqs = 96;
 
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
@@ -170,6 +171,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 	if (WARN_ON(!omap_irq_base))
 		return;
 
+	omap_nr_irqs = nr_irqs;
+
 	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
-- 
2.0.1.563.g66f467c
