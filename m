From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] ARM: OMAP: switch to standard gpio get/set calls
Date: Fri, 28 Nov 2008 17:10:14 -0800
Message-ID: <20081129011013.12337.91016.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57882 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYK2BKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:13 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

This patch replaces some legacy OMAP GPIO calls with the "new" (not
really, any more!) calls that work on most platforms.

The calls addressed by this patch are the simple ones to get and set
values ... for code that's in mainline, including the implementations
of those calls.

Except for the declarations and definitions of those calls, all of
these changes were performed by a simple SED script.  Plus, a few
"if() set() else set()" branches were merged by hand.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c    |    2 +-
 arch/arm/mach-omap1/board-h2.c         |    9 +++------
 arch/arm/mach-omap1/board-h3.c         |    2 +-
 arch/arm/mach-omap1/board-nokia770.c   |   10 +++++-----
 arch/arm/mach-omap1/board-palmte.c     |    6 +++---
 arch/arm/mach-omap1/board-palmtt.c     |    2 +-
 arch/arm/mach-omap1/board-palmz71.c    |    6 +++---
 arch/arm/mach-omap1/board-perseus2.c   |    2 +-
 arch/arm/mach-omap1/board-sx1.c        |    6 +++---
 arch/arm/mach-omap1/board-voiceblue.c  |   20 ++++++++++----------
 arch/arm/mach-omap1/leds-h2p2-debug.c  |   10 +++++-----
 arch/arm/mach-omap1/leds-osk.c         |    4 ++--
 arch/arm/mach-omap2/board-apollon.c    |    2 +-
 arch/arm/plat-omap/debug-leds.c        |   10 +++++-----
 arch/arm/plat-omap/gpio.c              |   21 +++------------------
 arch/arm/plat-omap/include/mach/gpio.h |    2 --
 drivers/mtd/onenand/omap2.c            |    2 +-
 17 files changed, 48 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index db78946..68da313 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -205,7 +205,7 @@ static struct platform_device *devices[] __initdata = {
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
 static struct omap_uart_config fsample_uart_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 3b65914..a2914ac 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -250,11 +250,8 @@ static struct platform_device h2_kp_device = {
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 static int h2_transceiver_mode(struct device *dev, int state)
 {
-	if (state & IR_SIRMODE)
-		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 0);
-	else    /* MIR/FIR */
-		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 1);
-
+	/* SIR when low, else MIR/FIR when HIGH */
+	gpio_set_value(H2_IRDA_FIRSEL_GPIO_PIN, !(state & IR_SIRMODE));
 	return 0;
 }
 #endif
@@ -409,7 +406,7 @@ static struct omap_board_config_kernel h2_config[] __initdata = {
 
 static int h2_nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(H2_NAND_RB_GPIO_PIN);
 }
 
 static void __init h2_init(void)
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index adfcd7b..c524f47 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -498,7 +498,7 @@ static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
+	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
 }
 
 static void __init h3_init(void)
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 38d9783..e0576f5 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -102,7 +102,7 @@ static void mipid_shutdown(struct mipid_platform_data *pdata)
 {
 	if (pdata->nreset_gpio != -1) {
 		printk(KERN_INFO "shutdown LCD\n");
-		omap_set_gpio_dataout(pdata->nreset_gpio, 0);
+		gpio_set_value(pdata->nreset_gpio, 0);
 		msleep(120);
 	}
 }
@@ -130,7 +130,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(ADS7846_PENDOWN_GPIO);
+	return !gpio_get_value(ADS7846_PENDOWN_GPIO);
 }
 
 static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
@@ -228,9 +228,9 @@ static void nokia770_audio_pwr_up(void)
 	/* Turn on codec */
 	aic23_power_up();
 
-	if (omap_get_gpio_datain(HEADPHONE_GPIO))
+	if (gpio_get_value(HEADPHONE_GPIO))
 		/* HP not connected, turn on amplifier */
-		omap_set_gpio_dataout(AMPLIFIER_CTRL_GPIO, 1);
+		gpio_set_value(AMPLIFIER_CTRL_GPIO, 1);
 	else
 		/* HP connected, do not turn on amplifier */
 		printk("HP connected\n");
