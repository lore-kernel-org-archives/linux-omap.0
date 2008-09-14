From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH] ARM:OMAP2: Add OVERO_GPIO_BT_XGATE to Overo board init
Date: Sat, 13 Sep 2008 22:18:43 -0700
Message-ID: <5e088bd90809132218g79bb0da8uf1a7befee988263e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:30879 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYINFSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 01:18:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1485214wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 13 Sep 2008 22:18:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Drive OVERO_GPIO_BT_XGATE low rather than relying on the pin mux pull
down set by U-boot

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c             |    6 ++++++
 arch/arm/plat-omap/include/mach/board-overo.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 396ec33..5c23b4d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -207,6 +207,12 @@ static void __init overo_init(void)
 		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_W2W_NRESET\n");
 	}

+	if ((gpio_request(OVERO_GPIO_BT_XGATE, "OVERO_GPIO_BT_XGATE") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_BT_XGATE, 0) == 0))
+		gpio_export(OVERO_GPIO_BT_XGATE, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_BT_XGATE\n");
+
 	if ((gpio_request(OVERO_GPIO_BT_NRESET, "OVERO_GPIO_BT_NRESET") == 0) &&
 	    (gpio_direction_output(OVERO_GPIO_BT_NRESET, 1) == 0)) {
 		gpio_export(OVERO_GPIO_BT_NRESET, 0);
diff --git a/arch/arm/plat-omap/include/mach/board-overo.h
b/arch/arm/plat-omap/include/mach/board-overo.h
index b70f22a..7ecae66 100644
--- a/arch/arm/plat-omap/include/mach/board-overo.h
+++ b/arch/arm/plat-omap/include/mach/board-overo.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_ARCH_OVERO_H
 #define __ASM_ARCH_OVERO_H

+#define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
-- 
1.5.4.5
