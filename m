From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP: N8x0: Add retu-headset platform data
Date: Wed, 25 Mar 2009 12:26:20 +0200
Message-ID: <1237976781-3252-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44830 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbZCYK0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 06:26:05 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2PAPakS021977
	for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 12:25:58 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This was earlier in board-n800-audio.c but got removed by the commit
c65c733e1af5eac5681233309fed38538c9e06d2.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 60a414c..b90d153 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -568,10 +568,20 @@ static struct omap_gpio_switch n800_gpio_switches[] __initdata = {
 	},
 };
 
+#if defined(CONFIG_CBUS_RETU_HEADSET)
+static struct platform_device retu_headset_device = {
+	.name	= "retu-headset",
+	.id	= -1,
+};
+#endif
+
 static struct platform_device *n800_devices[] __initdata = {
 #if defined(CONFIG_CBUS_RETU) && defined(CONFIG_LEDS_OMAP_PWM)
 	&n800_keypad_led_device,
 #endif
+#if defined(CONFIG_CBUS_RETU_HEADSET)
+	&retu_headset_device,
+#endif
 };
 
 #ifdef CONFIG_MENELAUS
-- 
1.6.2

