From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] omap3: pandora: update gpio-keys data
Date: Thu,  1 Jul 2010 22:58:20 +0300
Message-ID: <1278014301-24645-2-git-send-email-notasas@gmail.com>
References: <1278014301-24645-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57949 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab0GAT6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 15:58:34 -0400
Received: by wwb24 with SMTP id 24so215057wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 12:58:33 -0700 (PDT)
In-Reply-To: <1278014301-24645-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Update gpio-keys setup so it matches what is on default firmware.
Also make use of debounce feature in gpio-keys instead of setting it
explicitly, as gpio-keys is now capable of using hardware debounce on
OMAPs thanks to recent gpiolib changes.
Also fix a sparce warning along the way.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index ebbfb49..6131d98 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -49,9 +49,6 @@
 
 #define OMAP3_PANDORA_TS_GPIO		94
 
-/* hardware debounce: (value + 1) * 31us */
-#define GPIO_DEBOUNCE_TIME		127
-
 static struct gpio_led pandora_gpio_leds[] = {
 	{
 		.name			= "pandora::sd1",
@@ -89,6 +86,7 @@ static struct platform_device pandora_leds_gpio = {
 	.type		= ev_type,				\
 	.code		= ev_code,				\
 	.active_low	= act_low,				\
+	.debounce_interval = 4,					\
 	.desc		= "btn " descr,				\
 }
 
@@ -100,14 +98,14 @@ static struct gpio_keys_button pandora_gpio_keys[] = {
 	GPIO_BUTTON_LOW(103,	KEY_DOWN,	"down"),
 	GPIO_BUTTON_LOW(96,	KEY_LEFT,	"left"),
 	GPIO_BUTTON_LOW(98,	KEY_RIGHT,	"right"),
-	GPIO_BUTTON_LOW(109,	KEY_KP1,	"game 1"),
-	GPIO_BUTTON_LOW(111,	KEY_KP2,	"game 2"),
-	GPIO_BUTTON_LOW(106,	KEY_KP3,	"game 3"),
-	GPIO_BUTTON_LOW(101,	KEY_KP4,	"game 4"),
-	GPIO_BUTTON_LOW(102,	BTN_TL,		"l"),
-	GPIO_BUTTON_LOW(97,	BTN_TL2,	"l2"),
-	GPIO_BUTTON_LOW(105,	BTN_TR,		"r"),
-	GPIO_BUTTON_LOW(107,	BTN_TR2,	"r2"),
+	GPIO_BUTTON_LOW(109,	KEY_PAGEUP,	"game 1"),
+	GPIO_BUTTON_LOW(111,	KEY_END,	"game 2"),
+	GPIO_BUTTON_LOW(106,	KEY_PAGEDOWN,	"game 3"),
+	GPIO_BUTTON_LOW(101,	KEY_HOME,	"game 4"),
+	GPIO_BUTTON_LOW(102,	KEY_RIGHTSHIFT,	"l"),
+	GPIO_BUTTON_LOW(97,	KEY_KPPLUS,	"l2"),
+	GPIO_BUTTON_LOW(105,	KEY_RIGHTCTRL,	"r"),
+	GPIO_BUTTON_LOW(107,	KEY_KPMINUS,	"r2"),
 	GPIO_BUTTON_LOW(104,	KEY_LEFTCTRL,	"ctrl"),
 	GPIO_BUTTON_LOW(99,	KEY_MENU,	"menu"),
 	GPIO_BUTTON_LOW(176,	KEY_COFFEE,	"hold"),
@@ -128,14 +126,7 @@ static struct platform_device pandora_keys_gpio = {
 	},
 };
 
-static void __init pandora_keys_gpio_init(void)
-{
-	/* set debounce time for GPIO banks 4 and 6 */
-	gpio_set_debounce(32 * 3, GPIO_DEBOUNCE_TIME);
-	gpio_set_debounce(32 * 5, GPIO_DEBOUNCE_TIME);
-}
-
-static int board_keymap[] = {
+static const uint32_t board_keymap[] = {
 	/* row, col, code */
 	KEY(0, 0, KEY_9),
 	KEY(0, 1, KEY_8),
@@ -598,7 +589,6 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
 	usb_ehci_init(&ehci_pdata);
-	pandora_keys_gpio_init();
 	usb_musb_init(&musb_board_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
-- 
1.6.3.3

