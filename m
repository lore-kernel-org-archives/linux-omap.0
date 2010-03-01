From: Francisco Alecrim <alecrim@gmail.com>
Subject: [PATCH v2] board-n8x0: add USB initialization
Date: Mon,  1 Mar 2010 18:13:04 -0400
Message-ID: <1267481584-29281-1-git-send-email-alecrim@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61908 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0CAWPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 17:15:18 -0500
Received: by vws10 with SMTP id 10so573935vws.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 14:15:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>, Kalle Valo <kalle.valo@iki.fi>, Tony Lindgren <tony@atomide.com>

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

Based on Kalle's and Tony's patches. Some variables re-organized and
unused code remove(68499cc5716bbeca16ca8c83ec6e9f04b8dbfacb).

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Francisco Alecrim <francisco.alecrim@openbossa.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c     |   92 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2420_data.c |    1 +
 include/linux/usb/musb.h             |    4 ++
 3 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index ee548dd..79d659a 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -32,6 +32,97 @@
 #include <plat/serial.h>
 #include <plat/cbus.h>
 
+#if defined(CONFIG_USB_TUSB6010) || \
+	defined(CONFIG_USB_TUSB6010_MODULE)
+/*
+ * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
+ * 1.5 V voltage regulators of PM companion chip. Companion chip will then
+ * provide then PGOOD signal to TUSB6010 which will release it from reset.
+ */
+static int tusb_set_power(int state)
+{
+	int i, retval = 0;
+
+	if (state) {
+		gpio_set_value(TUSB6010_GPIO_ENABLE, 1);
+		msleep(1);
+
+		/* Wait until TUSB6010 pulls INT pin down */
+		i = 100;
+		while (i && gpio_get_value(TUSB6010_GPIO_INT)) {
+			msleep(1);
+			i--;
+		}
+
+		if (!i) {
+			printk(KERN_ERR "tusb: powerup failed\n");
+			retval = -ENODEV;
+		}
+	} else {
+		gpio_set_value(TUSB6010_GPIO_ENABLE, 0);
+		msleep(10);
+	}
+
+	return retval;
+}
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= 1,
+	.dyn_fifo	= 1,
+	.num_eps	= 16,
+	.ram_bits	= 12,
+};
+
+static struct musb_hdrc_platform_data tusb_data = {
+#if defined(CONFIG_USB_MUSB_OTG)
+	.mode		= MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
+	.mode		= MUSB_PERIPHERAL,
+#else /* defined(CONFIG_USB_MUSB_HOST) */
+	.mode		= MUSB_HOST,
+#endif
+	.set_power	= tusb_set_power,
+	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
+	.power		= 100,	/* Max 100 mA VBUS for host mode */
+	.config		= &musb_config,
+};
+
+static void __init n8x0_usb_init(void)
+{
+	int ret = 0;
+	static char	announce[] __initdata = KERN_INFO "TUSB 6010\n";
+
+	/* PM companion chip power control pin */
+	ret = gpio_request(TUSB6010_GPIO_ENABLE, "TUSB6010 enable");
+	if (ret != 0) {
+		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
+		       TUSB6010_GPIO_ENABLE);
+		return;
+	}
+	gpio_direction_output(TUSB6010_GPIO_ENABLE, 0);
+
+	tusb_set_power(0);
+
+	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
+					TUSB6010_ASYNC_CS, TUSB6010_SYNC_CS,
+					TUSB6010_GPIO_INT, 0x3f);
+	if (ret != 0)
+		goto err;
+
+	printk(announce);
+
+	return;
+
+err:
+	gpio_free(TUSB6010_GPIO_ENABLE);
+}
+#else
+
+static void __init n8x0_usb_init(void) {}
+
+#endif /*CONFIG_USB_TUSB6010 */
+
+
 static struct omap2_mcspi_device_config p54spi_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel = 1,
@@ -148,6 +239,7 @@ static void __init n8x0_init_machine(void)
 
 	omap_serial_init();
 	n8x0_onenand_init();
+	n8x0_usb_init();
 }
 
 MACHINE_START(NOKIA_N800, "Nokia N800")
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index f12af95..d932b14 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1841,6 +1841,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
+	CLK("musb_hdrc",	"fck",	&osc_ck,	CK_242X),
 };
 
 /*
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 3fdeef5..c281ce0 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -98,6 +98,10 @@ struct musb_hdrc_platform_data {
 #define	TUSB6010_OSCCLK_60	16667	/* psec/clk @ 60.0 MHz */
 #define	TUSB6010_REFCLK_24	41667	/* psec/clk @ 24.0 MHz XI */
 #define	TUSB6010_REFCLK_19	52083	/* psec/clk @ 19.2 MHz CLKIN */
+#define TUSB6010_ASYNC_CS	1
+#define TUSB6010_SYNC_CS	4
+#define TUSB6010_GPIO_INT	58
+#define TUSB6010_GPIO_ENABLE	0
 
 #ifdef	CONFIG_ARCH_OMAP2
 
-- 
1.6.3.3

