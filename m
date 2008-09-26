From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7-omap-git 1/2] twl4030 gpio platform data
Date: Thu, 25 Sep 2008 19:39:39 -0700
Message-ID: <200809251939.39774.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:38503 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752844AbYIZCjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 22:39:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Define platform data for configuring TWL4030 GPIOs,
and provide it for all boards using these chips.

For now all boards use the same fixed assignments for
GPIO and IRQ numbers.  Eventually we should be able
to shuffle them without changing platform headers.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
This goes in before code using this data ... so that git
bisection can work.

 arch/arm/mach-omap2/board-2430sdp.c     |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c     |    7 +++++++
 arch/arm/mach-omap2/board-ldp.c         |    7 +++++++
 arch/arm/mach-omap2/board-omap2evm.c    |    7 +++++++
 arch/arm/mach-omap2/board-omap3beagle.c |   12 ++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c    |    7 +++++++
 arch/arm/mach-omap2/board-overo.c       |    7 +++++++
 include/linux/i2c/twl4030.h             |   24 +++++++++++++++++++++---
 8 files changed, 75 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -345,6 +345,12 @@ static struct omap_board_config_kernel s
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
@@ -354,6 +360,7 @@ static struct twl4030_platform_data sdp2
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &sdp2430_gpio_data,
 	.keypad		= &sdp2430_kp_data,
 	.usb		= &sdp2430_usb_data,
 };
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -300,6 +300,12 @@ static struct omap_board_config_kernel s
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
@@ -309,6 +315,7 @@ static struct twl4030_platform_data sdp3
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &sdp3430_gpio_data,
 	.keypad		= &sdp3430_kp_data,
 	.usb		= &sdp3430_usb_data,
 };
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -183,9 +183,16 @@ static struct omap_board_config_kernel l
 	{ OMAP_TAG_UART,	&ldp_uart_config },
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
+	.gpio		= &ldp_gpio_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -226,6 +226,12 @@ static struct omap_board_config_kernel o
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
@@ -235,6 +241,7 @@ static struct twl4030_platform_data omap
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &omap2evm_gpio_data,
 	.keypad		= omap2evm_kp_data,
 	.usb		= &omap2evm_usb_data,
 };
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -110,9 +110,21 @@ static struct omap_uart_config omap3_bea
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
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
+	.gpio		= &beagle_gpio_data,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -90,6 +90,12 @@ static struct omap_uart_config omap3_evm
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
@@ -99,6 +105,7 @@ static struct twl4030_platform_data omap
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.gpio		= &omap3evm_gpio_data,
 	.keypad		= omap3evm_kp_data,
 };
 
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -146,9 +146,16 @@ static struct omap_uart_config overo_uar
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
@@ -151,6 +167,8 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 
 /*
  * Exported TWL4030 GPIO APIs
+ *
+ * WARNING -- use standard GPIO and IRQ calls instead; these will vanish.
  */
 int twl4030_get_gpio_datain(int gpio);
 int twl4030_request_gpio(int gpio);
