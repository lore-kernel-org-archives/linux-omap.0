From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 3/4] arm: omap: switch over to gpio_set_debounce
Date: Wed, 31 Mar 2010 15:27:14 +0300
Message-ID: <1270038435-28106-4-git-send-email-felipe.balbi@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31688 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790Ab0CaM2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 08:28:11 -0400
In-Reply-To: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

stop using the omap-specific implementations for gpio
debouncing now that gpiolib provides its own support.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c        |    4 +---
 arch/arm/mach-omap2/board-ldp.c            |    3 +--
 arch/arm/mach-omap2/board-omap3evm.c       |    4 +---
 arch/arm/mach-omap2/board-omap3pandora.c   |    4 ++--
 arch/arm/mach-omap2/board-omap3touchbook.c |    3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..7525d0d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -137,9 +137,7 @@ static void ads7846_dev_init(void)
 	}
 
 	gpio_direction_input(ts_gpio);
-
-	omap_set_gpio_debounce(ts_gpio, 1);
-	omap_set_gpio_debounce_time(ts_gpio, 0xa);
+	gpio_set_debounce(ts_gpio, 0x0a);
 }
 
 static int ads7846_get_pendown_state(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5fcb52e..270c589 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -209,8 +209,7 @@ static void ads7846_dev_init(void)
 	}
 
 	gpio_direction_input(ts_gpio);
-	omap_set_gpio_debounce(ts_gpio, 1);
-	omap_set_gpio_debounce_time(ts_gpio, 0xa);
+	gpio_set_debounce(ts_gpio, 0x0a);
 }
 
 static int ads7846_get_pendown_state(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..bcce319 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -579,9 +579,7 @@ static void ads7846_dev_init(void)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
-
-	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
+	gpio_set_debounce(OMAP3_EVM_TS_GPIO, 0x0a);
 }
 
 static int ads7846_get_pendown_state(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 395d049..db06dc9 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -130,8 +130,8 @@ static struct platform_device pandora_keys_gpio = {
 static void __init pandora_keys_gpio_init(void)
 {
 	/* set debounce time for GPIO banks 4 and 6 */
-	omap_set_gpio_debounce_time(32 * 3, GPIO_DEBOUNCE_TIME);
-	omap_set_gpio_debounce_time(32 * 5, GPIO_DEBOUNCE_TIME);
+	gpio_set_debounce(32 * 3, GPIO_DEBOUNCE_TIME);
+	gpio_set_debounce(32 * 5, GPIO_DEBOUNCE_TIME);
 }
 
 static int board_keymap[] = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2504d41..6826786 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -328,8 +328,7 @@ static void __init omap3_ads7846_init(void)
 	}
 
 	gpio_direction_input(OMAP3_TS_GPIO);
-	omap_set_gpio_debounce(OMAP3_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_TS_GPIO, 0xa);
+	gpio_set_debounce(OMAP3_TS_GPIO, 0x0a);
 }
 
 static struct ads7846_platform_data ads7846_config = {
-- 
1.7.0.rc0.33.g7c3932