@@ -250,7 +250,7 @@ static DECLARE_DELAYED_WORK(codec_power_down_work, codec_delayed_power_down);
 static void nokia770_audio_pwr_down(void)
 {
 	/* Turn off amplifier */
-	omap_set_gpio_dataout(AMPLIFIER_CTRL_GPIO, 0);
+	gpio_set_value(AMPLIFIER_CTRL_GPIO, 0);
 
 	/* Turn off codec: schedule delayed work */
 	schedule_delayed_work(&codec_power_down_work, HZ / 20);	/* 50ms */
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index b580436..df663ba 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -255,7 +255,7 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 {
 	int charging, batt, hi, lo, mid;
 
-	charging = !omap_get_gpio_datain(PALMTE_DC_GPIO);
+	charging = !gpio_get_value(PALMTE_DC_GPIO);
 	batt = battery[0];
 	if (charging)
 		batt -= 60;
@@ -335,11 +335,11 @@ static void palmte_headphones_detect(void *data, int state)
 {
 	if (state) {
 		/* Headphones connected, disable speaker */
-		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 0);
+		gpio_set_value(PALMTE_SPEAKER_GPIO, 0);
 		printk(KERN_INFO "PM: speaker off\n");
 	} else {
 		/* Headphones unplugged, re-enable speaker */
-		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 1);
+		gpio_set_value(PALMTE_SPEAKER_GPIO, 1);
 		printk(KERN_INFO "PM: speaker on\n");
 	}
 }
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 40f9860..5c001af 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -268,7 +268,7 @@ static struct platform_device *palmtt_devices[] __initdata = {
 
 static int palmtt_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(6);
+	return !gpio_get_value(6);
 }
 
 static const struct ads7846_platform_data palmtt_ts_info = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e719294..c33766c 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -239,7 +239,7 @@ static struct platform_device *devices[] __initdata = {
 static int
 palmz71_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(PALMZ71_PENIRQ_GPIO);
+	return !gpio_get_value(PALMZ71_PENIRQ_GPIO);
 }
 
 static const struct ads7846_platform_data palmz71_ts_info = {
@@ -295,7 +295,7 @@ static struct omap_board_config_kernel palmz71_config[] __initdata = {
 static irqreturn_t
 palmz71_powercable(int irq, void *dev_id)
 {
-	if (omap_get_gpio_datain(PALMZ71_USBDETECT_GPIO)) {
+	if (gpio_get_value(PALMZ71_USBDETECT_GPIO)) {
 		printk(KERN_INFO "PM: Power cable connected\n");
 		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
 				IRQ_TYPE_EDGE_FALLING);
@@ -323,7 +323,7 @@ palmz71_gpio_setup(int early)
 {
 	if (early) {
 		/* Only set GPIO1 so we have a working serial */
-		omap_set_gpio_dataout(1, 1);
+		gpio_set_value(1, 1);
 		omap_set_gpio_direction(1, 0);
 	} else {
 		/* Set MMC/SD host WP pin as input */
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index b715917..b8f0077 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -205,7 +205,7 @@ static struct platform_device *devices[] __initdata = {
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
 static struct omap_uart_config perseus2_uart_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 130bcc6..2230527 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -440,9 +440,9 @@ static void __init omap_sx1_init(void)
 	omap_set_gpio_direction(11, 0);/* gpio11 -> output */
 	omap_set_gpio_direction(15, 0);/* gpio15 -> output */
 	/* set GPIO data */
-	omap_set_gpio_dataout(1, 1);/*A_IRDA_OFF = 1 */
-	omap_set_gpio_dataout(11, 0);/*A_SWITCH = 0 */
-	omap_set_gpio_dataout(15, 0);/*A_USB_ON = 0 */
+	gpio_set_value(1, 1);/*A_IRDA_OFF = 1 */
+	gpio_set_value(11, 0);/*A_SWITCH = 0 */
+	gpio_set_value(15, 0);/*A_USB_ON = 0 */
 
 }
 /*----------------------------------------*/
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 45a0131..d7ab11a 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -172,16 +172,16 @@ static void __init voiceblue_init(void)
 	/* smc91x reset */
 	omap_request_gpio(7);
 	omap_set_gpio_direction(7, 0);
-	omap_set_gpio_dataout(7, 1);
+	gpio_set_value(7, 1);
 	udelay(2);	/* wait at least 100ns */
-	omap_set_gpio_dataout(7, 0);
+	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
 	/* smc91x interrupt pin */
 	omap_request_gpio(8);
 	/* 16C554 reset*/
 	omap_request_gpio(6);
 	omap_set_gpio_direction(6, 0);
-	omap_set_gpio_dataout(6, 0);
+	gpio_set_value(6, 0);
 	/* 16C554 interrupt pins */
 	omap_request_gpio(12);
 	omap_request_gpio(13);
@@ -245,17 +245,17 @@ static int wdt_gpio_state;
 void voiceblue_wdt_enable(void)
 {
 	omap_set_gpio_direction(0, 0);
-	omap_set_gpio_dataout(0, 0);
-	omap_set_gpio_dataout(0, 1);
-	omap_set_gpio_dataout(0, 0);
+	gpio_set_value(0, 0);
+	gpio_set_value(0, 1);
+	gpio_set_value(0, 0);
 	wdt_gpio_state = 0;
 }
 
 void voiceblue_wdt_disable(void)
 {
-	omap_set_gpio_dataout(0, 0);
-	omap_set_gpio_dataout(0, 1);
-	omap_set_gpio_dataout(0, 0);
+	gpio_set_value(0, 0);
+	gpio_set_value(0, 1);
+	gpio_set_value(0, 0);
 	omap_set_gpio_direction(0, 1);
 }
 
@@ -265,7 +265,7 @@ void voiceblue_wdt_ping(void)
 		return;
 
 	wdt_gpio_state = !wdt_gpio_state;
-	omap_set_gpio_dataout(0, wdt_gpio_state);
+	gpio_set_value(0, wdt_gpio_state);
 }
 
 void voiceblue_reset(void)
diff --git a/arch/arm/mach-omap1/leds-h2p2-debug.c b/arch/arm/mach-omap1/leds-h2p2-debug.c
index 71fe2cc..17c9d0e 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -65,8 +65,8 @@ void h2p2_dbg_leds_event(led_event_t evt)
 		/* all leds off during suspend or shutdown */
 
 		if (! machine_is_omap_perseus2()) {
-			omap_set_gpio_dataout(GPIO_TIMER, 0);
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_TIMER, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 		}
 
 		__raw_writew(~0, &fpga->leds);
@@ -94,7 +94,7 @@ void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2())
 			hw_led_state ^= H2P2_DBG_FPGA_P2_LED_TIMER;
 		else {
-			omap_set_gpio_dataout(GPIO_TIMER, led_state & LED_TIMER_ON);
+			gpio_set_value(GPIO_TIMER, led_state & LED_TIMER_ON);
 			goto done;
 		}
 
@@ -106,7 +106,7 @@ void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2())
 			hw_led_state |= H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 1);
+			gpio_set_value(GPIO_IDLE, 1);
 			goto done;
 		}
 
@@ -116,7 +116,7 @@ void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2())
 			hw_led_state &= ~H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 			goto done;
 		}
 
