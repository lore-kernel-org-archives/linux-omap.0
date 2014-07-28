From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 22/35] arm: omap: irq: call set_handle_irq() from .init_irq
Date: Mon, 28 Jul 2014 16:16:10 -0500
Message-ID: <1406582183-696-23-git-send-email-balbi@ti.com>
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

the idea is that board-files won't need to set
.handle_irq on their machine_descs, which lets
us drop a little more pointless code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 587def4..994009c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -284,16 +284,19 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 void __init omap2_init_irq(void)
 {
 	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init omap3_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init ti81xx_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 static int __init intc_of_init(struct device_node *node,
-- 
2.0.1.563.g66f467c
