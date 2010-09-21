From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Mon, 20 Sep 2010 17:07:07 -0700
Message-ID: <87r5goq7ro.fsf@deeprootsystems.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64990 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0IUAHK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 20:07:10 -0400
Received: by pzk34 with SMTP id 34so1285328pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 17:07:09 -0700 (PDT)
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Sat, 18 Sep 2010 19:45:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com

"Varadarajan, Charulatha" <charu@ti.com> writes:

> This patch series makes OMAP2PLUS specific GPIO implemented in hwmod
> FW way. This is done by implementing GPIO module in platform device model.
>
> This patch series is generated on "origin/pm-wip/pm-core" which
> has Kevin's pm-next series, the runtime PM core patch series,
> and a collection of hwmod fixes that Paul/Benoit have lined up
> for 2.6.37.
>
> Tested on OMAP2430, OMAP44430, OMAP3430 SDP and zoom3 boards.
> Also verified that this patch series does not break the OMAP1 build.
>
> This patch series is created on top of the following patches:
> 1. OMAP: HWMOD: Handle opt clocks using clk_add_alias
> [https://patchwork.kernel.org/patch/124531/]
> 2. OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
> [https://patchwork.kernel.org/patch/176172/]
> 3. OMAP: CPUIDLE: Enable IRQs during device activity check and idle management
> by Kevin
>
> This series is tested on OMAP4430 ES2 using the below series
> http://www.spinics.net/lists/linux-omap/msg36023.html

Hi Charu,

I haven't been fully through the series, but here's some quick feedback
based on what I tried today.

Basically, I got stuck because the first board I tried it on was the
35xx-based OMAP3EVM platform, which uses a GPIO-based interrupt for the
network.  My setup uses DHCP + nfsroot, so the GPIO IRQ must be working
during boot.

The first thing I noticed, is that GPIO interrupts are not firing during
boot, so neither the DHCP or the nfsroot works during boot.  I haven't
been able to fully debug this, but the 3430SDP should have the same
issue for its smc91x if you set it up for DHCP + nfsroot.  This is
working fine on my pm-wip/idle-reorg branch which has the prerequisites
you mentioned, but didn't work when I applied the clk_alias patch plus
this series.

The other change when debugging I made was to make the
'workaround_enable' hack bank specific.  Now that the bank idles can be
called independetly, this would get cleared as soon as one of the banks
clears it.  It should be a per-bank flag[1]

Another thing I noticed was that ENWAKEUP is no longer set in the
SYSCONFIG register for each bank, as it was before.  To avoid this kind
of functional change, I did[2]

I'll get back to digging a bit tomorrow, but hopefully you can debug
this further before I get to it.

Kevin


[1]
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 2f5c1eb..3b60418 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -170,6 +170,7 @@ struct gpio_bank {
 	struct omap_gpio_regs gpio_context;
 	struct powerdomain *pwrdm;
 	bool dbck_flag;
+	int workaround_enabled;
 };
 
 static void omap_gpio_save_context(struct device *dev);
@@ -1830,8 +1831,6 @@ static int omap_gpio_resume(struct device *dev)
 	return 0;
 }
 
-static int workaround_enabled;
-
 static int gpio_bank_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1887,7 +1886,7 @@ static int gpio_bank_runtime_suspend(struct device *dev)
 		__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
 	}
 
-	workaround_enabled = 1;
+	bank->workaround_enabled = 1;
 
 	return 0;
 }
@@ -1900,7 +1899,7 @@ static int gpio_bank_runtime_resume(struct device *dev)
 	if (bank->dbck_enable_mask)
 		clk_enable(bank->dbck);
 
-	if ((!workaround_enabled) || (!(bank->enabled_non_wakeup_gpios)))
+	if ((!bank->workaround_enabled) || (!(bank->enabled_non_wakeup_gpios)))
 		return 0;
 
 	if (bank->method == METHOD_GPIO_24XX) {
@@ -2110,11 +2109,11 @@ void omap2_gpio_prepare_for_idle(void)
 {
 	int i;
 
-	workaround_enabled = 0;
-
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 
+		bank->workaround_enabled = 0;
+
 		/* If the gpio bank is not used, do nothing */
 		if ((!bank->pwrdm) || !(bank->mod_usage))
 			continue;


[2]
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index e759311..ae7487f 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -54,6 +54,8 @@ static int omap2_init_gpio(struct omap_hwmod *oh, void *user)
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * gpio_bank_count;
 	pdata->pwrdm = omap_hwmod_get_pwrdm(oh);
 
+	omap_hwmod_enable_wakeup(oh);
+
 	switch (oh->class->rev) {
 	case 0:
 	case 1:
