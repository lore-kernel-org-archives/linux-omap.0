From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/3] [RFC] clk: use clk_associate for musb driver
Date: Wed,  1 Oct 2008 13:36:02 +0300
Message-ID: <1222857363-25055-3-git-send-email-felipe.balbi@nokia.com>
References: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com>
 <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61359 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYJAKgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:36:44 -0400
In-Reply-To: <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <felipe.balbi@nokia.com>

Let musb use clk_associate to avoid introducing non-standard
clk functions and passing a clk name via pdata.

Also introduce txt file to track clk function names.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 Documentation/arm/OMAP/clk_function_name.txt |    9 +++++++
 arch/arm/mach-omap2/usb-musb.c               |   34 +++++++-------------------
 drivers/usb/musb/musb_core.c                 |   23 +++++------------
 3 files changed, 25 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/arm/OMAP/clk_function_name.txt

diff --git a/Documentation/arm/OMAP/clk_function_name.txt b/Documentation/arm/OMAP/clk_function_name.txt
new file mode 100644
index 0000000..85cc980
--- /dev/null
+++ b/Documentation/arm/OMAP/clk_function_name.txt
@@ -0,0 +1,9 @@
+			OMAP Clock Function Names
+
+When moving a new driver to use clk_associate, please add here the clk
+function name given to the clks in omap1, omap2 and omap3.
+
+
+Function name		|     OMAP1	|     OMAP2	|      OMAP3
+-------------------------------------------------------------------------------
+musb_ick		|	-	|   usbhs_ick	|   hsotgusb_ick
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 61c5709..2df4f84 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,7 @@
 #include <mach/pm.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
+#include <mach/clock.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
 static struct resource musb_resources[] = {
@@ -53,27 +54,6 @@ static struct resource musb_resources[] = {
 	},
 };
 
-static int clk_on;
-
-static int musb_set_clock(struct clk *clk, int state)
-{
-	if (state) {
-		if (clk_on > 0)
-			return -ENODEV;
-
-		clk_enable(clk);
-		clk_on = 1;
-	} else {
-		if (clk_on == 0)
-			return -ENODEV;
-
-		clk_disable(clk);
-		clk_on = 0;
-	}
-
-	return 0;
-}
-
 static struct musb_hdrc_eps_bits musb_eps[] = {
 	{	"ep1_tx", 10,	},
 	{	"ep1_rx", 10,	},
@@ -127,10 +107,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		= MUSB_PERIPHERAL,
 #endif
-	.clock		= cpu_is_omap34xx()
-			? "hsotgusb_ick"
-			: "usbhs_ick",
-	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 
 	/* REVISIT charge pump on TWL4030 can supply up to
@@ -159,6 +135,14 @@ static struct platform_device musb_device = {
 void __init usb_musb_init(void)
 {
 #ifdef CONFIG_USB_MUSB_SOC
+	/* associate musb clocks with musb device */
+
+	if (cpu_is_omap34xx())
+		clk_associate("hsotgusb_ick", &musb_device.dev, "musb_ick");
+
+	if (cpu_is_omap24xx())
+		clk_associate("usbhs_ick", &musb_device.dev, "musb_ick");
+
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c939f81..152cda7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1922,7 +1922,6 @@ bad_config:
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
-	musb->set_clock = plat->set_clock;
 	musb->min_power = plat->min_power;
 
 	/* Clock usage is chip-specific ... functional clock (DaVinci,
@@ -1930,13 +1929,11 @@ bad_config:
 	 * code does is make sure a clock handle is available; platform
 	 * code manages it during start/stop and suspend/resume.
 	 */
-	if (plat->clock) {
-		musb->clock = clk_get(dev, plat->clock);
-		if (IS_ERR(musb->clock)) {
-			status = PTR_ERR(musb->clock);
-			musb->clock = NULL;
-			goto fail;
-		}
+	musb->clock = clk_get(dev, "musb_ick");
+	if (IS_ERR(musb->clock)) {
+		status = PTR_ERR(musb->clock);
+		musb->clock = NULL;
+		goto fail;
 	}
 
 	/* assume vbus is off */
@@ -2159,10 +2156,7 @@ static int musb_suspend(struct platform_device *pdev, pm_message_t message)
 		 */
 	}
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
+	clk_disable(musb->clock);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
@@ -2177,10 +2171,7 @@ static int musb_resume(struct platform_device *pdev)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
+	clk_enable(musb->clock);
 
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down and we're
-- 
1.6.0.2.307.gc427

