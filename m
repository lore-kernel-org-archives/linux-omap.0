From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v8 01/11] OMAP: GPIO: prepare for platform driver
Date: Thu, 09 Dec 2010 11:18:54 -0800
Message-ID: <8762v292ld.fsf@deeprootsystems.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-2-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:54714 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0LITTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 14:19:00 -0500
Received: by gwb20 with SMTP id 20so2359361gwb.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 11:18:59 -0800 (PST)
In-Reply-To: <1290689318-10191-2-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Thu, 25 Nov 2010 18:18:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com

Hi Charu,

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Prepare for implementing GPIO as a platform driver.
>
> Modifies omap_gpio_init() to make use of omap_gpio_chip_init()
> and omap_gpio_mod_init(). omap_gpio_mod_init() does the module init
> by clearing the status register and initializing the GPIO control register.
> omap_gpio_chip_init() initializes the chip request, free, get, set and
> other function pointers and sets the gpio irq handler.
>
> This is only to reorganize the code so that the "omap gpio platform driver
> implementation patch" looks cleaner and better to review.
>
> Signed-off-by: Charulatha V <charu@ti.com>

I just noticed while testing on 36xx/Zoom3 that GPIO wakeups are no
longer working after this series.

The problem seems to be that for OMAP2+, this series removed manual
SYSCONFIG register setting in favor of using omap_hwmod (which is good),
however some of the SYSCONFIG values, specifically, in the current code,
the ENAWAKEUP bit was set in each bank, but this is no longer the
default with omap_hwmod.

> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -		if ((bank->method == METHOD_GPIO_24XX) ||
> -				(bank->method == METHOD_GPIO_44XX)) {
> -			static const u32 non_wakeup_gpios[] = {
> -				0xe203ffc0, 0x08700040
> -			};
> -
> -			if (cpu_is_omap44xx()) {
> -				__raw_writel(0xffffffff, bank->base +
> -						OMAP4_GPIO_IRQSTATUSCLR0);
> -				__raw_writew(0x0015, bank->base +
> -						OMAP4_GPIO_SYSCONFIG);
> -				__raw_writel(0x00000000, bank->base +
> -						 OMAP4_GPIO_DEBOUNCENABLE);
> -				/*
> -				 * Initialize interface clock ungated,
> -				 * module enabled
> -				 */
> -				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> -			} else {
> -				__raw_writel(0x00000000, bank->base +
> -						OMAP24XX_GPIO_IRQENABLE1);
> -				__raw_writel(0xffffffff, bank->base +
> -						OMAP24XX_GPIO_IRQSTATUS1);
> -				__raw_writew(0x0015, bank->base +
> -						OMAP24XX_GPIO_SYSCONFIG);

Here bit 2 (ENAWAKEUP) is set, and is not reconfigured anywhere in this
series.  Same for OMAP4 above.

Here's a quick fix to preserve current functionality (will post
w/changelog shortly), but it shows that GPIO wakeups were not fully
tested with this series.  In the future, along with reporting what
platforms it was testing on, it would be very helpful to include a
summary of how the series was tested.

Thanks,

Kevin



diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 413de18..05a123f 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -75,6 +75,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
+	omap_hwmod_enable_wakeup(oh);
 	od = omap_device_build(name, id - 1, oh, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
