From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio calls
Date: Wed, 7 Jan 2009 13:17:45 +0200
Message-ID: <20090107111744.GH27566@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50818 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbZAGLRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 06:17:45 -0500
Content-Disposition: inline
In-Reply-To: <20090107111615.GG27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Wed, 7 Jan 2009 12:54:34 +0200
Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls

Fix compile by removing remaining omap specific gpio
calls. Based on earlier patches by Jarkko Nikula.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 8171fe0..09a2422 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -423,9 +423,9 @@ static void __init omap_sx1_init(void)
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
-	omap_request_gpio(1);	/* A_IRDA_OFF */
-	omap_request_gpio(11);	/* A_SWITCH */
-	omap_request_gpio(15);	/* A_USB_ON */
+	gpio_request(1, "A_IRDA_OFF");
+	gpio_request(11, "A_SWITCH");
+	gpio_request(15, "A_USB_ON");
 	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
 	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
 	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index bf1e5d3..a328fcc 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -126,8 +126,8 @@ static struct resource apollon_smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= OMAP_GPIO_IRQ(APOLLON_ETHR_GPIO_IRQ),
-		.end	= OMAP_GPIO_IRQ(APOLLON_ETHR_GPIO_IRQ),
+		.start	= gpio_to_irq(APOLLON_ETHR_GPIO_IRQ),
+		.end	= gpio_to_irq(APOLLON_ETHR_GPIO_IRQ),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -282,31 +282,28 @@ static void __init apollon_led_init(void)
 {
 	/* LED0 - AA10 */
 	omap_cfg_reg(AA10_242X_GPIO13);
-	omap_request_gpio(LED0_GPIO13);
-	omap_set_gpio_direction(LED0_GPIO13, 0);
-	omap_set_gpio_dataout(LED0_GPIO13, 0);
+	gpio_request(LED0_GPIO13, "LED0");
+	gpio_direction_output(LED0_GPIO13, 0);
 	/* LED1  - AA6 */
 	omap_cfg_reg(AA6_242X_GPIO14);
-	omap_request_gpio(LED1_GPIO14);
-	omap_set_gpio_direction(LED1_GPIO14, 0);
-	omap_set_gpio_dataout(LED1_GPIO14, 0);
+	gpio_request(LED1_GPIO14, "LED1");
+	gpio_direction_output(LED1_GPIO14, 0);
 	/* LED2  - AA4 */
 	omap_cfg_reg(AA4_242X_GPIO15);
-	omap_request_gpio(LED2_GPIO15);
-	omap_set_gpio_direction(LED2_GPIO15, 0);
-	omap_set_gpio_dataout(LED2_GPIO15, 0);
+	gpio_request(LED2_GPIO15, "LED2");
+	gpio_direction_output(LED2_GPIO15, 0);
 }
 
 static irqreturn_t apollon_sw_interrupt(int irq, void *ignored)
 {
 	static unsigned int led0, led1, led2;
 
-	if (irq == OMAP_GPIO_IRQ(SW_ENTER_GPIO16))
-		omap_set_gpio_dataout(LED0_GPIO13, led0 ^= 1);
-	else if (irq == OMAP_GPIO_IRQ(SW_UP_GPIO17))
-		omap_set_gpio_dataout(LED1_GPIO14, led1 ^= 1);
-	else if (irq == OMAP_GPIO_IRQ(SW_DOWN_GPIO58))
-		omap_set_gpio_dataout(LED2_GPIO15, led2 ^= 1);
+	if (irq == gpio_to_irq(SW_ENTER_GPIO16))
+		gpio_set_value(LED0_GPIO13, led0 ^= 1);
+	else if (irq == gpio_to_irq(SW_UP_GPIO17))
+		gpio_set_value(LED1_GPIO14, led1 ^= 1);
+	else if (irq == gpio_to_irq(SW_DOWN_GPIO58))
+		gpio_set_value(LED2_GPIO15, led2 ^= 1);
 
 	return IRQ_HANDLED;
 }
@@ -315,29 +312,29 @@ static void __init apollon_sw_init(void)
 {
 	/* Enter SW - Y11 */
 	omap_cfg_reg(Y11_242X_GPIO16);
-	omap_request_gpio(SW_ENTER_GPIO16);
+	gpio_request(SW_ENTER_GPIO16, "Enter SW");
 	gpio_direction_input(SW_ENTER_GPIO16);
 	/* Up SW - AA12 */
 	omap_cfg_reg(AA12_242X_GPIO17);
-	omap_request_gpio(SW_UP_GPIO17);
+	gpio_request(SW_UP_GPIO17, "Up SW");
 	gpio_direction_input(SW_UP_GPIO17);
 	/* Down SW - AA8 */
 	omap_cfg_reg(AA8_242X_GPIO58);
-	omap_request_gpio(SW_DOWN_GPIO58);
+	gpio_request(SW_DOWN_GPIO58, "Down SW");
 	gpio_direction_input(SW_DOWN_GPIO58);
 
-	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
+	set_irq_type(gpio_to_irq(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
+	if (request_irq(gpio_to_irq(SW_ENTER_GPIO16), &apollon_sw_interrupt,
 				IRQF_SHARED, "enter sw",
 				&apollon_sw_interrupt))
 		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_UP_GPIO17), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_UP_GPIO17), &apollon_sw_interrupt,
+	set_irq_type(gpio_to_irq(SW_UP_GPIO17), IRQ_TYPE_EDGE_RISING);
+	if (request_irq(gpio_to_irq(SW_UP_GPIO17), &apollon_sw_interrupt,
 				IRQF_SHARED, "up sw",
 				&apollon_sw_interrupt))
 		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), &apollon_sw_interrupt,
+	set_irq_type(gpio_to_irq(SW_DOWN_GPIO58), IRQ_TYPE_EDGE_RISING);
+	if (request_irq(gpio_to_irq(SW_DOWN_GPIO58), &apollon_sw_interrupt,
 				IRQF_SHARED, "down sw",
 				&apollon_sw_interrupt))
 		return;
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index aa69727..f6a1345 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -88,7 +88,7 @@ static inline void __init ldp_init_smc911x(void)
 
 	ldp_smc911x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
 
-	if (omap_request_gpio(eth_gpio) < 0) {
+	if (gpio_request(eth_gpio, "smc911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
 				eth_gpio);
 		return;
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 04e68e8..8d9dfe3 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -87,16 +87,6 @@ extern void omap_set_gpio_debounce_time(int gpio, int enable);
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-static inline int omap_request_gpio(int gpio)
-{
-	return gpio_request(gpio, "FIXME");
-}
-
-static inline void omap_free_gpio(int gpio)
-{
-	gpio_free(gpio);
-}
-
 static inline int gpio_get_value(unsigned gpio)
 {
 	return __gpio_get_value(gpio);
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 96ecc17..77a4f14 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -629,7 +629,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	}
 
 	if (c->gpio_irq) {
-		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
+		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
@@ -726,7 +726,7 @@ err_release_dma:
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
-		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 err_iounmap:
 	iounmap(c->onenand.base);
 err_release_mem_region:
@@ -761,7 +761,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
 		free_irq(gpio_to_irq(c->gpio_irq), c);
-		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);
 	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
