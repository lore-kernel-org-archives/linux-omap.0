From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH -pm] OMAP3: GPIO: introduce per-bank context
 save/restore
Date: Wed, 16 Dec 2009 00:37:28 +0200
Message-ID: <20091215223728.GA28203@nokia.com>
References: <1260916172-8226-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54613 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbZLOWjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 17:39:36 -0500
Content-Disposition: inline
In-Reply-To: <1260916172-8226-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Dec 15, 2009 at 11:29:32PM +0100, ext Kevin Hilman wrote:
>diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>index 57a46be..283ed2e 100644
>--- a/arch/arm/plat-omap/gpio.c
>+++ b/arch/arm/plat-omap/gpio.c
>@@ -174,6 +174,21 @@
> #define OMAP44XX_GPIO5_BASE             0x4805B000
> #define OMAP44XX_GPIO6_BASE             0x4805D000
>
>+struct omap3_gpio_bank_regs {
>+	u32 sysconfig;
>+	u32 irqenable1;
>+	u32 irqenable2;
>+	u32 wake_en;
>+	u32 ctrl;
>+	u32 oe;
>+	u32 leveldetect0;
>+	u32 leveldetect1;
>+	u32 risingdetect;
>+	u32 fallingdetect;
>+	u32 dataout;
>+};
>+
>+

one blank line only ?

>@@ -2338,28 +2372,8 @@ void omap_gpio_restore_context(void)
>
> 	for (i = 1; i < gpio_bank_count; i++) {
> 		struct gpio_bank *bank = &gpio_bank[i];
>-		__raw_writel(gpio_context[i].sysconfig,
>-				bank->base + OMAP24XX_GPIO_SYSCONFIG);
>-		__raw_writel(gpio_context[i].irqenable1,
>-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
>-		__raw_writel(gpio_context[i].irqenable2,
>-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
>-		__raw_writel(gpio_context[i].wake_en,
>-				bank->base + OMAP24XX_GPIO_WAKE_EN);
>-		__raw_writel(gpio_context[i].ctrl,
>-				bank->base + OMAP24XX_GPIO_CTRL);
>-		__raw_writel(gpio_context[i].leveldetect0,
>-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
>-		__raw_writel(gpio_context[i].leveldetect1,
>-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
>-		__raw_writel(gpio_context[i].risingdetect,
>-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
>-		__raw_writel(gpio_context[i].fallingdetect,
>-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
>-		__raw_writel(gpio_context[i].dataout,
>-				bank->base + OMAP24XX_GPIO_DATAOUT);
>-		__raw_writel(gpio_context[i].oe,
>-				bank->base + OMAP24XX_GPIO_OE);
>+		
		^ trailing tabs (2 tabs).

-- 
balbi
