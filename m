From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/19] omap2: add USB initialization for tusb6010
Date: Thu, 11 Mar 2010 15:48:14 -0800
Message-ID: <20100311234814.4500.94634.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52304 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab0CKXqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:51 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org, Francisco Alecrim <francisco.alecrim@openbossa.org>

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

Based on Kalle's and Tony's patches. Some variables re-organized
and unused code removed.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Francisco Alecrim <francisco.alecrim@openbossa.org>
[tony@atomide.com: this is needed to fix the related tusb6010 DMA API changes]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c     |   98 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2420_data.c |    1 
 2 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 4cab052..da9bcb8 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -37,6 +37,103 @@ static int slot1_cover_open;
 static int slot2_cover_open;
 static struct device *mmc_device;
 
+#define TUSB6010_ASYNC_CS	1
+#define TUSB6010_SYNC_CS	4
+#define TUSB6010_GPIO_INT	58
+#define TUSB6010_GPIO_ENABLE	0
+#define TUSB6010_DMACHAN	0x3f
+
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
+					TUSB6010_GPIO_INT, TUSB6010_DMACHAN);
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
@@ -562,6 +659,7 @@ static void __init n8x0_init_machine(void)
 	n8x0_menelaus_init();
 	n8x0_onenand_init();
 	n8x0_mmc_init();
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

