From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes to
 support OMAP4 mailbox.
Date: Tue, 17 Nov 2009 20:21:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE563EB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39916 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbZKQOut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 09:50:49 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

Hi Tony,
Following is the version 2 of Patch 8/10 (removing all #fidefs)

Regards
Subbu
 
>From 775dde65217785f519efe2a202489a791460f861 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Fri, 13 Nov 2009 16:42:40 +0530
Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.

This patch adds code changes in the mailbox driver module to
add support for OMAP4 mailbox.
Removed #ifdef CONFIG_ARCH_OMAP4

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |  140 ++++++++++++++++++++++++++++++++++-------
 arch/arm/plat-omap/mailbox.c  |   25 ++++++--
 2 files changed, 136 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 5ba3aa6..d20550f 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -18,6 +18,8 @@
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
+#define DRV_NAME "omap2-mailbox"
+
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
 #define MAILBOX_SYSSTATUS		0x014
@@ -27,8 +29,12 @@
 #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
 #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
 
-#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
-#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
+#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
+#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
+#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
+
+#define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
+#define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
 
 /* SYSCONFIG: register bit definition */
 #define AUTOIDLE	(1 << 0)
@@ -39,7 +45,11 @@
 #define RESETDONE	(1 << 0)
 
 #define MBOX_REG_SIZE			0x120
+
+#define OMAP4_MBOX_REG_SIZE		0x130
+
 #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
+#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))
 
 static void __iomem *mbox_base;
 
@@ -56,7 +66,8 @@ struct omap_mbox2_priv {
 	unsigned long irqstatus;
 	u32 newmsg_bit;
 	u32 notfull_bit;
-	u32 ctx[MBOX_NR_REGS];
+	u32 ctx[OMAP4_MBOX_REG_SIZE];
+	unsigned long irqdisable;
 };
 
 static struct clk *mbox_ick_handle;
@@ -82,8 +93,9 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 
 	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
 	if (IS_ERR(mbox_ick_handle)) {
-		pr_err("Can't get mailboxes_ick\n");
-		return -ENODEV;
+		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
+			PTR_ERR(mbox_ick_handle));
+		return PTR_ERR(mbox_ick_handle);
 	}
 	clk_enable(mbox_ick_handle);
 
@@ -115,6 +127,7 @@ static void omap2_mbox_shutdown(struct omap_mbox *mbox)
 {
 	clk_disable(mbox_ick_handle);
 	clk_put(mbox_ick_handle);
+	mbox_ick_handle = NULL;
 }
 
 /* Mailbox FIFO handle functions */
@@ -143,7 +156,7 @@ static int omap2_mbox_fifo_full(struct omap_mbox *mbox)
 {
 	struct omap_mbox2_fifo *fifo =
 		&((struct omap_mbox2_priv *)mbox->priv)->tx_fifo;
-	return (mbox_read_reg(fifo->fifo_stat));
+	return mbox_read_reg(fifo->fifo_stat);
 }
 
 /* Mailbox IRQ handle functions */
@@ -163,10 +176,9 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 {
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
-
-	l = mbox_read_reg(p->irqenable);
+	l = mbox_read_reg(p->irqdisable);
 	l &= ~bit;
-	mbox_write_reg(l, p->irqenable);
+	mbox_write_reg(l, p->irqdisable);
 }
 
 static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
