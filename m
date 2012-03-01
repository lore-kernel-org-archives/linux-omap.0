From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/7] OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
Date: Thu,  1 Mar 2012 14:34:42 +0200
Message-ID: <1330605286-24166-4-git-send-email-tomi.valkeinen@ti.com>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48641 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759140Ab2CAMfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:35:06 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so1200836lag.16
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:35:04 -0800 (PST)
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The GPIO 60 on 4430sdp and Panda is not HPD GPIO, as currently marked in
the board files, but CT_CP_HPD, which is used to enable/disable HPD
functionality.

This patch renames the GPIO.

Backported from 3932a32fcf5393f8be70ac99dc718ad7ad0a415b

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    4 ++--
 arch/arm/mach-omap2/board-omap4panda.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 7feefb8..d0a49c3 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -49,7 +49,7 @@
 #define ETH_KS8851_QUART		138
 #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
 #define OMAP4_SFH7741_ENABLE_GPIO		188
-#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
 static const int sdp4430_keymap[] = {
@@ -591,7 +591,7 @@ static void sdp4430_hdmi_mux_init(void)
 }
 
 static struct gpio sdp4430_hdmi_gpios[] = {
-	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
+	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
 };
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 2e9a6f36..bc98749 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -52,7 +52,7 @@
 #define GPIO_HUB_NRESET		62
 #define GPIO_WIFI_PMENA		43
 #define GPIO_WIFI_IRQ		53
-#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
+#define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
 /* wl127x BT, FM, GPS connectivity chip */
@@ -627,7 +627,7 @@ static void omap4_panda_hdmi_mux_init(void)
 }
 
 static struct gpio panda_hdmi_gpios[] = {
-	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
+	{ HDMI_GPIO_CT_CP_HPD, GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ct_cp_hpd" },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
 };
 
-- 
1.7.4.1

