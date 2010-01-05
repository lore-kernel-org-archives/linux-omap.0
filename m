From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch-v2.6.33-rc2+ 10/12] arm: omap: gpio: kill compile
 warning in gpio.c
Date: Tue, 5 Jan 2010 12:20:16 -0800
Message-ID: <20100105202016.GA14533@atomide.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
 <1262127092-14878-11-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58695 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271Ab0AEUUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 15:20:18 -0500
Content-Disposition: inline
In-Reply-To: <1262127092-14878-11-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <felipe.balbi@nokia.com> [091229 14:59]:
> when building linux-omap for omap1510, there will
> be a compile warning about the unused flags variable
> which is only used on 16xx and onwards.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/plat-omap/gpio.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 0484681..8c34b81 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1072,7 +1072,10 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
>   */
>  static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>  {
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
> +	defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
>  	unsigned long flags;
> +#endif
>  

Let's not add more ifdeffery to gpio.c.. How about
let's use uninitialized_var() instead? See the patch
below.

Regards,

Tony


--Qxx1br4bt0+wmkIi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="uninitialized-var.patch"

>From 62fc4a4ec588956979ef611da8753d8d1c02de8e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Jan 2010 12:17:06 -0800
Subject: [PATCH] omap: Remove uninitialized warning for gpio.c

Flags is not used on 15xx.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0484681..792be9f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1072,7 +1072,7 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX

--Qxx1br4bt0+wmkIi--