@@ -189,15 +201,19 @@ static int omap2_mbox_is_irq(struct omap_mbox *mbox,
 	u32 enable = mbox_read_reg(p->irqenable);
 	u32 status = mbox_read_reg(p->irqstatus);
 
-	return (enable & status & bit);
+	return (int)(enable & status & bit);
 }
 
 static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
 {
 	int i;
 	struct omap_mbox2_priv *p = mbox->priv;
-
-	for (i = 0; i < MBOX_NR_REGS; i++) {
+	int nr_regs;
+	if (cpu_is_omap44xx())
+		nr_regs = OMAP4_MBOX_NR_REGS;
+	else
+		nr_regs = MBOX_NR_REGS;
+	for (i = 0; i < nr_regs; i++) {
 		p->ctx[i] = mbox_read_reg(i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
@@ -209,8 +225,12 @@ static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
 {
 	int i;
 	struct omap_mbox2_priv *p = mbox->priv;
-
-	for (i = 0; i < MBOX_NR_REGS; i++) {
+	int nr_regs;
+	if (cpu_is_omap44xx())
+		nr_regs = OMAP4_MBOX_NR_REGS;
+	else
+		nr_regs = MBOX_NR_REGS;
+	for (i = 0; i < nr_regs; i++) {
 		mbox_write_reg(p->ctx[i], i * sizeof(u32));
 
 		dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
@@ -242,7 +262,6 @@ static struct omap_mbox_ops omap2_mbox_ops = {
  */
 
 /* FIXME: the following structs should be filled automatically by the user id */
-
 /* DSP */
 static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.tx_fifo = {
@@ -257,8 +276,36 @@ static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
 	.irqstatus	= MAILBOX_IRQSTATUS(0),
 	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
 	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
+	.irqdisable	= MAILBOX_IRQENABLE(0),
+};
+
+
+
+/* OMAP4 specific data structure. Use the cpu_is_omap4xxx()
+to use this*/
+static struct omap_mbox2_priv omap2_mbox_1_priv = {
+	.tx_fifo = {
+		.msg		= MAILBOX_MESSAGE(0),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
+	},
+	.rx_fifo = {
+		.msg		= MAILBOX_MESSAGE(1),
+		.msg_stat	= MAILBOX_MSGSTATUS(1),
+	},
+	.irqenable	= OMAP4_MAILBOX_IRQENABLE(0),
+	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(0),
+	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
+	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(1),
+	.irqdisable	= OMAP4_MAILBOX_IRQENABLE_CLR(0),
 };
 
+struct omap_mbox mbox_1_info = {
+	.name	= "mailbox-1",
+	.ops	= &omap2_mbox_ops,
+	.priv	= &omap2_mbox_1_priv,
+};
+EXPORT_SYMBOL(mbox_1_info);
+
 struct omap_mbox mbox_dsp_info = {
 	.name	= "dsp",
 	.ops	= &omap2_mbox_ops,
@@ -266,6 +313,30 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
+static struct omap_mbox2_priv omap2_mbox_2_priv = {
+	.tx_fifo = {
+		.msg		= MAILBOX_MESSAGE(3),
+		.fifo_stat	= MAILBOX_FIFOSTATUS(3),
+	},
+	.rx_fifo = {
+		.msg		= MAILBOX_MESSAGE(2),
+		.msg_stat	= MAILBOX_MSGSTATUS(2),
+	},
+	.irqenable	= OMAP4_MAILBOX_IRQENABLE(0),
+	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(0),
+	.notfull_bit	= MAILBOX_IRQ_NOTFULL(3),
+	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(2),
+	.irqdisable     = OMAP4_MAILBOX_IRQENABLE_CLR(0),
+};
+
+struct omap_mbox mbox_2_info = {
+	.name	= "mailbox-2",
+	.ops	= &omap2_mbox_ops,
+	.priv	= &omap2_mbox_2_priv,
+};
+EXPORT_SYMBOL(mbox_2_info);
+
+
 #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -280,6 +351,7 @@ static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.irqstatus	= MAILBOX_IRQSTATUS(3),
 	.notfull_bit	= MAILBOX_IRQ_NOTFULL(2),
 	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(3),
+	.irqdisable	= MAILBOX_IRQENABLE(3),
 };
 
 static struct omap_mbox mbox_iva_info = {
@@ -305,17 +377,31 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* DSP or IVA2 IRQ */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+
+	if (unlikely(!res)) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
+		ret = -ENODEV;
 		goto err_dsp;
 	}
-	mbox_dsp_info.irq = ret;
-
-	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	if (cpu_is_omap44xx()) {
+		mbox_1_info.irq = res->start;
+		ret = omap_mbox_register(&pdev->dev, &mbox_1_info);
+	} else {
+		mbox_dsp_info.irq = res->start;
+		ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	}
 	if (ret)
 		goto err_dsp;
 
+	if (cpu_is_omap44xx()) {
+		mbox_2_info.irq = res->start;
+		ret = omap_mbox_register(&pdev->dev, &mbox_2_info);
+		if (ret) {
+			omap_mbox_unregister(&mbox_1_info);
+			goto err_dsp;
+		}
+	}
 #if defined(CONFIG_ARCH_OMAP2420) /* IVA */
 	if (cpu_is_omap2420()) {
 		/* IVA IRQ */
@@ -335,6 +421,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 
 err_iva1:
 	omap_mbox_unregister(&mbox_dsp_info);
+
 err_dsp:
 	iounmap(mbox_base);
 	return ret;
@@ -345,7 +432,12 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 #if defined(CONFIG_ARCH_OMAP2420)
 	omap_mbox_unregister(&mbox_iva_info);
 #endif
-	omap_mbox_unregister(&mbox_dsp_info);
+
+	if (cpu_is_omap44xx()) {
+		omap_mbox_unregister(&mbox_2_info);
+		omap_mbox_unregister(&mbox_1_info);
+	} else
+		omap_mbox_unregister(&mbox_dsp_info);
 	iounmap(mbox_base);
 	return 0;
 }
@@ -354,7 +446,7 @@ static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
 	.remove = __devexit_p(omap2_mbox_remove),
 	.driver = {
-		.name = "omap2-mailbox",
+		.name = DRV_NAME,
 	},
 };
 
@@ -372,6 +464,6 @@ module_init(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("omap mailbox: omap2/3 architecture specific functions");
+MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
-MODULE_ALIAS("platform:omap2-mailbox");
+MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d5377a3..4d7947e 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -31,6 +31,8 @@
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
+static int mbox_configured;
+
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
@@ -266,13 +268,20 @@ static void mbox_queue_free(struct omap_mbox_queue *q)
 
 static int omap_mbox_startup(struct omap_mbox *mbox)
 {
-	int ret;
+	int ret = 0;
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		ret = mbox->ops->startup(mbox);
-		if (unlikely(ret))
+		write_lock(&mboxes_lock);
+		if (!mbox_configured)
+			ret = mbox->ops->startup(mbox);
+
+		if (unlikely(ret)) {
+			write_unlock(&mboxes_lock);
 			return ret;
+		}
+		mbox_configured++;
+		write_unlock(&mboxes_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -317,8 +326,14 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 
 	free_irq(mbox->irq, mbox);
 
-	if (unlikely(mbox->ops->shutdown))
-		mbox->ops->shutdown(mbox);
+	if (unlikely(mbox->ops->shutdown)) {
+		write_lock(&mboxes_lock);
+		if (mbox_configured > 0)
+			mbox_configured--;
+		if (!mbox_configured)
+			mbox->ops->shutdown(mbox);
+		write_unlock(&mboxes_lock);
+	}
 }
 
 static struct omap_mbox **find_mboxes(const char *name)
-- 
1.5.3.2
