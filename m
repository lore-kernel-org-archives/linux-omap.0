From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 4/7] I2C: TWL4030: Cleanup twl4030-usb.c
Date: Thu, 27 Mar 2008 19:16:04 +0200
Message-ID: <1206638167-23951-5-git-send-email-felipe.balbi@nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-3-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43461 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716AbYC0RR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:17:27 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHHB2O026017
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 19:17:25 +0200
In-Reply-To: <1206638167-23951-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

General cleanup on twl4030-usb.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |   27 +++++++++++++--------------
 drivers/usb/musb/omap2430.c     |    1 -
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index cf86d3e..eca5aef 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -28,7 +28,6 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/usb.h>
-
 #include <linux/i2c/twl4030.h>
 
 /* Register defines */
@@ -248,6 +247,18 @@
 
 /*-------------------------------------------------------------------------*/
 
+struct twl4030_usb {
+	int			irq;
+	u8			usb_mode;	/* pin configuration */
+#define T2_USB_MODE_ULPI		1
+/* #define T2_USB_MODE_CEA2011_3PIN	2 */
+	u8			asleep;
+};
+
+static struct twl4030_usb *the_transceiver;
+
+/*-------------------------------------------------------------------------*/
+
 static int twl4030_i2c_write_u8_verify(u8 module, u8 data, u8 address)
 {
 	u8 check;
@@ -307,18 +318,6 @@ static inline int twl4030_usb_read(u8 address)
 
 /*-------------------------------------------------------------------------*/
 
-struct twl4030_usb {
-	int			irq;
-	u8			usb_mode;	/* pin configuration */
-#define T2_USB_MODE_ULPI		1
-/* #define T2_USB_MODE_CEA2011_3PIN	2 */
-	u8			asleep;
-};
-
-static struct twl4030_usb *the_transceiver;
-
-/*-------------------------------------------------------------------------*/
-
 static inline int
 twl4030_usb_set_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 {
@@ -616,7 +615,7 @@ static int __init twl4030_usb_init(void)
 	if (the_transceiver)
 		return 0;
 
-	twl = kcalloc(1, sizeof *twl, GFP_KERNEL);
+	twl = kzalloc(sizeof *twl, GFP_KERNEL);
 	if (!twl)
 		return 0;
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e19a15e..eacd6c4 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -227,7 +227,6 @@ int __init musb_platform_init(struct musb *musb)
 
 	omap_vbus_power(musb, musb->board_mode == MUSB_HOST, 1);
 
-
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = omap_set_vbus;
 	if (is_peripheral_enabled(musb))
-- 
1.5.5.rc1.12.g660b9

