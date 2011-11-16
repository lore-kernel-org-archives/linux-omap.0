From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2] ARM: OMAP: hsmmc: Fix mux for non-OMAP pins
Date: Wed, 16 Nov 2011 19:56:12 +0100
Message-ID: <1321469772-801-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Thomas Weber <weber@corscience.de>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, uwe.kleine-koenig@pengutronix.de
List-Id: linux-omap@vger.kernel.org

The Devkit8000 uses a TWL4030 pin for card detection.
Thats why the error:
_omap_mux_init_gpio: Could not set gpio192
occurs.

This patch checks that the pin is on OMAP before
calling omap_mux_init_gpio.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
Changelog:
v2: Remove backslash at end of line

 arch/arm/mach-omap2/hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index f4a1020..c3aea79 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -200,10 +200,12 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
-	if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
+	if (gpio_is_valid(mmc_controller->slots[0].switch_pin) &&
+		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
 		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
 					OMAP_PIN_INPUT_PULLUP);
-	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
+	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp) &&
+		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
 		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
 					OMAP_PIN_INPUT_PULLUP);
 	if (cpu_is_omap34xx()) {
-- 
1.7.7.3
