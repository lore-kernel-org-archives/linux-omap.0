From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sun, 28 Sep 2008 02:09:07 +0300
Message-ID: <20080927230902.GD8468@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271441.41412.david-b@pacbell.net> <20080927222900.GC8468@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37977 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbYI0XJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 19:09:19 -0400
Content-Disposition: inline
In-Reply-To: <20080927222900.GC8468@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Sun, Sep 28, 2008 at 01:29:05AM +0300, Felipe Balbi wrote:
> On Sat, Sep 27, 2008 at 02:41:40PM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Move the twl4030 GPIO support from drivers/i2c/chips to drivers/gpio,
> > which is a more appropriate home for this code.
> > 
> > The Kconfig symbol name is changed to match the GPIO_* convention for
> > such symbols, so config files must change in the obvious ways (Kconfig
> > will prompt you).  There's now some helptext.
> > 
> > It can now be compiled as a module, should anyone really want to
> > do that; that'll be mostly useful for test builds.  Sanity check the
> > IRQ range we're given.
> > 
> > Initialization order needed a bit of work too:  core add_children()
> > called only after IRQs get set up, gpio uses subsys_initcall.  This
> > depends on a patch making i2c driver model init use postcore_initcall.

We need something like the patch below (I can't find a substitute
to twl4030_set_gpio_edge_ctrl and twl4030_set_gpio_debounce):

==== patch 1 (desired) ====

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 32b517b..3ca43aa 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/board.h>
@@ -48,7 +49,7 @@
 
 static int hsmmc_card_detect(int irq)
 {
-	return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
+	return gpio_get_value(irq - TWL4030_GPIO_IRQ_BASE);
 }
 
 /*
@@ -61,7 +62,7 @@ static int hsmmc_late_init(struct device *dev)
 	/*
 	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
 	 */
-	ret = twl4030_request_gpio(MMC1_CD_IRQ);
+	ret = gpio_request(MMC1_CD_IRQ, "mmc_card_detect");
 	if (ret)
 		goto err;
 
@@ -88,11 +89,7 @@ err:
 
 static void hsmmc_cleanup(struct device *dev)
 {
-	int ret = 0;
-
-	ret = twl4030_free_gpio(MMC1_CD_IRQ);
-	if (ret)
-		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+	gpio_free(MMC1_CD_IRQ);
 }
 
 #ifdef CONFIG_PM


> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> > NOTE:  requires an I2C patch:
> > 
> >   http://marc.info/?l=i2c&m=122227316012577&w=2
> > 
> > I CC'd Jean since that doesn't seem to be in his queue yet, and
> > that's pretty essential to moving such TWL stuff out of the
> > i2c/chips directory into more appropriate locations.
> 
> This patch breaks hsmmc.c:
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:51: undefined reference to `twl4030_get_gpio_datain'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:93: undefined reference to `twl4030_free_gpio'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:64: undefined reference to `twl4030_request_gpio'
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:68: undefined reference to `twl4030_set_gpio_edge_ctrl'
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:78: undefined reference to `twl4030_set_gpio_debounce'
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
