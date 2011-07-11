From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 12/22] cbus: tahvo: give it an irq_chip
Date: Mon, 11 Jul 2011 14:17:25 +0300
Message-ID: <1310383055-20211-13-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53757 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997Ab1GKLSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:46 -0400
Received: by yxl11 with SMTP id 11so2043455yxl.35
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:45 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

tahvo also has IRQs to demux to its children,
so lets give it a struct irq_chip so that child
drivers can use standard request_threaded_irq().

This is still an unused irq_chip, later patches
will come to make proper use of it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index a538f13..3aaf0eb 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -44,8 +44,17 @@ struct tahvo {
 	struct mutex	mutex;
 	struct device	*dev;
 
-	unsigned int	is_betty;
-	unsigned int	wide_backlight;
+	int		irq_base;
+	int		irq_end;
+	int		irq;
+
+	int		ack;
+	int		mask;
+
+	unsigned int	wide_backlight:1;
+	unsigned int	mask_pending:1;
+	unsigned int	ack_pending:1;
+	unsigned int	is_betty:1;
 };
 
 static struct tahvo *the_tahvo;
@@ -300,6 +309,94 @@ void tahvo_free_irq(int id)
 }
 EXPORT_SYMBOL(tahvo_free_irq);
 
+/* -------------------------------------------------------------------------- */
+
+static void tahvo_irq_bus_lock(struct irq_data *data)
+{
+	struct tahvo		*tahvo = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&tahvo->mutex);
+}
+
+static void tahvo_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct tahvo		*tahvo = irq_data_get_irq_chip_data(data);
+
+	if (tahvo->mask_pending) {
+		__tahvo_write_reg(tahvo, TAHVO_REG_IMR, tahvo->mask);
+		tahvo->mask_pending = false;
+	}
+
+	if (tahvo->ack_pending) {
+		__tahvo_write_reg(tahvo, TAHVO_REG_IDR, tahvo->ack);
+		tahvo->ack_pending = false;
+	}
+
+	mutex_unlock(&tahvo->mutex);
+}
+
+static void tahvo_irq_mask(struct irq_data *data)
+{
+	struct tahvo		*tahvo = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
+
+	tahvo->mask |= (1 << (irq - tahvo->irq_base));
+	tahvo->mask_pending = true;
+}
+
+static void tahvo_irq_unmask(struct irq_data *data)
+{
+	struct tahvo		*tahvo = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
+
+	tahvo->mask &= ~(1 << (irq - tahvo->irq_base));
+	tahvo->mask_pending = true;
+}
+
+static void tahvo_irq_ack(struct irq_data *data)
+{
+	struct tahvo		*tahvo = irq_data_get_irq_chip_data(data);
+	int			irq = data->irq;
+
+	tahvo->ack |= (1 << (irq - tahvo->irq_base));
+	tahvo->ack_pending = true;
+}
+
+static struct irq_chip tahvo_irq_chip = {
+	.name			= "tahvo",
+	.irq_bus_lock		= tahvo_irq_bus_lock,
+	.irq_bus_sync_unlock	= tahvo_irq_bus_sync_unlock,
+	.irq_mask		= tahvo_irq_mask,
+	.irq_unmask		= tahvo_irq_unmask,
+	.irq_ack		= tahvo_irq_ack,
+};
+
+static inline void tahvo_irq_setup(int irq)
+{
+#ifdef CONFIG_ARM
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	set_irq_noprobe(irq);
+#endif
+}
+
+static void tahvo_irq_init(struct tahvo *tahvo)
+{
+	int			base = tahvo->irq_base;
+	int			end = tahvo->irq_end;
+	int			irq;
+
+	for (irq = base; irq < end; irq++) {
+		irq_set_chip_data(irq, tahvo);
+		irq_set_chip_and_handler(irq, &tahvo_irq_chip,
+				handle_simple_irq);
+		irq_set_nested_thread(irq, 1);
+		tahvo_irq_setup(irq);
+	}
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	struct tahvo		*tahvo;
@@ -315,11 +412,24 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	the_tahvo = tahvo;
+	irq = platform_get_irq(pdev, 0);
 	platform_set_drvdata(pdev, tahvo);
 
 	mutex_init(&tahvo->mutex);
-	tahvo->dev = &pdev->dev;
+
+	ret = irq_alloc_descs(-1, 0, MAX_TAHVO_IRQ_HANDLERS, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQ descs\n");
+		goto err1;
+	}
+
+	tahvo->irq_base	= ret;
+	tahvo->irq_end	= ret + MAX_TAHVO_IRQ_HANDLERS;
+	tahvo->dev	= &pdev->dev;
+	tahvo->irq	= irq;
+	the_tahvo	= tahvo;
+
+	tahvo_irq_init(tahvo);
 
 	rev = __tahvo_read_reg(tahvo, TAHVO_REG_ASICR);
 
@@ -337,15 +447,13 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	default:
 		dev_err(&pdev->dev, "Tahvo/Betty chip not found");
 		ret = -ENODEV;
-		goto err1;
+		goto err2;
 	}
 
 	dev_err(&pdev->dev, "%s v%d.%d found\n",
 			tahvo->is_betty ? "Betty" : "Tahvo",
 			(rev >> 4) & 0x0f, rev & 0x0f);
 
-	irq = platform_get_irq(pdev, 0);
-
 	/* Mask all TAHVO interrupts */
 	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
 
@@ -354,11 +462,14 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 			"tahvo", tahvo);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		goto err1;
+		goto err2;
 	}
 
 	return 0;
 
+err2:
+	irq_free_descs(tahvo->irq_base, MAX_TAHVO_IRQ_HANDLERS);
+
 err1:
 	kfree(tahvo);
 
@@ -376,6 +487,7 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	/* Mask all TAHVO interrupts */
 	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
+	irq_free_descs(tahvo->irq_base, MAX_TAHVO_IRQ_HANDLERS);
 	kfree(tahvo);
 	the_tahvo = NULL;
 
-- 
1.7.6

