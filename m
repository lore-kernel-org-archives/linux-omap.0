From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 7/7] OMAP2+: mailbox: remove mailbox static declarations
Date: Fri, 24 Jun 2011 20:17:43 -0500
Message-ID: <1308964663-5669-8-git-send-email-omar.ramirez@ti.com>
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

Remove mailbox static declarations which limit the driver to
either work with 1 or 2 predefined mailboxes, even if there are
more mailboxes in hardware.

New approach configures available mailboxes per request.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |  210 +++++++++++------------------------------
 1 files changed, 54 insertions(+), 156 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 946a70a..b85e33b 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
@@ -39,6 +40,10 @@
 #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
 #define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
+static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
+module_param(mbox_kfifo_size, uint, S_IRUGO);
+MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
+
 static void __iomem *mbox_base;
 
 struct omap_mbox2_fifo {
@@ -58,9 +63,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
-				  omap_mbox_type_t irq);
-
 static inline unsigned int mbox_read_reg(size_t ofs)
 {
 	return __raw_readl(mbox_base + ofs);
@@ -76,21 +78,19 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 {
 	u32 l;
 
-	pm_runtime_enable(mbox->dev->parent);
-	pm_runtime_get_sync(mbox->dev->parent);
+	pm_runtime_enable(mbox->dev);
+	pm_runtime_get_sync(mbox->dev);
 
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	omap2_mbox_enable_irq(mbox, IRQ_RX);
-
 	return 0;
 }
 
 static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
-	pm_runtime_put_sync(mbox->dev->parent);
-	pm_runtime_disable(mbox->dev->parent);
+	pm_runtime_put_sync(mbox->dev);
+	pm_runtime_disable(mbox->dev);
 }
 
 /* Mailbox FIFO handle functions */
@@ -203,6 +203,33 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
 	}
 }
 
