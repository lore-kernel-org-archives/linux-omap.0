From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: [patch 2.6.18-omap-git] omap2 fullspeed usb 2/2 (apollon)
Date: Mon, 23 Oct 2006 13:46:06 +0900
Message-ID: <001d01c6f65e$270c8b10$c7a3580a@swcenter.sec.samsung.co.kr>
References: <200610201252.01421.david-b@pacbell.net>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <200610201252.01421.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'David Brownell' <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[PATCH] USB device support on Apollon
 
  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

----

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 99651b2..e1e2246 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -235,6 +235,13 @@ static struct omap_mmc_config apollon_mm
 	},
 };
 
+static struct omap_usb_config apollon_usb_config __initdata = {
+	.register_dev	= 1,
+	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
+
+	.pins[0]	= 6,
+};
+
 static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -242,6 +249,7 @@ static struct omap_lcd_config apollon_lc
 static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_MMC,		&apollon_mmc_config },
+	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -310,11 +318,22 @@ static void __init apollon_sw_init(void)
 		return;
 }
 
+static void __init apollon_usb_init(void)
+{
+	/* USB device */
+	/* DEVICE_SUSPEND */
+	omap_cfg_reg(P21_242X_GPIO12);
+	omap_request_gpio(12);
+	omap_set_gpio_direction(12, 0);		/* OUT */
+	omap_set_gpio_dataout(12, 0);
+}
+
 static void __init omap_apollon_init(void)
 {
 	apollon_led_init();
 	apollon_sw_init();
 	apollon_flash_init();
+	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
