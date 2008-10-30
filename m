From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 2/4] use gpio_direction_input (OMAP tree only)
Date: Wed, 29 Oct 2008 20:41:17 -0700
Message-ID: <200810292041.17697.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:32987 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752990AbYJ3Do1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 23:44:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More switchover to the cross-platform GPIO interface:
use gpio_direction_input(), not an OMAP-specific call,
for code that has NOT merged to mainline.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 arch/arm/mach-omap2/board-2430sdp.c    |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c    |    4 ++--
 arch/arm/mach-omap2/board-apollon.c    |    2 +-
 arch/arm/mach-omap2/board-ldp.c        |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c   |    4 ++--
 arch/arm/plat-omap/gpio-switch.c       |    5 ++++-
 drivers/bluetooth/brf6150.c            |    2 +-
 drivers/bluetooth/hci_h4p/core.c       |    2 +-
 drivers/cbus/cbus.c                    |    4 ++--
 drivers/cbus/retu.c                    |    2 +-
 drivers/cbus/tahvo.c                   |    2 +-
 drivers/input/touchscreen/omap/ts_hx.c |    2 +-
 drivers/input/touchscreen/tsc2005.c    |    2 +-
 13 files changed, 19 insertions(+), 16 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -216,7 +216,7 @@ static void ads7846_dev_init(void)
 	if (omap_request_gpio(TS_GPIO) < 0)
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 
-	omap_set_gpio_direction(TS_GPIO, 1);
+	gpio_direction_input(TS_GPIO);
 
 	omap_set_gpio_debounce(TS_GPIO, 1);
 	omap_set_gpio_debounce_time(TS_GPIO, 0xa);
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -170,7 +170,7 @@ static void ads7846_dev_init(void)
 		return;
 	}
 
-	omap_set_gpio_direction(ts_gpio, 1);
+	gpio_direction_input(ts_gpio);
 
 	omap_set_gpio_debounce(ts_gpio, 1);
 	omap_set_gpio_debounce_time(ts_gpio, 0xa);
@@ -278,7 +278,7 @@ static inline void __init sdp3430_init_s
 			eth_gpio);
 		return;
 	}
-	omap_set_gpio_direction(eth_gpio, 1);
+	gpio_direction_input(eth_gpio);
 }
 
 static void __init omap_3430sdp_init_irq(void)
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -314,7 +314,7 @@ static inline void __init apollon_init_s
 		gpmc_cs_free(eth_cs);
 		goto out;
 	}
-	omap_set_gpio_direction(APOLLON_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(APOLLON_ETHR_GPIO_IRQ);
 
 out:
 	clk_disable(gpmc_fck);
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -99,7 +99,7 @@ static void ads7846_dev_init(void)
 		return;
 	}
 
-	omap_set_gpio_direction(ts_gpio, 1);
+	gpio_direction_input(ts_gpio);
 
 	omap_set_gpio_debounce(ts_gpio, 1);
 	omap_set_gpio_debounce_time(ts_gpio, 0xa);
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -81,7 +81,7 @@ static inline void __init omap3evm_init_
 		return;
 	}
 
-	omap_set_gpio_direction(OMAP3EVM_ETHR_GPIO_IRQ, 1);
+	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
 static struct omap_uart_config omap3_evm_uart_config __initdata = {
@@ -174,7 +174,7 @@ static void ads7846_dev_init(void)
 	if (omap_request_gpio(OMAP3_EVM_TS_GPIO) < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
-	omap_set_gpio_direction(OMAP3_EVM_TS_GPIO, 1);
+	gpio_direction_input(OMAP3_EVM_TS_GPIO);
 
 	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
 	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -286,7 +286,10 @@ static int __init new_switch(struct gpio
 
 	/* input: 1, output: 0 */
 	direction = !(sw->flags & OMAP_GPIO_SWITCH_FLAG_OUTPUT);
-	omap_set_gpio_direction(sw->gpio, direction);
+	if (direction)
+		gpio_direction_input(sw->gpio);
+	else
+		gpio_direction_output(sw->gpio, true);
 
 	sw->state = gpio_sw_get_state(sw);
 
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -945,7 +945,7 @@ static int __init brf6150_init(void)
 
 	omap_set_gpio_direction(info->btinfo->reset_gpio, 0);
 	omap_set_gpio_direction(info->btinfo->bt_wakeup_gpio, 0);
-	omap_set_gpio_direction(info->btinfo->host_wakeup_gpio, 1);
+	gpio_direction_input(info->btinfo->host_wakeup_gpio);
 	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
 	switch (info->btinfo->bt_uart) {
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -854,7 +854,7 @@ static int hci_h4p_probe(struct platform
 
 	omap_set_gpio_direction(info->reset_gpio, 0);
 	omap_set_gpio_direction(info->bt_wakeup_gpio, 0);
-	omap_set_gpio_direction(info->host_wakeup_gpio, 1);
+	gpio_direction_input(info->host_wakeup_gpio);
 
 	switch (bt_config->bt_uart) {
 	case 1:
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -112,7 +112,7 @@ static void _cbus_send_bit(struct cbus_h
 
 	/* The data bit is read on the rising edge of CLK */
 	if (set_to_input)
-		omap_set_gpio_direction(host->dat_gpio, 1);
+		gpio_direction_input(host->dat_gpio);
 
 	gpio_set_value(host->clk_gpio, 0);
 }
@@ -264,7 +264,7 @@ int __init cbus_bus_init(void)
 	gpio_set_value(chost->sel_gpio, 1);
 
 	omap_set_gpio_direction(chost->clk_gpio, 0);
-	omap_set_gpio_direction(chost->dat_gpio, 1);
+	gpio_direction_input(chost->dat_gpio);
 	omap_set_gpio_direction(chost->sel_gpio, 0);
 
 	gpio_set_value(chost->clk_gpio, 1);
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -341,7 +341,7 @@ static int __devinit retu_probe(struct d
 	}
 
 	/* Set the pin as input */
-	omap_set_gpio_direction(retu_irq_pin, 1);
+	gpio_direction_input(retu_irq_pin);
 
 	/* Rising edge triggers the IRQ */
 	set_irq_type(OMAP_GPIO_IRQ(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -328,7 +328,7 @@ static int __devinit tahvo_probe(struct 
 	}
 
 	/* Set the pin as input */
-	omap_set_gpio_direction(tahvo_irq_pin, 1);
+	gpio_direction_input(tahvo_irq_pin);
 
 	/* Rising edge triggers the IRQ */
 	set_irq_type(OMAP_GPIO_IRQ(tahvo_irq_pin), IRQ_TYPE_EDGE_RISING);
--- a/drivers/input/touchscreen/omap/ts_hx.c
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -97,7 +97,7 @@ static int __init hx_ts_probe(struct oma
 		return -EINVAL;
 	};
 
-	omap_set_gpio_direction(gpio, 1);
+	gpio_direction_input(gpio);
 	ts->irq_type = IRQF_TRIGGER_FALLING;
 	return 0;
 }
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -540,7 +540,7 @@ static int __devinit tsc2005_ts_init(str
 		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
 		goto err1;
 	}
-	omap_set_gpio_direction(dav_gpio, 1);
+	gpio_direction_input(dav_gpio);
 	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
 #endif
