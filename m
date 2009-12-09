From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] omap: header: remove unused data-type
Date: Wed,  9 Dec 2009 14:55:21 -0600
Message-ID: <1260392121-16685-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32900 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757841AbZLIUyB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 15:54:01 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB9Ks6BN011524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Dec 2009 14:54:07 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Remove unused data type omap_gpio_switch_config

Thereby also get rid of following sparse warnings:
arch/arm/plat-omap/include/plat/board.h :121:20:
	warning: dubious bitfield without explicit `signed' or `unsigned'
arch/arm/plat-omap/include/plat/board.h :122:19:
	warning: dubious bitfield without explicit `signed' or `unsigned'
arch/arm/plat-omap/include/plat/board.h :123:24:
	warning: dubious bitfield without explicit `signed' or `unsigned'

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/include/plat/board.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index abb17b6..376ce18 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -114,15 +114,6 @@ struct omap_pwm_led_platform_data {
 	void (*set_power)(struct omap_pwm_led_platform_data *self, int on_off);
 };
 
-/* See arch/arm/plat-omap/include/mach/gpio-switch.h for definitions */
-struct omap_gpio_switch_config {
-	char name[12];
-	u16 gpio;
-	int flags:4;
-	int type:4;
-	int key_code:24; /* Linux key code */
-};
-
 struct omap_uart_config {
 	/* Bit field of UARTs present; bit 0 --> UART1 */
 	unsigned int enabled_uarts;
-- 
1.6.6.rc0.66.ge160d