diff --git a/arch/arm/mach-omap1/leds-osk.c b/arch/arm/mach-omap1/leds-osk.c
index 98e7896..499d7ad 100644
--- a/arch/arm/mach-omap1/leds-osk.c
+++ b/arch/arm/mach-omap1/leds-osk.c
@@ -44,8 +44,8 @@ static void mistral_setled(void)
 		green = 1;
 	/* else both sides are disabled */
 
-	omap_set_gpio_dataout(GPIO_LED_GREEN, green);
-	omap_set_gpio_dataout(GPIO_LED_RED, red);
+	gpio_set_value(GPIO_LED_GREEN, green);
+	gpio_set_value(GPIO_LED_RED, red);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 989ad15..a4ba52c 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -361,7 +361,7 @@ static void __init apollon_usb_init(void)
 	omap_cfg_reg(P21_242X_GPIO12);
 	omap_request_gpio(12);
 	omap_set_gpio_direction(12, 0);		/* OUT */
-	omap_set_gpio_dataout(12, 0);
+	gpio_set_value(12, 0);
 }
 
 static void __init omap_apollon_init(void)
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 2f4c0ca..be4eefd 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -83,8 +83,8 @@ static void h2p2_dbg_leds_event(led_event_t evt)
 		/* all leds off during suspend or shutdown */
 
 		if (!(machine_is_omap_perseus2() || machine_is_omap_h4())) {
-			omap_set_gpio_dataout(GPIO_TIMER, 0);
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_TIMER, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 		}
 
 		__raw_writew(~0, &fpga->leds);
@@ -107,7 +107,7 @@ static void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state ^= H2P2_DBG_FPGA_P2_LED_TIMER;
 		else {
-			omap_set_gpio_dataout(GPIO_TIMER,
+			gpio_set_value(GPIO_TIMER,
 					led_state & LED_TIMER_ON);
 			goto done;
 		}
@@ -121,7 +121,7 @@ static void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state &= ~H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 1);
+			gpio_set_value(GPIO_IDLE, 1);
 			goto done;
 		}
 
@@ -131,7 +131,7 @@ static void h2p2_dbg_leds_event(led_event_t evt)
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state |= H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 			goto done;
 		}
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e07ab23..c0322b5 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -407,20 +407,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	__raw_writel(l, reg);
 }
 
-void omap_set_gpio_dataout(int gpio, int enable)
-{
-	struct gpio_bank *bank;
-	unsigned long flags;
-
-	if (check_gpio(gpio) < 0)
-		return;
-	bank = get_gpio_bank(gpio);
-	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_dataout(bank, get_gpio_index(gpio), enable);
-	spin_unlock_irqrestore(&bank->lock, flags);
-}
-
-int omap_get_gpio_datain(int gpio)
+static int __omap_get_gpio_datain(int gpio)
 {
 	struct gpio_bank *bank;
 	void __iomem *reg;
@@ -1258,7 +1245,7 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return omap_get_gpio_datain(chip->base + offset);
+	return __omap_get_gpio_datain(chip->base + offset);
 }
 
 static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
@@ -1755,8 +1742,6 @@ static int __init omap_gpio_sysinit(void)
 EXPORT_SYMBOL(omap_request_gpio);
 EXPORT_SYMBOL(omap_free_gpio);
 EXPORT_SYMBOL(omap_set_gpio_direction);
-EXPORT_SYMBOL(omap_set_gpio_dataout);
-EXPORT_SYMBOL(omap_get_gpio_datain);
 
 arch_initcall(omap_gpio_sysinit);
 
@@ -1814,7 +1799,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 				continue;
 
 			irq = bank->virtual_irq_start + j;
-			value = omap_get_gpio_datain(gpio);
+			value = gpio_get_value(gpio);
 			is_in = gpio_is_input(bank, mask);
 
 			if (bank_is_mpuio(bank))
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 5f996f3..d91ba32 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -74,8 +74,6 @@ extern int omap_gpio_init(void);	/* Call from board init only */
 extern int omap_request_gpio(int gpio);
 extern void omap_free_gpio(int gpio);
 extern void omap_set_gpio_direction(int gpio, int is_input);
-extern void omap_set_gpio_dataout(int gpio, int enable);
-extern int omap_get_gpio_datain(int gpio);
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index e39b21d..8dda06c 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -150,7 +150,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 
 		INIT_COMPLETION(c->irq_done);
 		if (c->gpio_irq) {
-			result = omap_get_gpio_datain(c->gpio_irq);
+			result = gpio_get_value(c->gpio_irq);
 			if (result == -1) {
 				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 				intr = read_reg(c, ONENAND_REG_INTERRUPT);

