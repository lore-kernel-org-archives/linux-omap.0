From: Joonyoung Shim <dofmind@gmail.com>
Subject: [PATCH] OMAP3 GPIO: Fix getting the value of the GPIO output pin
Date: Sat, 7 Feb 2009 13:15:25 +0900
Message-ID: <4e1455be0902062015i1ff94b28p93588e61b7860618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:48876 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZBGEPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2009 23:15:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

If the GPIO pin is output, must read the value from OMAP24XX_GPIO_DATAOUT
register in __omap_get_gpio_datain().

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f856a90..296773a 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -428,7 +428,11 @@ static int __omap_get_gpio_datain(int gpio)
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_DATAIN;
+		if (__raw_readl(reg + OMAP24XX_GPIO_OE)
+					& (1 << get_gpio_index(gpio)))
+			reg += OMAP24XX_GPIO_DATAIN;
+		else
+			reg += OMAP24XX_GPIO_DATAOUT;
 		break;
 #endif
 	default:
