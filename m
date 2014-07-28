From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/35] arm: omap: irq: make omap_irq_base global
Date: Mon, 28 Jul 2014 16:15:49 -0500
Message-ID: <1406582183-696-2-git-send-email-balbi@ti.com>
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

This is in preparation for removing the pointless
irq_banks array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 35b8590..7b2cf9a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -68,6 +68,7 @@ static struct omap_irq_bank {
 };
 
 static struct irq_domain *domain;
+static void __iomem *omap_irq_base;
 
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
@@ -161,7 +162,6 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static void __init omap_init_irq(u32 base, int nr_irqs,
 				 struct device_node *node)
 {
-	void __iomem *omap_irq_base;
 	unsigned long nr_of_irqs = 0;
 	unsigned int nr_banks = 0;
 	int i, j, irq_base;
-- 
2.0.1.563.g66f467c
