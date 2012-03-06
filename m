From: Mircea Gherzan <mgherzan@gmail.com>
Subject: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Tue,  6 Mar 2012 23:55:04 +0100
Message-ID: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54647 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031566Ab2CFWzM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 17:55:12 -0500
Received: by eaaq12 with SMTP id q12so2016653eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 14:55:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mgherzan@gmail.com

The "uim" deamon requires sysfs entries that are filled in using
this platform data.

Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
 include/linux/ti_wilink_st.h           |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b1d74d6..339e781 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -27,6 +27,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
 
 #include <mach/hardware.h>
@@ -56,12 +57,21 @@
 #define HDMI_GPIO_HPD  63 /* Hotplug detect */
 
 /* wl127x BT, FM, GPS connectivity chip */
-static int wl1271_gpios[] = {46, -1, -1};
+static struct ti_st_plat_data wilink_platform_data = {
+	.nshutdown_gpio	= 46,
+	.dev_name	= "/dev/ttyO1",
+	.flow_cntrl	= 1,
+	.baud_rate	= 3000000,
+	.chip_enable	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+};
+
 static struct platform_device wl1271_device = {
 	.name	= "kim",
 	.id	= -1,
 	.dev	= {
-		.platform_data	= &wl1271_gpios,
+		.platform_data	= &wilink_platform_data,
 	},
 };
 
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 2ef4385..3ca0269 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -25,6 +25,8 @@
 #ifndef TI_WILINK_ST_H
 #define TI_WILINK_ST_H
 
+#include <linux/skbuff.h>
+
 /**
  * enum proto-type - The protocol on WiLink chips which share a
  *	common physical interface like UART.
-- 
1.7.9.1

