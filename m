From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] usb: phy: phy-generic: Fix reset behaviour on legacy boot
Date: Thu, 13 Aug 2015 13:28:42 +0300
Message-ID: <1439461722-9498-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, robert.jarzmik@free.fr, fabio.estevam@freescale.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The gpio-desc migration done in v4.0 caused a regression
with legacy boots due to reversed reset logic.
e.g. omap3-beagle USB host breaks on legacy boot.

Request the reset GPIO with GPIOF_ACTIVE_LOW flag so that
it matches the driver logic and pin behaviour.

Fixes: e9f2cefb0cdc ("usb: phy: generic: migrate to gpio_desc")
Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index deee68e..0cd85f2 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -230,7 +230,8 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
 		clk_rate = pdata->clk_rate;
 		needs_vcc = pdata->needs_vcc;
 		if (gpio_is_valid(pdata->gpio_reset)) {
-			err = devm_gpio_request_one(dev, pdata->gpio_reset, 0,
+			err = devm_gpio_request_one(dev, pdata->gpio_reset,
+						    GPIOF_ACTIVE_LOW,
 						    dev_name(dev));
 			if (!err)
 				nop->gpiod_reset =
-- 
2.1.4
