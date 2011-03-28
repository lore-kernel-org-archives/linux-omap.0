From: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 09:33:05 +0300
Message-ID: <1301293985-21687-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1301293985-21687-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301293985-21687-1-git-send-email-kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The isp1704 usb tranceiver is used for charging and can be
disabled when not in use. Provide the powering routine to
the driver via platform data.

Loosely based on earlier patches from Heikki Krogerus in
Nokia N900 maemo kernel.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Heikki Krogerus <heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   27 ++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..8584dd8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
+#include <linux/power/isp1704_charger.h>
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
@@ -48,6 +49,8 @@
 #define RX51_WL1251_POWER_GPIO		87
 #define RX51_WL1251_IRQ_GPIO		42
 
+#define RX51_USB_TRANSCEIVER_RST_GPIO	67
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -106,10 +109,30 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
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
+	BUG_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
+		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
+
+	platform_device_register(&rx51_charger_device);
+}
+
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 
 #define RX51_GPIO_CAMERA_LENS_COVER	110
@@ -928,6 +951,6 @@ void __init rx51_peripherals_init(void)
 	if (partition)
 		omap2_hsmmc_init(mmc);
 
-	platform_device_register(&rx51_charger_device);
+	rx51_charger_init();
 }
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
