From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 1/3] OMAP3: EVM: KEYPAD: Add twl4030 keypad driver support
Date: Wed, 25 Jun 2008 14:20:15 -0600
Message-ID: <4862A87F.9020303@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:59272 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbYFYUQ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 16:16:26 -0400
Received: from [200.122.155.113] (helo=[192.168.10.40])
	by mail.navvo.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <miguel.aguilar@ridgerun.com>)
	id 1KBawb-0003se-S1
	for linux-omap@vger.kernel.org; Wed, 25 Jun 2008 14:46:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add twl4030 keypad driver support to OMAP3 EVM

Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com> 
---
 arch/arm/mach-omap2/board-omap3evm.c           |   38 ++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/reference_kernel/arch/arm/mach-omap2/board-omap3evm.c b/linux-2.6.26/arch/arm/mach-omap2/board-omap3evm.c
index d8109ae..0061512 100644
--- a/reference_kernel/arch/arm/mach-omap2/board-omap3evm.c
+++ b/linux-2.6.26/arch/arm/mach-omap2/board-omap3evm.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/input.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
@@ -28,6 +29,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/board.h>
 #include <asm/arch/hsmmc.h>
 #include <asm/arch/usb-musb.h>
@@ -149,6 +151,41 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 	},
 };
 
+static int omap3evm_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P)
+};
+
+static struct omap_kp_platform_data omap3evm_kp_data = {
+	.rows		= 4,
+	.cols		= 4,
+	.keymap 	= omap3evm_keymap,
+	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
+	.rep		= 1,
+};
+
+static struct platform_device omap3evm_kp_device = {
+	.name		= "omap_twl4030keypad",
+	.id		= -1,
+	.dev		= {
+				.platform_data = &omap3evm_kp_data,
+			},
+};
+
 static void __init omap3_evm_init_irq(void)
 {
 	omap2_init_common_hw();
@@ -165,6 +202,7 @@ static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
+	&omap3evm_kp_device,
 #ifdef CONFIG_RTC_DRV_TWL4030
 	&omap3_evm_twl4030rtc_device,
 #endif
