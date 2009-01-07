From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio
	calls, v2
Date: Wed, 7 Jan 2009 19:50:21 +0200
Message-ID: <20090107175020.GU27566@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107161843.GA11471@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57091 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbZAGRub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 12:50:31 -0500
Content-Disposition: inline
In-Reply-To: <20090107161843.GA11471@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090107 18:18]:
> On Wed, Jan 07, 2009 at 01:17:45PM +0200, Tony Lindgren wrote:
> > -	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> > -	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
> > +	set_irq_type(gpio_to_irq(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> > +	if (request_irq(gpio_to_irq(SW_ENTER_GPIO16), &apollon_sw_interrupt,
> 
> NAK.  I wonder how the f*** this got anywhere near the mainline kernel.
> No no no no no.  set_irq_type + request_irq is utter crap and should be
> rejected whenever its seen.  There's absolutely no need for it -
> request_irq is sufficient.  Get rid of this set_irq_type usage from
> everywhere please.

Blind search and replace? :) I've removed the GPIO key code as there's
already a patch to do that cleaner with gpio_keys.

Looks like there are still few places where gpio_request() and then
set_irq_type() is called in the board-*.c files, and then the irq is
passed to the driver which does request_irq().

Tony

--GRPZ8SYKNexpdSJ7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-gpio-v2.patch"

>From 4afb512f6a37d9ca87fb3e8d2f423ce3eaf7e407 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Wed, 7 Jan 2009 12:54:34 +0200
Subject: [PATCH] ARM: OMAP: Fix gpio by switching to generic gpio calls, v2

Fix compile by removing remaining omap specific gpio
calls. Based on earlier patches by Jarkko Nikula.

Also remove old GPIO key code, there is already a patch
to do this with gpio_keys.

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
index bf1e5d3..0a7b24b 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -22,8 +22,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
 #include <linux/err.h>
@@ -282,65 +280,16 @@ static void __init apollon_led_init(void)
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
-}
-
-static irqreturn_t apollon_sw_interrupt(int irq, void *ignored)
-{
-	static unsigned int led0, led1, led2;
-
-	if (irq == OMAP_GPIO_IRQ(SW_ENTER_GPIO16))
-		omap_set_gpio_dataout(LED0_GPIO13, led0 ^= 1);
-	else if (irq == OMAP_GPIO_IRQ(SW_UP_GPIO17))
-		omap_set_gpio_dataout(LED1_GPIO14, led1 ^= 1);
-	else if (irq == OMAP_GPIO_IRQ(SW_DOWN_GPIO58))
-		omap_set_gpio_dataout(LED2_GPIO15, led2 ^= 1);
-
-	return IRQ_HANDLED;
-}
-
-static void __init apollon_sw_init(void)
-{
-	/* Enter SW - Y11 */
-	omap_cfg_reg(Y11_242X_GPIO16);
-	omap_request_gpio(SW_ENTER_GPIO16);
-	gpio_direction_input(SW_ENTER_GPIO16);
-	/* Up SW - AA12 */
-	omap_cfg_reg(AA12_242X_GPIO17);
-	omap_request_gpio(SW_UP_GPIO17);
-	gpio_direction_input(SW_UP_GPIO17);
-	/* Down SW - AA8 */
-	omap_cfg_reg(AA8_242X_GPIO58);
-	omap_request_gpio(SW_DOWN_GPIO58);
-	gpio_direction_input(SW_DOWN_GPIO58);
-
-	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
-				IRQF_SHARED, "enter sw",
-				&apollon_sw_interrupt))
-		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_UP_GPIO17), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_UP_GPIO17), &apollon_sw_interrupt,
-				IRQF_SHARED, "up sw",
-				&apollon_sw_interrupt))
-		return;
-	set_irq_type(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), IRQ_TYPE_EDGE_RISING);
-	if (request_irq(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), &apollon_sw_interrupt,
-				IRQF_SHARED, "down sw",
-				&apollon_sw_interrupt))
-		return;
+	gpio_request(LED2_GPIO15, "LED2");
+	gpio_direction_output(LED2_GPIO15, 0);
 }
 
 static void __init apollon_usb_init(void)
@@ -357,7 +306,6 @@ static void __init omap_apollon_init(void)
 	u32 v;
 
 	apollon_led_init();
-	apollon_sw_init();
 	apollon_flash_init();
 	apollon_usb_init();
 
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

--GRPZ8SYKNexpdSJ7--
