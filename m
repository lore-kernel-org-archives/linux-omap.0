From: "Kyungmin Park" <kmpark@infradead.org>
Subject: [PATCH] ARM: OMAP: Update recent gpio-keys changes in apollon board
Date: Tue, 15 May 2007 13:52:42 +0900
Message-ID: <001101c796ac$ed7aae50$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[PATCH] ARM: OMAP: Update recent gpio-keys changes in apollon board

- Also fix section mismatch: reference to .init.text: from .text in apollon
board

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

diff --git a/arch/arm/mach-omap2/board-apollon-keys.c
b/arch/arm/mach-omap2/board-apollon-keys.c
index 6cd29ec..8cd2e52 100644
--- a/arch/arm/mach-omap2/board-apollon-keys.c
+++ b/arch/arm/mach-omap2/board-apollon-keys.c
@@ -24,17 +24,17 @@
 
 static struct gpio_keys_button apollon_gpio_keys_buttons[] = {
 	[0] = {
-		.keycode	= KEY_ENTER,
+		.code		= KEY_ENTER,
 		.gpio		= SW_ENTER_GPIO16,
 		.desc		= "enter sw",
 	},
 	[1] = {
-		.keycode	= KEY_UP,
+		.code		= KEY_UP,
 		.gpio		= SW_UP_GPIO17,
 		.desc		= "up sw",
 	},
 	[2] = {
-		.keycode	= KEY_DOWN,
+		.code		= KEY_DOWN,
 		.gpio		= SW_DOWN_GPIO58,
 		.desc		= "down sw",
 	},
diff --git a/arch/arm/mach-omap2/board-apollon.c
b/arch/arm/mach-omap2/board-apollon.c
index 9e6dd0b..60adb62 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -270,7 +270,7 @@ static struct omap_lcd_config apollon_lcd_config __initdata
= {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel apollon_config[] = {
+static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_MMC,		&apollon_mmc_config },
 	{ OMAP_TAG_USB,		&apollon_usb_config },
