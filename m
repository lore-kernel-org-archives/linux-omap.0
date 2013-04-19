From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Thu, 18 Apr 2013 19:49:29 -0500
Message-ID: <51709499.8030208@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com> <871ua734mv.fsf@linaro.org> <51707D7C.1050600@ti.com> <5170911C.6010507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42788 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967630Ab3DSAtf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 20:49:35 -0400
In-Reply-To: <5170911C.6010507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 04/18/2013 07:34 PM, Jon Hunter wrote:
> 
> On 04/18/2013 06:10 PM, Jon Hunter wrote:
>> On 04/18/2013 04:34 PM, Kevin Hilman wrote:
> 
> ...
> 
>>> Why not just init context right here if bank->loses_context &&
>>> !bank->context_valid?
> 
> I really like this idea a lot. It can really clean-up the code
> and really make it much more readable. Before we were playing 
> some tricks with when we init'ed the get_context_loss_count()
> function pointer. How about the below?
> 
> Tony, care to re-test?
> 
> Cheers
> Jon
> 
> From d7a940531d354e6be5e16ee50fa8344041df963a Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Mon, 15 Apr 2013 13:06:54 -0500
> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
> 
> Commit a2797be (gpio/omap: force restore if context loss is not
> detectable) broke gpio support for OMAP when booting with device-tree
> because a restore of the gpio context being performed without ever
> initialising the gpio context. In other words, the context restored was
> bad.
> 
> This problem could also occur in the non device-tree case, however, it
> is much less likely because when booting without device-tree we can
> detect context loss via a platform specific API and so context restore
> is performed less often.
> 
> Nevertheless we should ensure that the gpio context is initialised
> on the first pm-runtime resume for gpio banks that could lose their
> state regardless of whether we are booting with device-tree or not.
> 
> The context loss count was being initialised on the first pm-runtime
> suspend following a resume, by populating the get_count_loss_count()
> function pointer after the first pm-runtime resume. To make the code
> more readable and logical, initialise the context loss count on the
> first pm-runtime resume if the context is not yet valid.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   45 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0557529..db3c732 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -70,6 +70,7 @@ struct gpio_bank {
>  	bool is_mpuio;
>  	bool dbck_flag;
>  	bool loses_context;
> +	bool context_valid;
>  	int stride;
>  	u32 width;
>  	int context_loss_count;
> @@ -1129,6 +1130,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  			bank->loses_context = true;
>  	} else {
>  		bank->loses_context = pdata->loses_context;
> +		bank->get_context_loss_count = pdata->get_context_loss_count;

Still need to check loses_context for populating
get_context_loss_count here. Updated patch below.

Jon

>From d02ef7b7dfcf8e13bf019aedfdecb38ca3c6749f Mon Sep 17 00:00:00 2001
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
on the first pm-runtime resume for gpio banks that could lose their
state regardless of whether we are booting with device-tree or not.

The context loss count was being initialised on the first pm-runtime
suspend following a resume, by populating the get_count_loss_count()
function pointer after the first pm-runtime resume. To make the code
more readable and logical, initialise the context loss count on the
first pm-runtime resume if the context is not yet valid.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |   48 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0557529..c3c3ffe 100644
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
@@ -1129,6 +1130,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 			bank->loses_context = true;
 	} else {
 		bank->loses_context = pdata->loses_context;
+
+		if (bank->loses_context)
+			bank->get_context_loss_count =
+				pdata->get_context_loss_count;
 	}
 
 
@@ -1179,9 +1184,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (bank->loses_context)
-		bank->get_context_loss_count = pdata->get_context_loss_count;
-
 	pm_runtime_put(bank->dev);
 
 	list_add_tail(&bank->node, &omap_gpio_list);
@@ -1260,6 +1262,8 @@ update_gpio_context_count:
 	return 0;
 }
 
+static void omap_gpio_init_context(struct gpio_bank *p);
+
 static int omap_gpio_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1269,6 +1273,20 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	int c;
 
 	spin_lock_irqsave(&bank->lock, flags);
+
+	/*
+	 * On the first resume during the probe, the context has not
+	 * been initialised and so initialise it now. Also initialise
+	 * the context loss count.
+	 */
+	if (bank->loses_context && !bank->context_valid) {
+		omap_gpio_init_context(bank);
+
+		if (bank->get_context_loss_count)
+			bank->context_loss_count =
+				bank->get_context_loss_count(bank->dev);
+	}
+
 	_gpio_dbck_enable(bank);
 
 	/*
@@ -1385,6 +1403,29 @@ void omap2_gpio_resume_after_idle(void)
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
@@ -1422,6 +1463,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
+static void omap_gpio_init_context(struct gpio_bank *p) {}
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-- 
1.7.10.4
