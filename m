From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
 method
Date: Thu, 1 Apr 2010 08:39:03 +0300
Message-ID: <20100401053903.GB16297@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
 <20100331162158.GB32025@rakim.wolfsonmicro.main>
 <20100331162909.GA23490@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57246 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0DAFjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 01:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20100331162909.GA23490@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,

On Wed, Mar 31, 2010 at 06:29:09PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>On Wed, Mar 31, 2010 at 06:21:58PM +0200, ext Mark Brown wrote:
>>On Wed, Mar 31, 2010 at 06:35:10PM +0300, Felipe Balbi wrote:
>>> +	if (debounce) {
>>> +		val |= l;
>>> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
>>> +			clk_enable(bank->dbck);
>>> +	} else {
>>> +		val &= ~l;
>>> +		if (cpu_is_omap34xx() || cpu_is_omap44xx())
>>> +			clk_disable(bank->dbck);
>>> +	}
>>
>>Will these do the right thing with the clocks for noop transitions or
>>tweaks to the debounce time?  I'm not familiar with the OMAP clock
>>framework, it could handle this.
>
>good catch. We need to be a bit smarter here. I'll leave that for
>tomorrow. already 19:30 :-p

attached is a new version of this patch.

-- 
balbi

--IrhDeMKUP4DT/M7F
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap-gpio-implement-set_debounce-method.diff"

>From 23b09f437d8bacebab676deaf52631b7eb0e8f15 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 31 Mar 2010 15:17:29 +0300
Subject: [PATCHv3] arm: omap: gpio: implement set_debounce method

OMAP support debouncing of gpio lines, implement
the method using gpiolib.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Changes since v2:
	- enable/disable debounce clock only once

 arch/arm/plat-omap/gpio.c |   75 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 76a347b..163d88b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -194,6 +194,7 @@ struct gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
+	unsigned dbck_enabled:1;
 	u32 mod_usage;
 };
 
@@ -612,6 +613,65 @@ do {	\
 	__raw_writel(l, base + reg); \
 } while(0)
 
+/**
+ * _set_gpio_debounce - low level gpio debounce time
+ * @bank: the gpio bank we're acting upon
+ * @gpio: the gpio number on this @gpio
+ * @debounce: debounce time to use
+ *
+ * OMAP's debounce time is in 31us steps so we need
+ * to convert and round up to the closest unit.
+ */
+static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
+		unsigned debounce)
+{
+	void __iomem		*reg = bank->base;
+	u32			val;
+	u32			l;
+
+	if (debounce < 32)
+		debounce = 0x01;
+	else if (debounce > 7936)
+		debounce = 0xff;
+	else
+		debounce = (debounce / 0x1f) - 1;
+
+	l = 1 << get_gpio_index(gpio);
+
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCINGTIME;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
+
+	__raw_writel(debounce, reg);
+
+	reg = bank->base;
+	if (cpu_is_omap44xx())
+		reg += OMAP4_GPIO_DEBOUNCENABLE;
+	else
+		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
+
+	val = __raw_readl(reg);
+
+	if (debounce) {
+		val |= l;
+		if (!bank->dbck_enabled &&
+				(cpu_is_omap34xx() || cpu_is_omap44xx())) {
+			clk_enable(bank->dbck);
+			bank->dbck_enabled = true;
+		}
+	} else {
+		val &= ~l;
+		if (bank->dbck_enabled &&
+				(cpu_is_omap34xx() || cpu_is_omap44xx())) {
+			clk_disable(bank->dbck);
+			bank->dbck_enabled = false;
+		}
+	}
+
+	__raw_writel(val, reg);
+}
+
 void omap_set_gpio_debounce(int gpio, int enable)
 {
 	struct gpio_bank *bank;
@@ -1608,6 +1668,20 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	return 0;
 }
 
+static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
+		unsigned debounce)
+{
+	struct gpio_bank *bank;
+	unsigned long flags;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	spin_lock_irqsave(&bank->lock, flags);
+	_set_gpio_debounce(bank, offset, debounce);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
 static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_bank *bank;
@@ -1860,6 +1934,7 @@ static int __init _omap_gpio_init(void)
 		bank->chip.direction_input = gpio_input;
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
+		bank->chip.set_debounce = gpio_debounce;
 		bank->chip.set = gpio_set;
 		bank->chip.to_irq = gpio_2irq;
 		if (bank_is_mpuio(bank)) {
-- 
1.7.0.rc0.33.g7c3932


--IrhDeMKUP4DT/M7F--
