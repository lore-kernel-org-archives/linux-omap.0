From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 6/7] OMAP1: mailbox: adapt to dynamic mailbox requests
Date: Fri, 24 Jun 2011 20:17:42 -0500
Message-ID: <1308964663-5669-7-git-send-email-omar.ramirez@ti.com>
References: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1308964663-5669-1-git-send-email-omar.ramirez@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Remove mailbox static declarations, while at it, simplify the macros
to be reused in a cleaner way.

New approach configures available mailboxes per request.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap1/mailbox.c |   92 ++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 2845652..f3a40de 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -9,20 +9,23 @@
  * for more details.
  */
 
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 #include <plat/mailbox.h>
 
-#define MAILBOX_ARM2DSP1		0x00
-#define MAILBOX_ARM2DSP1b		0x04
-#define MAILBOX_DSP2ARM1		0x08
-#define MAILBOX_DSP2ARM1b		0x0c
-#define MAILBOX_DSP2ARM2		0x10
-#define MAILBOX_DSP2ARM2b		0x14
-#define MAILBOX_ARM2DSP1_Flag		0x18
-#define MAILBOX_DSP2ARM1_Flag		0x1c
-#define MAILBOX_DSP2ARM2_Flag		0x20
+#define MAILBOX_ARM2DSPm(m)		(0x24 * (m - 1))
+#define MAILBOX_DSP2ARMm(m)		(0x08 + 0x8 * (m - 1))
+#define MAILBOX_ARM2DSPmb(m)		(0x04 + 0x24 * (m - 1))
+#define MAILBOX_DSP2ARMmb(m)		(0x0c + 0x8 * (m - 1))
+#define MAILBOX_ARM2DSPm_Flag(m)	(0x18 + 0x14 * (m - 1))
+#define MAILBOX_DSP2ARMm_Flag(m)	(0x1c + 0x4 * (m - 1))
+
+static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
+module_param(mbox_kfifo_size, uint, S_IRUGO);
+MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
 
 static void __iomem *mbox_base;
 
@@ -106,6 +109,32 @@ omap1_mbox_is_irq(struct omap_mbox *mbox, omap_mbox_type_t irq)
 	return 1;
 }
 
+struct device *mbox_dev;
+
+static void *omap1_mbox_request(u16 id, u16 owner)
+{
+	struct omap_mbox1_priv *p;
+
+	p = kzalloc(sizeof(struct omap_mbox1_priv), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->tx_fifo.cmd	= MAILBOX_ARM2DSPmb(id);
+	p->tx_fifo.data	= MAILBOX_ARM2DSPm(id);
+	p->tx_fifo.flag	= MAILBOX_ARM2DSPm_Flag(id);
+	p->rx_fifo.cmd	= MAILBOX_DSP2ARMmb(id);
+	p->rx_fifo.data	= MAILBOX_DSP2ARMm(id);
+	p->rx_fifo.flag	= MAILBOX_DSP2ARMm_Flag(id);
+
+	return mbox;
+}
+
+static void omap1_mbox_release(void *priv)
+{
+	kfree(priv);
+	priv = NULL;
+}
+
 static struct omap_mbox_ops omap1_mbox_ops = {
 	.type		= OMAP_MBOX_TYPE1,
 	.fifo_read	= omap1_mbox_fifo_read,
@@ -115,48 +144,35 @@ static struct omap_mbox_ops omap1_mbox_ops = {
 	.enable_irq	= omap1_mbox_enable_irq,
 	.disable_irq	= omap1_mbox_disable_irq,
 	.is_irq		= omap1_mbox_is_irq,
+	.request	= omap1_mbox_request,
+	.release	= omap1_mbox_release,
 };
 
-/* FIXME: the following struct should be created automatically by the user id */
-
-/* DSP */
-static struct omap_mbox1_priv omap1_mbox_dsp_priv = {
-	.tx_fifo = {
-		.cmd	= MAILBOX_ARM2DSP1b,
-		.data	= MAILBOX_ARM2DSP1,
-		.flag	= MAILBOX_ARM2DSP1_Flag,
-	},
-	.rx_fifo = {
-		.cmd	= MAILBOX_DSP2ARM1b,
-		.data	= MAILBOX_DSP2ARM1,
-		.flag	= MAILBOX_DSP2ARM1_Flag,
-	},
-};
-
-static struct omap_mbox mbox_dsp_info = {
-	.name	= "dsp",
-	.ops	= &omap1_mbox_ops,
-	.priv	= &omap1_mbox_dsp_priv,
-};
-
-static struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
-
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
+	struct mbox_info *arch_mbi;
 	int ret;
-	struct omap_mbox **list;
-
-	list = omap1_mboxes;
-	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mbox_base = ioremap(mem->start, resource_size(mem));
 	if (!mbox_base)
 		return -ENOMEM;
 
-	ret = omap_mbox_register(&pdev->dev, list);
+	arch_mbi = kzalloc(sizeof(struct mbox_info), GFP_KERNEL);
+	if (!arch_mbi) {
+		iounmap(mbox_base);
+		return -ENOMEM;
+	}
+
+	arch_mbi->dev = &pdev->dev;
+	arch_mbi->ops = &omap1_mbox_ops;
+	arch_mbi->kfifo_size = mbox_kfifo_size;
+	arch_mbi->nr_mbox = 2;
+
+	ret = omap_mbox_register(arch_mbi);
 	if (ret) {
+		kfree(arch_mbi);
 		iounmap(mbox_base);
 		return ret;
 	}
-- 
1.7.0.4
