From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Wed, 29 Dec 2010 13:01:31 +0200
Message-ID: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:65387 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab0L2LJk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 06:09:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>

In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
updating reg and l values. However, at the end of the function we
perform a write:

	__raw_writel(l, reg);

So on OMAP2+ we end up writing 0 to the bank->base which is not
correct (typically this points to GPIO_REVISION register).

Fix this by returning immediately after call to
set_24xx_gpio_triggering().

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..4dcb66f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -867,7 +867,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	case METHOD_GPIO_24XX:
 	case METHOD_GPIO_44XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
-		break;
+		return 0;
 #endif
 	default:
 		goto bad;
-- 
1.7.3.2

