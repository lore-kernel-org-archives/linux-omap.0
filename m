From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [PATCHv2 3/3] omap: Devkit8000: Use DIE id to initialize dm9000 MAC address
Date: Tue,  6 Jul 2010 09:10:04 +0800
Message-ID: <1278378604-15802-4-git-send-email-kanru@0xlab.org>
References: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:60674 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab0GFBPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 21:15:41 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1OVwl2-0006m1-05
	for linux-omap@vger.kernel.org; Tue, 06 Jul 2010 01:15:32 +0000
In-Reply-To: <1278378604-15802-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Kan-Ru Chen <kanru@0xlab.org>, Tony Lindgren <tony@atomide.com>

The devkit8000 boards often come with empty EEPROM thus without
valid ethernet MAC address. The DIE id to MAC formula is copied from
u-boot.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/board-devkit8000.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 922b746..51774d2 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -33,6 +33,7 @@
 #include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
+#include <mach/id.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -560,6 +561,9 @@ static struct platform_device omap_dm9000_dev = {
 
 static void __init omap_dm9000_init(void)
 {
+	unsigned char *eth_addr = omap_dm9000_platdata.dev_addr;
+	struct omap_die_id odi;
+
 	if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
@@ -567,6 +571,16 @@ static void __init omap_dm9000_init(void)
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
-- 
1.7.1

