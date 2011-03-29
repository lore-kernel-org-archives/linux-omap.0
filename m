From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Tue, 29 Mar 2011 16:28:00 +0300
Message-ID: <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:51094 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab1C2N3d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 09:29:33 -0400
In-Reply-To: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, cbouatmailru@gmail.com
Cc: balbi@ti.com, heikki.krogerus@nokia.com, sshtylyov@mvista.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The isp1704 usb tranceiver is used for charging and can be
disabled when not in use. Provide the powering routine to
the driver via platform data.

Also changed the indent of ".name" variable in rx51_charger_device
definition to use tabs same way as the new ".dev" variable indent.
Put this in the same patch since the indent fix is only needed
when there are multiple members in the struct definition.

Loosely based on earlier patches from Heikki Krogerus in
Nokia N900 maemo kernel.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   27 ++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..fad98ab 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
+#include <linux/power/isp1704_charger.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
@@ -52,6 +53,8 @@
 #define RX51_FMTX_RESET_GPIO		163
 #define RX51_FMTX_IRQ			53
 
+#define RX51_USB_TRANSCEIVER_RST_GPIO	67
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -110,10 +113,30 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	},
 };
 
+static void rx51_charger_set_power(bool on)
+{
+	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
+}
+
+static struct isp1704_charger_data rx51_charger_data = {
+	.set_power	= rx51_charger_set_power,
+};
+
 static struct platform_device rx51_charger_device = {
-	.name = "isp1704_charger",
+	.name	= "isp1704_charger",
+	.dev	= {
+		.platform_data = &rx51_charger_data,
+	},
 };
 
+static void __init rx51_charger_init(void)
+{
+	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
+		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
+
+	platform_device_register(&rx51_charger_device);
+}
+
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 
 #define RX51_GPIO_CAMERA_LENS_COVER	110
@@ -981,6 +1004,6 @@ void __init rx51_peripherals_init(void)
 	if (partition)
 		omap2_hsmmc_init(mmc);
 
-	platform_device_register(&rx51_charger_device);
+	rx51_charger_init();
 }
 
-- 
1.7.1

