From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Mon, 15 Apr 2013 13:10:19 -0500
Message-ID: <516C428B.3020805@ti.com>
References: <20130409212318.GR10155@atomide.com> <5165A1DB.3020404@ti.com> <20130410182034.GH10155@atomide.com> <5165CED4.1040800@ti.com> <20130410205407.GQ10155@atomide.com> <5165E6F1.8040102@ti.com> <20130410222749.GR10155@atomide.com> <20130413000615.GF10155@atomide.com> <5168C050.7030006@ti.com> <20130413165014.GL10155@atomide.com> <516C3179.4070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33071 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3DOSKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 14:10:22 -0400
In-Reply-To: <516C3179.4070501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>


On 04/15/2013 11:57 AM, Jon Hunter wrote:
> 
> On 04/13/2013 11:50 AM, Tony Lindgren wrote:
>> * Jon Hunter <jon-hunter@ti.com> [130412 19:22]:
>>>
>>> On 04/12/2013 07:06 PM, Tony Lindgren wrote:
>>>> * Tony Lindgren <tony@atomide.com> [130410 15:32]:
>>>>> * Jon Hunter <jon-hunter@ti.com> [130410 15:30]:
>>>>>>
>>>>>> Are you saying that you want to use the version with that is using the
>>>>>> pre-processor definitions? I was thinking that may be we could do that
>>>>>> as a clean-up for v3.11 and just use the original version I posted
>>>>>> earlier. Seems cleaner to me.
>>>>>
>>>>> No let's do that the preprocessor conversion for v3.11.
>>>>
>>>> Hmm looks like there are few more 3430sdp dt nfsroot exposed
>>>> issues in today's linux next.
>>>
>>> I don't even see any ethernet devices defined in the omap3430-sdp.dts
>>> file. Is this something that you have added on top?
>>
>> Oops sorry I meant the ks8851 on SPI on 4430sdp, not 3430.
> 
> Ok makes sense.
> 
>>>> To get nfsroot to behave, I had to have your earlier fix
>>>> from this thread and also revert a2797bea (gpio/omap: force
>>>> restore if context loss is not detectable).
>>>>
>>>> Otherwise nfsroot fails, but not necessarily every time?
>>>
>>> Well this patch is going to force a gpio restore everytime we call
>>> pm_runtime_get() when the use-count is 0. Yes this is not efficient,
>>> however, without this patch you run the risk of context being lost and
>>> you would never know. Per the changelog, long term a better solution is
>>> needed.
>>
>> It seems that this patch kills the ks8851 GPIO interrupt somehow,
>> at least most of the time.
> 
> Hmmm, let me go back and re-test this.

Ok I am seeing the problem. Looks like this patch exposed another
bug in the gpio driver. Seems that we never initialise the gpio
context during the probe and so on the first pm_runtime_get_sync()
during the probe we are restoring crap. Can you try this? If this
works, I will add a changelog and post as a fix.

Jon

>From 56598ba51a75481b050433bb38b7ae31a5ed4ae8 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Mon, 15 Apr 2013 13:06:54 -0500
Subject: [PATCH] gpio/omap: ensure gpio context is initialised

---
 drivers/gpio/gpio-omap.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0557529..53bb8d5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -70,6 +70,7 @@ struct gpio_bank {
 	bool is_mpuio;
 	bool dbck_flag;
 	bool loses_context;
+	bool context_setup;
 	int stride;
 	u32 width;
 	int context_loss_count;
@@ -1085,6 +1086,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 }
 
 static const struct of_device_id omap_gpio_match[];
+static void omap_gpio_setup_context(struct gpio_bank *p);
 
 static int omap_gpio_probe(struct platform_device *pdev)
 {
@@ -1179,8 +1181,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
 
-	if (bank->loses_context)
+	if (bank->loses_context) {
 		bank->get_context_loss_count = pdata->get_context_loss_count;
+		omap_gpio_setup_context(bank);
+	}
 
 	pm_runtime_put(bank->dev);
 
@@ -1385,8 +1389,43 @@ void omap2_gpio_resume_after_idle(void)
 }
 
 #if defined(CONFIG_PM_RUNTIME)
+static void omap_gpio_setup_context(struct gpio_bank *p)
+{
+	struct omap_gpio_reg_offs *regs = p->regs;
+	void __iomem *base = p->base;
+
+	p->context.wake_en = __raw_readl(base + regs->wkup_en);
+	p->context.ctrl = __raw_readl(base + regs->ctrl);
+	p->context.ctrl = __raw_readl(base + regs->ctrl);
+	p->context.leveldetect0 = __raw_readl(base + regs->leveldetect0);
+	p->context.leveldetect1 = __raw_readl(base + regs->leveldetect1);
+	p->context.risingdetect = __raw_readl(base + regs->risingdetect);
+	p->context.fallingdetect = __raw_readl(base + regs->fallingdetect);
+
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout = __raw_readl(base + regs->set_dataout);
+	else
+		p->context.dataout = __raw_readl(base + regs->dataout);
+
+	p->context.oe = __raw_readl(base + regs->direction);
+
+	if (p->dbck_enable_mask) {
+		p->context.debounce = __raw_readl(base + regs->debounce);
+		p->context.debounce_en = __raw_readl(base + regs->debounce_en);
+	}
+
+	p->context.irqenable1 = __raw_readl(base + regs->irqenable);
+	p->context.irqenable2 = __raw_readl(base + regs->irqenable2);
+
+	p->context_setup = true;
+}
+
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
+	/* If context has not been initialised yet, return */
+	if (!bank->context_setup)
+		return;
+
 	__raw_writel(bank->context.wake_en,
 				bank->base + bank->regs->wkup_en);
 	__raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
@@ -1422,6 +1461,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
+#define omap_gpio_setup_context NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-- 
1.7.10.4

