From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 6/6] gpio/omap: fix _set_gpio_irqenable implementation
Date: Thu, 23 Feb 2012 17:40:31 +0530
Message-ID: <1329999031-6914-7-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: grant.likely@secretlab.ca, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>
List-Id: linux-omap@vger.kernel.org

This function should be capable of both enabling and disabling interrupts
based upon the *enable* parameter. Right now the function only enables
the interrupt and *enable* is not used at all. So add the interrupt
disable capability also using the parameter.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 67535c8..acc71a0 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -473,7 +473,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	if (enable)
+		_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	else
+		_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 /*
-- 
1.7.0.4
