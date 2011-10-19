From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 4/4 v2] ARM: OMAP3: cm-t35: add reset for sb-t35 usb hub
Date: Wed, 19 Oct 2011 11:56:32 +0200
Message-ID: <1319018192-30906-1-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-5-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:41224
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752936Ab1JSJ4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 05:56:43 -0400
In-Reply-To: <1319017160-20391-5-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2: fixed subject, no change functional changes

 arch/arm/mach-omap2/board-cm-t35.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 18cd50c..3201c9e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -52,7 +52,8 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 
-#define CM_T35_GPIO_PENDOWN	57
+#define CM_T35_GPIO_PENDOWN		57
+#define SB_T35_USB_HUB_RESET_GPIO	167
 
 #define CM_T35_SMSC911X_CS	5
 #define CM_T35_SMSC911X_GPIO	163
@@ -436,6 +437,23 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static void cm_t35_init_usbh(void)
+{
+	int err;
+
+	err = gpio_request_one(SB_T35_USB_HUB_RESET_GPIO,
+			       GPIOF_OUT_INIT_LOW, "usb hub rst");
+	if (err) {
+		pr_err("SB-T35: usb hub rst gpio request failed: %d\n", err);
+	} else {
+		udelay(10);
+		gpio_set_value(SB_T35_USB_HUB_RESET_GPIO, 1);
+		msleep(1);
+	}
+
+	usbhs_init(&usbhs_bdata);
+}
+
 static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 				 unsigned ngpio)
 {
@@ -624,7 +642,7 @@ static void __init cm_t3x_common_init(void)
 	cm_t35_init_display();
 
 	usb_musb_init(NULL);
-	usbhs_init(&usbhs_bdata);
+	cm_t35_init_usbh();
 }
 
 static void __init cm_t35_init(void)
-- 
1.7.3.4

