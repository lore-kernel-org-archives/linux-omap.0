From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
Date: Wed, 29 Feb 2012 17:15:25 +0100
Message-ID: <4F4E4F1D.7020109@ti.com>
References: <4F4BB0FB.3040308@ti.com> <20120228234837.GH18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab2B2QPb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 11:15:31 -0500
In-Reply-To: <20120228234837.GH18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

Hi Tony,

On 2/29/2012 12:48 AM, Tony Lindgren wrote:
> Hi,
> 
> * Cousson, Benoit<b-cousson@ti.com>  [120227 08:04]:
>> Hi Tony
>>
>> This series is based on the lo/dt + the irqdomain/next branch merged on top of it.
>>
>> Grant confirmed that the irqdomain/next is a stable branch and thus can be referenced for dependency.
>>
>> Please note that I will need that branch to base all the remaining OMAP DT stuff.
>>
>> Thanks,
>> Benoit
>>
>>
>> The following changes since commit 1f52299ec000e2161635b263d81ab92ea7f1f0a7:
>>    Benoit Cousson (1):
>>          Merge branch 'irqdomain/next' of git://git.secretlab.ca/git/linux-2.6 into for_3.4/dt_irq_domain2
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_irq_domain
>>
>> Benoit Cousson (3):
>>        ARM: OMAP2/3: intc: Add DT support for TI interrupt controller
>>        arm/dts: OMAP3: Add interrupt-controller bindings for INTC
>>        ARM: OMAP2+: board-generic: Use of_irq_init API
>>
>>   .../devicetree/bindings/arm/omap/intc.txt          |   27 +++++++++
>>   arch/arm/boot/dts/omap3.dtsi                       |    6 +-
>>   arch/arm/mach-omap2/board-generic.c                |   30 +++++-----
>>   arch/arm/mach-omap2/common.h                       |   12 ++++
>>   arch/arm/mach-omap2/irq.c                          |   60 ++++++++++++++++---
>>   5 files changed, 109 insertions(+), 26 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/intc.txt
> 
> Hmm, looks like this now produces the following warning at least on omap3:

Yes, Rajendra has just reported that issue with linux-next.

It is not due to that series but to the increase of TWL irq_desc I did for Grant to fix a warning with irq_domain in the DT boot.
Unfortunately due the lack of NR_IRQS we already have becasue of PRCM handler we exceed the actual NR_IRQS that is set to 410 for the moment.

> [    0.290832] WARNING: at drivers/mfd/twl4030-irq.c:645 twl4030_sih_setup+0x258/0x298()
> [    0.290832] irq 428 for gpio too big

After applying the NR_IRQS fix, we still have a warning but a different one in that case:

[    0.303771] twl4030: PIH (irq 7) chaining IRQs 368..401
[    0.304473] twl4030: power (irq 373) chaining IRQs 402..409
[    0.307159] twl4030: gpio (irq 368) chaining IRQs 410..427
[    0.307189] ------------[ cut here ]------------
[    0.307220] WARNING: at drivers/gpio/gpio-twl4030.c:410 gpio_twl4030_probe+0x44/0x214()

This one is due to a "WARN_ON(ret != pdata->irq_base)" that is checking that the board irq_base is the same as the one from the twl4030_sih_setup. This kind of test are not SPARSE_IRQ friendly at all and should be removed anyway. I've attached a patch to fix the GPIO warning.

Felipe has started a twl4030 IRQ cleanup series to make that driver SPARSE_IRQ enabled. That's will fix properly the actual hack in the twl-core IRQ management. On top of that we can fix the twl-gpio warning.

Regards,
Benoit

---
>From 13bf5df12ea6dd0dded45bd4ee4d2508f5f2712c Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 28 Feb 2012 21:51:59 +0100
Subject: [PATCH] gpio/twl: Fix IRQ setup to be SPARSE_IRQ friendly

Since the SIH handler is allocating irq_descs dynamically, the
irq_base cannot be defined anymore by the board through pdata.

Remove the test to setup IRQ only in case of valid pdata.
Remove the check to ensure irq_base is the one from pdata.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-twl4030.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index b8b4f22..0f7d29c 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -398,19 +398,18 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 	int ret;
 
 	/* maybe setup IRQs */
-	if (pdata->irq_base) {
-		if (is_module()) {
-			dev_err(&pdev->dev,
-				"can't dispatch IRQs from modules\n");
-			goto no_irqs;
-		}
-		ret = twl4030_sih_setup(TWL4030_MODULE_GPIO);
-		if (ret < 0)
-			return ret;
-		WARN_ON(ret != pdata->irq_base);
-		twl4030_gpio_irq_base = ret;
+	if (is_module()) {
+		dev_err(&pdev->dev,
+			"can't dispatch IRQs from modules\n");
+		goto no_irqs;
 	}
 
+	ret = twl4030_sih_setup(TWL4030_MODULE_GPIO);
+	if (ret < 0)
+		return ret;
+
+	twl4030_gpio_irq_base = ret;
+
 no_irqs:
 	/*
 	 * NOTE:  boards may waste power if they don't set pullups
-- 
1.7.0.4

