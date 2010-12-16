From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v1] OMAP: GPIO: Correct IP version message during boot
Date: Thu, 16 Dec 2010 19:39:46 +0530
Message-ID: <1292508586-21651-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35953 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab0LPOKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 09:10:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, balbi@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

With the commit 9a748053f5f58a77cd71864f1d7b804175b0e47d whose subject is
"OMAP: GPIO: Make omap_gpio_show_rev bank specific" (see [1]),
the IP version information for all the banks are shown during bootup,
but it does not show the bank number.

Use dev_info instead of printk in omap_gpio_show_rev() so that the
bank id is displayed along with the IP version

[1] http://www.spinics.net/lists/arm-kernel/msg105872.html

Signed-off-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8d493b9..47aeaeb 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1554,7 +1554,7 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 	else
 		return;
 
-	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
+	dev_info(bank->dev, "hardware version %d.%d\n",
 		(rev >> 4) & 0x0f, rev & 0x0f);
 }
 
-- 
1.7.1

