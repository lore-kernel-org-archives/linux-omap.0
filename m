From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 1/2] OMAP2EVM: Add keypad support
Date: Tue, 12 Aug 2008 14:28:49 +0530
Message-ID: <c656a4d20808120158k263c9a75ya53e87ae64477ced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:34709 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYHLI6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 04:58:51 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1249011tic.23
        for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 01:58:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

TWL4030 keypad controller driver support for OMAP2EVM

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c |   38 ++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index b6354e3..9eb93b6 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/input.h>

 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/hsmmc.h>
+#include <asm/arch/keypad.h>

 static struct resource omap2evm_smc911x_resources[] = {
 	[0] =   {
@@ -72,6 +74,41 @@ static struct omap_lcd_config omap2_evm_lcd_config
__initdata = {
 	.ctrl_name	= "internal",
 };

+static int omap2evm_keymap[] = {
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
+static struct omap_kp_platform_data omap2evm_kp_data = {
+	.rows		= 4,
+	.cols		= 4,
+	.keymap 	= omap2evm_keymap,
+	.keymapsize	= ARRAY_SIZE(omap2evm_keymap),
+	.rep		= 1,
+};
+
+static struct platform_device omap2evm_kp_device = {
+	.name		= "omap_twl4030keypad",
+	.id		= -1,
+	.dev		= {
+				.platform_data = &omap2evm_kp_data,
+			},
+};
+
 static void __init omap2_evm_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
@@ -111,6 +148,7 @@ static int __init omap2_evm_i2c_init(void)
 static struct platform_device *omap2_evm_devices[] __initdata = {
 	&omap2_evm_lcd_device,
 	&omap2evm_smc911x_device,
+	&omap2evm_kp_device,
 };

 static void __init omap2_evm_init(void)
-- 
1.5.3.4
