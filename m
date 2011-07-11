From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 13/22] cbus: tahvo: start using irq_chip
Date: Mon, 11 Jul 2011 14:17:26 +0300
Message-ID: <1310383055-20211-14-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39837 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755067Ab1GKLSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:53 -0400
Received: by gxk27 with SMTP id 27so2077327gxk.15
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:50 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

in order to chieve that, we needed to allocate
our children devices (currently only one) and
fix up the irq handler.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    6 --
 arch/arm/mach-omap2/board-n8x0.c     |    6 --
 drivers/cbus/tahvo.c                 |  110 ++++++++++++++++++++++++---------
 3 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 5eb1a7f..ecdf77b 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -155,11 +155,6 @@ static struct platform_device tahvo_device = {
 	},
 };
 
-static struct platform_device tahvo_usb_device = {
-	.name		= "tahvo-usb",
-	.id		= -1,
-};
-
 static void __init nokia770_cbus_init(void)
 {
 	int		ret;
@@ -200,7 +195,6 @@ static void __init nokia770_cbus_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(40);
 	platform_device_register(&tahvo_device);
-	platform_device_register(&tahvo_usb_device);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index f7548e4..295b4d7 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -251,11 +251,6 @@ static struct platform_device tahvo_device = {
 	},
 };
 
-static struct platform_device tahvo_usb_device = {
-	.name		= "tahvo-usb",
-	.id		= -1,
-};
-
 static void __init n8x0_cbus_init(void)
 {
 	int		ret;
@@ -297,7 +292,6 @@ static void __init n8x0_cbus_init(void)
 
 	tahvo_resource[0].start = gpio_to_irq(111);
 	platform_device_register(&tahvo_device);
-	platform_device_register(&tahvo_usb_device);
 }
 
 #else
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 3aaf0eb..f01defc 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -215,39 +215,26 @@ EXPORT_SYMBOL(tahvo_set_backlight_level);
 
 static irqreturn_t tahvo_irq_handler(int irq, void *_tahvo)
 {
-	struct tahvo_irq_handler_desc *hnd;
-
 	struct tahvo		*tahvo = _tahvo;
 	u16			id;
 	u16			im;
-	int			i;
-
-	for (;;) {
-		id = __tahvo_read_reg(tahvo, TAHVO_REG_IDR);
-		im = ~__tahvo_read_reg(tahvo, TAHVO_REG_IMR);
-		id &= im;
-
-		if (!id)
-			break;
-
-		for (i = 0; id != 0; i++, id >>= 1) {
-			if (!(id & 1))
-				continue;
-			hnd = &tahvo_irq_handlers[i];
-			if (hnd->func == NULL) {
-				/* Spurious tahvo interrupt - just ack it */
-				dev_err(tahvo->dev, "Spurious interrupt "
-						 "(id %d)\n", i);
-				tahvo_disable_irq(i);
-				tahvo_ack_irq(i);
-				continue;
-			}
-			hnd->func(hnd->arg);
-			/*
-			 * Don't acknowledge the interrupt here
-			 * It must be done explicitly
-			 */
-		}
+
+	id = __tahvo_read_reg(tahvo, TAHVO_REG_IDR);
+	im = __tahvo_read_reg(tahvo, TAHVO_REG_IMR);
+	id &= ~im;
+
+	if (!id) {
+		dev_vdbg(tahvo->dev, "No IRQ, spurious ?\n");
+		return IRQ_NONE;
+	}
+
+	while (id) {
+		unsigned long	pending = __ffs(id);
+		unsigned int	irq;
+
+		id &= ~BIT(pending);
+		irq = pending + tahvo->irq_base;
+		handle_nested_irq(irq);
 	}
 
 	return IRQ_HANDLED;
@@ -397,6 +384,63 @@ static void tahvo_irq_init(struct tahvo *tahvo)
 
 /* -------------------------------------------------------------------------- */
 
+static struct resource generic_resources[] = {
+	{
+		.start		= -EINVAL,	/* fixed later */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct device *tahvo_allocate_child(const char *name,
+		struct device *parent, int irq)
+{
+	struct platform_device	*pdev;
+	int			ret;
+
+	pdev = platform_device_alloc(name, -1);
+	if (!pdev) {
+		dev_dbg(parent, "can't allocate %s\n", name);
+		goto err0;
+	}
+
+	pdev->dev.parent = parent;
+
+	generic_resources[0].start = irq;
+
+	ret = platform_device_add_resources(pdev,
+			generic_resources, ARRAY_SIZE(generic_resources));
+	if (ret < 0) {
+		dev_dbg(parent, "can't add resources to %s\n", name);
+		goto err1;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret < 0) {
+		dev_dbg(parent, "can't add %s\n", name);
+		goto err1;
+	}
+
+	return &pdev->dev;
+
+err1:
+	platform_device_put(pdev);
+
+err0:
+	return NULL;
+}
+
+static int tahvo_allocate_children(struct device *parent, int irq_base)
+{
+	struct device		*child;
+
+	child = tahvo_allocate_child("tahvo-usb", parent,
+			irq_base + TAHVO_INT_VBUSON);
+	if (!child)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	struct tahvo		*tahvo;
@@ -450,6 +494,12 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	ret = tahvo_allocate_children(&pdev->dev, tahvo->irq_base);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to allocate children\n");
+		goto err2;
+	}
+
 	dev_err(&pdev->dev, "%s v%d.%d found\n",
 			tahvo->is_betty ? "Betty" : "Tahvo",
 			(rev >> 4) & 0x0f, rev & 0x0f);
-- 
1.7.6

