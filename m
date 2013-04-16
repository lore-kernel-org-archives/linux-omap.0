From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Tue, 16 Apr 2013 12:14:52 -0500
Message-ID: <516D870C.2030108@ti.com>
References: <20130410182034.GH10155@atomide.com> <5165CED4.1040800@ti.com> <20130410205407.GQ10155@atomide.com> <5165E6F1.8040102@ti.com> <20130410222749.GR10155@atomide.com> <20130413000615.GF10155@atomide.com> <5168C050.7030006@ti.com> <20130413165014.GL10155@atomide.com> <516C3179.4070501@ti.com> <516C428B.3020805@ti.com> <20130415212756.GQ10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37058 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965022Ab3DPROy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 13:14:54 -0400
In-Reply-To: <20130415212756.GQ10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>


On 04/15/2013 04:27 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130415 11:15]:

...

>> From 56598ba51a75481b050433bb38b7ae31a5ed4ae8 Mon Sep 17 00:00:00 2001
>> From: Jon Hunter <jon-hunter@ti.com>
>> Date: Mon, 15 Apr 2013 13:06:54 -0500
>> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
> 
> Seems to work thanks:
> 
> Tested-by: Tony Lindgren <tony@atomide.com> 

Thanks. I have been cleaning this up and updating a little. Care to
re-test this version? If it is good I will send it out.

By the way, I realise I need to add a similar fix for dmtimer :-p

Cheers
Jon

>From 3980952af35054e50d743691fc3e0867de5b0f4d Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Mon, 15 Apr 2013 13:06:54 -0500
Subject: [PATCH] gpio/omap: ensure gpio context is initialised

Commit a2797be (gpio/omap: force restore if context loss is not
detectable) broke gpio support for OMAP when booting with device-tree
because a restore of the gpio context being performed without ever
initialising the gpio context. In other words, the context restored was
bad.

This problem could also occur in the non device-tree case, however, it
is much less likely because when booting without device-tree we can
detect context loss via a platform specific API and so context restore
is performed less often.

Nevertheless we should ensure that the gpio context is initialised
during the probe for gpio banks that could lose their state regardless
of whether we are booting with device-tree or not.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |   53 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0557529..444451b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -70,6 +70,7 @@ struct gpio_bank {
 	bool is_mpuio;
 	bool dbck_flag;
 	bool loses_context;
+	bool context_valid;
 	int stride;
 	u32 width;
 	int context_loss_count;
@@ -1085,6 +1086,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 }
 
 static const struct of_device_id omap_gpio_match[];
+static void omap_gpio_init_context(struct gpio_bank *p);
 
 static int omap_gpio_probe(struct platform_device *pdev)
 {
@@ -1179,8 +1181,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (bank->loses_context)
+	if (bank->loses_context) {
 		bank->get_context_loss_count = pdata->get_context_loss_count;
+		omap_gpio_init_context(bank);
+	}
 
 	pm_runtime_put(bank->dev);
 
@@ -1269,6 +1273,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	int c;
 
 	spin_lock_irqsave(&bank->lock, flags);
+
+	/*
+	 * On the first resume during the probe, the context has not
+	 * been initialised and so if the context is not valid return.
+	 */
+	if (!bank->context_valid)
+		goto done;
+
 	_gpio_dbck_enable(bank);
 
 	/*
@@ -1287,19 +1299,15 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			omap_gpio_restore_context(bank);
 		} else {
 			c = bank->get_context_loss_count(bank->dev);
-			if (c != bank->context_loss_count) {
+			if (c != bank->context_loss_count)
 				omap_gpio_restore_context(bank);
-			} else {
-				spin_unlock_irqrestore(&bank->lock, flags);
-				return 0;
-			}
+			else
+				goto done;
 		}
 	}
 
-	if (!bank->workaround_enabled) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-	}
+	if (!bank->workaround_enabled)
+		goto done;
 
 	l = __raw_readl(bank->base + bank->regs->datain);
 
@@ -1352,6 +1360,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	}
 
 	bank->workaround_enabled = false;
+done:
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1385,6 +1394,29 @@ void omap2_gpio_resume_after_idle(void)
 }
 
 #if defined(CONFIG_PM_RUNTIME)
+static void omap_gpio_init_context(struct gpio_bank *p)
+{
+	struct omap_gpio_reg_offs *regs = p->regs;
+	void __iomem *base = p->base;
+
+	p->context.ctrl		= __raw_readl(base + regs->ctrl);
+	p->context.oe		= __raw_readl(base + regs->direction);
+	p->context.wake_en	= __raw_readl(base + regs->wkup_en);
+	p->context.leveldetect0	= __raw_readl(base + regs->leveldetect0);
+	p->context.leveldetect1	= __raw_readl(base + regs->leveldetect1);
+	p->context.risingdetect	= __raw_readl(base + regs->risingdetect);
+	p->context.fallingdetect = __raw_readl(base + regs->fallingdetect);
+	p->context.irqenable1	= __raw_readl(base + regs->irqenable);
+	p->context.irqenable2	= __raw_readl(base + regs->irqenable2);
+
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout = __raw_readl(base + regs->set_dataout);
+	else
+		p->context.dataout = __raw_readl(base + regs->dataout);
+
+	p->context_valid = true;
+}
+
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
 	__raw_writel(bank->context.wake_en,
@@ -1422,6 +1454,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
+#define omap_gpio_init_context NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-- 
1.7.10.4
