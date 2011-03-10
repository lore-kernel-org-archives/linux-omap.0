From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH v2 2/2] OMAP: Add gpio-keys support for Overo
Date: Wed,  9 Mar 2011 16:08:06 -0800
Message-ID: <1299715686-3920-3-git-send-email-steve@sakoman.com>
References: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65211 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab1CJAIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 19:08:20 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so1043567vws.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 16:08:19 -0800 (PST)
In-Reply-To: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

This patch adds support for the standard push buttons available on
Overo expansion boards.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |   42 +++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e694ebd..1e17061 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -519,6 +519,47 @@ static void __init overo_init_led(void)
 static inline void __init overo_init_led(void) { return; }
 #endif
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
+static struct gpio_keys_button gpio_buttons[] = {
+	{
+		.code			= BTN_0,
+		.gpio			= 23,
+		.desc			= "button0",
+		.wakeup			= 1,
+	},
+	{
+		.code			= BTN_1,
+		.gpio			= 14,
+		.desc			= "button1",
+		.wakeup			= 1,
+	},
+};
+
+static struct gpio_keys_platform_data gpio_keys_pdata = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_keys_pdata,
+	},
+};
+
+static void __init overo_init_keys(void)
+{
+	platform_device_register(&gpio_keys_device);
+}
+
+#else
+static inline void __init overo_init_keys(void) { return; }
+#endif
+
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -701,6 +742,7 @@ static void __init overo_init(void)
 	overo_init_smsc911x();
 	overo_display_init();
 	overo_init_led();
+	overo_init_keys();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.0.4

