From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/14] omap: header: remove unused data-type
Date: Fri, 11 Dec 2009 15:53:16 -0800
Message-ID: <20091211235316.3189.51502.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60480 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbZLKXxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:53:11 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

From: vikram pandita <vikram.pandita@ti.com>

Remove unused data type omap_gpio_switch_config

Thereby also get rid of following sparse warnings:
arch/arm/plat-omap/include/plat/board.h :121:20:
	warning: dubious bitfield without explicit `signed' or `unsigned'
arch/arm/plat-omap/include/plat/board.h :122:19:
	warning: dubious bitfield without explicit `signed' or `unsigned'
arch/arm/plat-omap/include/plat/board.h :123:24:
	warning: dubious bitfield without explicit `signed' or `unsigned'

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

