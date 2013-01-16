From: Luciano Coelho <coelho@ti.com>
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power functions
Date: Wed, 16 Jan 2013 23:45:02 +0200
Message-ID: <1358372702-13102-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The code to enable and disable the WiLink shared transport has been
removed from the TI-ST driver, so it must be implemented in the board
files instead.  Add the relevant operations to Panda's board file.

Additionally, add the UART2 muxing data, so it's properly configured.

Cc: stable <stable@vger.kernel.org> [3.7]
Signed-off-by: Luciano Coelho <coelho@ti.com>
---

In v2: use gpio_request_one() instead of gpio_request() and
gpio_direction_output(). (Thanks Fabio!)

 arch/arm/mach-omap2/board-omap4panda.c |   50 +++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5c8e9ce..f44fccf 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -51,18 +51,50 @@
 #define GPIO_HUB_NRESET		62
 #define GPIO_WIFI_PMENA		43
 #define GPIO_WIFI_IRQ		53
+#define GPIO_BT_EN		46
 
 /* wl127x BT, FM, GPS connectivity chip */
+static int plat_kim_chip_enable(struct kim_data_s *kim_data)
+{
+	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
+	mdelay(5);
+	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
+	mdelay(100);
+
+	return 0;
+}
+
+static int plat_kim_chip_disable(struct kim_data_s *kim_data)
+{
+	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
+	mdelay(1);
+	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
+	mdelay(1);
+	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
+
+	return 0;
+}
+
 static struct ti_st_plat_data wilink_platform_data = {
-	.nshutdown_gpio	= 46,
 	.dev_name	= "/dev/ttyO1",
 	.flow_cntrl	= 1,
 	.baud_rate	= 3000000,
-	.chip_enable	= NULL,
-	.suspend	= NULL,
-	.resume		= NULL,
+	.chip_enable	= plat_kim_chip_enable,
+	.chip_disable	= plat_kim_chip_disable,
 };
 
+static int wilink_st_init(void)
+{
+	int status;
+
+	status = gpio_request_one(GPIO_BT_EN, GPIOF_OUT_INIT_LOW, "kim");
+	if (status)
+		pr_err("%s: failed to request gpio %d\n", __func__,
+		       GPIO_BT_EN);
+
+	return status;
+}
+
 static struct platform_device wl1271_device = {
 	.name	= "kim",
 	.id	= -1,
@@ -397,6 +429,12 @@ static struct omap_board_mux board_mux[] __initdata = {
 		  OMAP_PULL_ENA),
 	OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
 
+	/* UART2 - BT/FM/GPS shared transport */
+	OMAP4_MUX(UART2_CTS,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_RTS,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_RX,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_TX,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
@@ -433,6 +471,10 @@ static void __init omap4_panda_init(void)
 	if (ret)
 		pr_err("error setting wl12xx data: %d\n", ret);
 
+	ret = wilink_st_init();
+	if (ret)
+		pr_err("WiLink shared transport init failed: %d\n", ret);
+
 	omap4_panda_init_rev();
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
-- 
1.7.10.4