+static void *omap2_mbox_request(u16 id, u16 owner)
+{
+	struct omap_mbox2_priv *p;
+
+	p = kzalloc(sizeof(struct omap_mbox2_priv), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->tx_fifo.msg = MAILBOX_MESSAGE(id);
+	p->tx_fifo.fifo_stat = MAILBOX_FIFOSTATUS(id);
+	p->notfull_bit = MAILBOX_IRQ_NOTFULL(id);
+	p->rx_fifo.msg = MAILBOX_MESSAGE(id);
+	p->rx_fifo.msg_stat = MAILBOX_MSGSTATUS(id);
+	p->newmsg_bit = MAILBOX_IRQ_NEWMSG(id);
+	p->irqenable = MAILBOX_IRQENABLE(owner);
+	p->irqstatus = MAILBOX_IRQSTATUS(owner);
+	p->irqdisable = MAILBOX_IRQENABLE(owner);
+
+	return p;
+}
+
+static void omap2_mbox_release(void *priv)
+{
+	kfree(priv);
+	priv = NULL;
+}
+
 static struct omap_mbox_ops omap2_mbox_ops = {
 	.type		= OMAP_MBOX_TYPE2,
 	.startup	= omap2_mbox_startup,
@@ -217,168 +244,39 @@ static struct omap_mbox_ops omap2_mbox_ops = {
 	.is_irq		= omap2_mbox_is_irq,
 	.save_ctx	= omap2_mbox_save_ctx,
 	.restore_ctx	= omap2_mbox_restore_ctx,
+	.request	= omap2_mbox_request,
+	.release	= omap2_mbox_release,
 };
 
-/*
- * MAILBOX 0: ARM -> DSP,
- * MAILBOX 1: ARM <- DSP.
- * MAILBOX 2: ARM -> IVA,
- * MAILBOX 3: ARM <- IVA.
- */
-
-/* FIXME: the following structs should be filled automatically by the user id */
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP2)
-/* DSP */
-static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
-	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE(0),
-		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
-	},
-	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE(1),
-		.msg_stat	= MAILBOX_MSGSTATUS(1),
-	},
-	.irqenable	= MAILBOX_IRQENABLE(0),
-	.irqstatus	= MAILBOX_IRQSTATUS(0),
-	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
-	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
-	.irqdisable	= MAILBOX_IRQENABLE(0),
-};
-
-struct omap_mbox mbox_dsp_info = {
-	.name	= "dsp",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_dsp_priv,
-};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3)
-struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
-#endif
-
-#if defined(CONFIG_SOC_OMAP2420)
-/* IVA */
-static struct omap_mbox2_priv omap2_mbox_iva_priv = {
-	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE(2),
-		.fifo_stat	= MAILBOX_FIFOSTATUS(2),
-	},
-	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE(3),
-		.msg_stat	= MAILBOX_MSGSTATUS(3),
-	},
-	.irqenable	= MAILBOX_IRQENABLE(3),
-	.irqstatus	= MAILBOX_IRQSTATUS(3),
-	.notfull_bit	= MAILBOX_IRQ_NOTFULL(2),
-	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(3),
-	.irqdisable	= MAILBOX_IRQENABLE(3),
-};
-
-static struct omap_mbox mbox_iva_info = {
-	.name	= "iva",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_iva_priv,
-};
-
-struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4)
-/* OMAP4 */
-static struct omap_mbox2_priv omap2_mbox_1_priv = {
-	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE(0),
-		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
-	},
-	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE(1),
-		.msg_stat	= MAILBOX_MSGSTATUS(1),
-	},
-	.irqenable	= OMAP4_MAILBOX_IRQENABLE(0),
-	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(0),
-	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
-	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
-	.irqdisable	= OMAP4_MAILBOX_IRQENABLE_CLR(0),
-};
-
-struct omap_mbox mbox_1_info = {
-	.name	= "mailbox-1",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_1_priv,
-};
-
-static struct omap_mbox2_priv omap2_mbox_2_priv = {
-	.tx_fifo = {
-		.msg		= MAILBOX_MESSAGE(3),
-		.fifo_stat	= MAILBOX_FIFOSTATUS(3),
-	},
-	.rx_fifo = {
-		.msg		= MAILBOX_MESSAGE(2),
-		.msg_stat	= MAILBOX_MSGSTATUS(2),
-	},
-	.irqenable	= OMAP4_MAILBOX_IRQENABLE(0),
-	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(0),
-	.notfull_bit	= MAILBOX_IRQ_NOTFULL(3),
-	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(2),
-	.irqdisable     = OMAP4_MAILBOX_IRQENABLE_CLR(0),
-};
-
-struct omap_mbox mbox_2_info = {
-	.name	= "mailbox-2",
-	.ops	= &omap2_mbox_ops,
-	.priv	= &omap2_mbox_2_priv,
-};
-
-struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
-#endif
-
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
+	struct mbox_info *arch_mbi;
+	struct omap_mailbox_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
-	struct omap_mbox **list;
 
-	if (false)
-		;
-#if defined(CONFIG_ARCH_OMAP3)
-	else if (cpu_is_omap34xx()) {
-		list = omap3_mboxes;
-
-		list[0]->irq = platform_get_irq(pdev, 0);
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP2)
-	else if (cpu_is_omap2430()) {
-		list = omap2_mboxes;
-
-		list[0]->irq = platform_get_irq(pdev, 0);
-	} else if (cpu_is_omap2420()) {
-		list = omap2_mboxes;
-
-		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
-		list[1]->irq = platform_get_irq_byname(pdev, "iva");
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	else if (cpu_is_omap44xx()) {
-		list = omap4_mboxes;
-
-		list[0]->irq = list[1]->irq = platform_get_irq(pdev, 0);
-	}
-#endif
-	else {
-		pr_err("%s: platform not supported\n", __func__);
+	if (!pdata)
 		return -ENODEV;
-	}
 
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
+	arch_mbi->ops = &omap2_mbox_ops;
+	arch_mbi->kfifo_size = mbox_kfifo_size;
+	arch_mbi->nr_mbox = pdata->nr_mbox;
+
+	ret = omap_mbox_register(arch_mbi);
 	if (ret) {
+		kfree(arch_mbi);
 		iounmap(mbox_base);
 		return ret;
 	}
-- 
1.7.0.4
