From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 7/8] twl4030 gpio platform data
Date: Fri, 26 Sep 2008 12:41:00 +0300
Message-ID: <1222422061-3940-8-git-send-email-felipe.balbi@nokia.com>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-7-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38316 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbYIZJl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 05:41:56 -0400
In-Reply-To: <1222422061-3940-7-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Define platform data for configuring TWL4030 GPIOs,
and provide it for all boards using these chips.

For now all boards use the same fixed assignments for
GPIO and IRQ numbers.  Eventually we should be able
to shuffle them without changing platform headers.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c     |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c     |    7 +++++++
 arch/arm/mach-omap2/board-ldp.c         |    7 +++++++
 arch/arm/mach-omap2/board-omap2evm.c    |    7 +++++++
 arch/arm/mach-omap2/board-omap3beagle.c |   12 ++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c    |    7 +++++++
 arch/arm/mach-omap2/board-overo.c       |    7 +++++++
 include/linux/i2c/twl4030.h             |   24 +++++++++++++++++++++---
 8 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index f35c252..0deaf09 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -345,6 +345,12 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 };
 
 
+static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_usb_data sdp2430_usb_data = {
 	.usb_mode	= T2_MODE_ULPI,
 };
@@ -354,6 +360,7 @@ static struct twl4030_platform_data sdp2430_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &sdp2430_gpio_data,
 	.keypad		= &sdp2430_kp_data,
 	.usb		= &sdp2430_usb_data,
 };
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e0c39c2..66f0f98 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -300,6 +300,12 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_usb_data sdp3430_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -309,6 +315,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &sdp3430_gpio_data,
 	.keypad		= &sdp3430_kp_data,
 	.usb		= &sdp3430_usb_data,
 };
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 219579b..48342f4 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -187,12 +187,19 @@ static struct twl4030_usb_data ldp_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_gpio_platform_data ldp_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.usb		= &ldp_usb_data,
+	.gpio		= &ldp_gpio_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index be8348d..a921cf1 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -226,6 +226,12 @@ static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
 };
 
+static struct twl4030_gpio_platform_data omap2evm_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_usb_data omap2evm_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -237,6 +243,7 @@ static struct twl4030_platform_data omap2evm_twldata = {
 	/* platform_data for children goes here */
 	.keypad		= &omap2evm_kp_data,
 	.usb		= &omap2evm_usb_data,
+	.gpio		= &omap2evm_gpio_data,
 };
 
 static struct i2c_board_info __initdata omap2evm_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ae677b9..aa5e9a6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -114,12 +114,24 @@ static struct twl4030_usb_data beagle_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct twl4030_gpio_platform_data beagle_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+
+	/* REVISIT:  setup() should use twl gpio index
+	 *  - 0 as MMC card detect,
+	 *  - 1 as EHCI port overcurrent (active low)
+	 */
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
+	.gpio		= &beagle_gpio_data,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 158138c..2c1d76f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -90,6 +90,12 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_usb_data omap3evm_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -129,6 +135,7 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	/* platform_data for children goes here */
 	.keypad		= &omap3evm_kp_data,
 	.usb		= &omap3evm_usb_data,
+	.gpio		= &omap3evm_gpio_data,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index a41e6fa..9c1709a 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -146,9 +146,16 @@ static struct omap_uart_config overo_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_gpio_platform_data overo_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+};
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+	.gpio		= &overo_gpio_data,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 8a12ff0..b80e8b6 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -52,6 +52,21 @@
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
 
+
+/* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
+struct twl4030_gpio_platform_data {
+	int		gpio_base;
+	unsigned	irq_base, irq_end;
+
+	/* for gpio-N, bit (1 << N) is set if pullup should be used */
+	u32		pullups;
+
+	int		(*setup)(struct device *dev,
+				unsigned gpio, unsigned ngpio);
+	int		(*teardown)(struct device *dev,
+				unsigned gpio, unsigned ngpio);
+};
+
 struct twl4030_keypad_data {
 	int rows;
 	int cols;
@@ -71,9 +86,10 @@ struct twl4030_usb_data {
 };
 
 struct twl4030_platform_data {
-	unsigned	irq_base, irq_end;
-	struct twl4030_keypad_data *keypad;
-	struct twl4030_usb_data *usb;
+	unsigned				irq_base, irq_end;
+	struct twl4030_gpio_platform_data	*gpio;
+	struct twl4030_keypad_data		*keypad;
+	struct twl4030_usb_data			*usb;
 
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
@@ -151,6 +167,8 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, u8 num_bytes);
 
 /*
  * Exported TWL4030 GPIO APIs
+ *
+ * WARNING -- use standard GPIO and IRQ calls instead; these will vanish.
  */
 int twl4030_get_gpio_datain(int gpio);
 int twl4030_request_gpio(int gpio);
-- 
1.6.0.2.307.gc427

