From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2] ARM: OMAP: Fix GPIO switch initial output state handling
Date: Wed, 11 Mar 2009 15:07:19 +0200
Message-ID: <1236776839-15884-1-git-send-email-ext-jani.1.nikula@nokia.com>
References: <49B7A1E5.9060403@solidboot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64209 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbZCKNIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 09:08:31 -0400
In-Reply-To: <49B7A1E5.9060403@solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: juha.yrjola@solidboot.com, ext-jani.1.nikula@nokia.com

The switchover to cross-platform GPIO interface unexpectedly caused all
output GPIO switches to be set to high state by default, unlike the
original OMAP code. Introduce a new GPIO switch flag to define the
initial state of the switch. Unless the flag is set, the default is now
inactive state of the switch.

Also store the state of output switches directly into the switch struct
instead of trying to read an output GPIO.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/plat-omap/gpio-switch.c              |   13 +++++++++----
 arch/arm/plat-omap/include/mach/gpio-switch.h |   11 ++++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index 2b5665d..9053ea0 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -286,12 +286,17 @@ static int __init new_switch(struct gpio_switch *sw)
 
 	/* input: 1, output: 0 */
 	direction = !(sw->flags & OMAP_GPIO_SWITCH_FLAG_OUTPUT);
-	if (direction)
+	if (direction) {
 		gpio_direction_input(sw->gpio);
-	else
-		gpio_direction_output(sw->gpio, true);
+		sw->state = gpio_sw_get_state(sw);
+	} else {
+		int state = sw->state = !!(sw->flags &
+			OMAP_GPIO_SWITCH_FLAG_OUTPUT_INIT_ACTIVE);
 
-	sw->state = gpio_sw_get_state(sw);
+		if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
+			state = !state;
+		gpio_direction_output(sw->gpio, state);
+	}
 
 	r = 0;
 	r |= device_create_file(&sw->pdev.dev, &dev_attr_state);
diff --git a/arch/arm/plat-omap/include/mach/gpio-switch.h b/arch/arm/plat-omap/include/mach/gpio-switch.h
index a143253..2096780 100644
--- a/arch/arm/plat-omap/include/mach/gpio-switch.h
+++ b/arch/arm/plat-omap/include/mach/gpio-switch.h
@@ -24,11 +24,12 @@
  *	low  -> inactive
  *
  */
-#define OMAP_GPIO_SWITCH_TYPE_COVER		0x0000
-#define OMAP_GPIO_SWITCH_TYPE_CONNECTION	0x0001
-#define OMAP_GPIO_SWITCH_TYPE_ACTIVITY		0x0002
-#define OMAP_GPIO_SWITCH_FLAG_INVERTED		0x0001
-#define OMAP_GPIO_SWITCH_FLAG_OUTPUT		0x0002
+#define OMAP_GPIO_SWITCH_TYPE_COVER			0x0000
+#define OMAP_GPIO_SWITCH_TYPE_CONNECTION		0x0001
+#define OMAP_GPIO_SWITCH_TYPE_ACTIVITY			0x0002
+#define OMAP_GPIO_SWITCH_FLAG_INVERTED			0x0001
+#define OMAP_GPIO_SWITCH_FLAG_OUTPUT			0x0002
+#define OMAP_GPIO_SWITCH_FLAG_OUTPUT_INIT_ACTIVE	0x0004
 
 struct omap_gpio_switch {
 	const char *name;
-- 
1.6.0.4

