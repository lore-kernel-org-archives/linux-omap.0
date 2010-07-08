From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/13] omap: Devkit8000: Use DIE id to initialize dm9000 MAC
	address
Date: Thu, 08 Jul 2010 16:55:14 +0300
Message-ID: <20100708135514.26276.25014.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60814 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab0GHNzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:55:17 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Kan-Ru Chen <kanru@0xlab.org>

From: Kan-Ru Chen <kanru@0xlab.org>

The devkit8000 boards often come with empty EEPROM thus without
valid ethernet MAC address. The DIE id to MAC formula is copied from
u-boot.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 19da458..4b7103a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -33,6 +33,7 @@
 #include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
+#include <mach/id.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -556,6 +557,9 @@ static struct platform_device omap_dm9000_dev = {
 
 static void __init omap_dm9000_init(void)
 {
+	unsigned char *eth_addr = omap_dm9000_platdata.dev_addr;
+	struct omap_die_id odi;
+
 	if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
@@ -563,6 +567,16 @@ static void __init omap_dm9000_init(void)
 		}
 
 	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
+
+	/* init the mac address using DIE id */
+	omap_get_die_id(&odi);
+
+	eth_addr[0] = 0x02; /* locally administered */
+	eth_addr[1] = odi.id_1 & 0xff;
+	eth_addr[2] = (odi.id_0 & 0xff000000) >> 24;
+	eth_addr[3] = (odi.id_0 & 0x00ff0000) >> 16;
+	eth_addr[4] = (odi.id_0 & 0x0000ff00) >> 8;
+	eth_addr[5] = (odi.id_0 & 0x000000ff);
 }
 
 static struct platform_device *devkit8000_devices[] __initdata = {

