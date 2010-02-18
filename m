From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/7] OMAP3: RX-51: support sleep indicator LEDs
Date: Wed, 17 Feb 2010 18:02:27 -0600
Message-ID: <1266451350-4480-5-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The sleep indicator LEDs can be enabled/disabled by toggling GPIO162.
Use the LED GPIO class to export this LED functionality to userspace.

To enable:

  # echo 1 > /sys/class/leds/sleep_ind/brightness

To disable:

  # echo 0 > /sys/class/leds/sleep_ind/brightness

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-rx51.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 6a49f91..26b70da 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -31,8 +32,30 @@
 
 #include "mux.h"
 
+#define RX51_GPIO_SLEEP_IND 162
+
 struct omap_sdrc_params *rx51_get_sdram_timings(void);
 
+static struct gpio_led gpio_leds[] = {
+	{
+		.name	= "sleep_ind",
+		.gpio	= RX51_GPIO_SLEEP_IND,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -88,6 +111,8 @@ static void __init rx51_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
+
+	platform_device_register(&leds_gpio);
 }
 
 static void __init rx51_map_io(void)
-- 
1.6.6
