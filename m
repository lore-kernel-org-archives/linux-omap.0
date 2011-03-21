From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Mon, 21 Mar 2011 15:50:20 +0200
Message-ID: <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:64560 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab1CUNv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:51:59 -0400
In-Reply-To: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, tony@atomide.com, heikki.krogerus@nokia.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

This patch allows the ISP1707 USB tranceiver on Nokia
N900 to be disabled when usb cable is disconnected.
This saves approximately 14mA of battery current.

Patch based on work done by Heikki Krogerus on N900
maemo kernel.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   32 ++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..9dd22bc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -41,6 +41,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "cm2xxx_3xxx.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
@@ -48,6 +49,8 @@
 #define RX51_WL1251_POWER_GPIO		87
 #define RX51_WL1251_IRQ_GPIO		42
 
+#define RX51_USB_TRANSCEIVER_RST_GPIO	67
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -534,8 +537,36 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
 	.setup			= rx51_twlgpio_setup,
 };
 
+static void __init rx51_xceiv_init(void)
+{
+	if (gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0)
+		BUG();
+	gpio_direction_output(RX51_USB_TRANSCEIVER_RST_GPIO, 1);
+}
+
+static int rx51_xceiv_power(struct device *dev, int iD, int on)
+{
+	unsigned long	timeout;
+
+	if (!on) {
+		/* Let musb go stdby before powering down the transceiver */
+		timeout = jiffies + msecs_to_jiffies(100);
+		while (!time_after(jiffies, timeout))
+			if (omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
+				& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK)
+				break;
+		if (!(omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
+			& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK))
+			WARN(1, "could not put musb to sleep\n");
+	}
+	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
+
+	return 0;
+}
+
 static struct twl4030_usb_data rx51_usb_data = {
 	.usb_mode		= T2_USB_MODE_ULPI,
+	.phy_power		= rx51_xceiv_power,
 };
 
 static struct twl4030_ins sleep_on_seq[] __initdata = {
@@ -917,6 +948,7 @@ error:
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
+	rx51_xceiv_init();
 	gpmc_onenand_init(board_onenand_data);
 	board_smc91x_init();
 	rx51_add_gpio_keys();
-- 
1.7.1

