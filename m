From: hvaibhav@ti.com
Subject: [PATCH] AM/DM37x: DSS mux configuration for >Rev-B processor cards
Date: Mon, 24 Jan 2011 20:04:11 +0530
Message-ID: <1295879651-13570-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41735 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1AXOeU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:34:20 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

To support higher resolution (e.g 720P@60), on OMAP36x (AM/DM37x)
DSS data bus has been muxed with sys_boot pins.

DSS[18-23] => DSS[0-5]
sys_boot[0,1 3-5] => DSS[18-23]

EVM revision >=RevB adopt this mux changes, which is going to ship outside.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 107b1f8..1b8a806 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -693,7 +693,7 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 };
 
 #ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
+static struct omap_board_mux omap35x_board_mux[] __initdata = {
 	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
@@ -701,6 +701,32 @@ static struct omap_board_mux board_mux[] __initdata = {
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_board_mux omap36x_board_mux[] __initdata = {
+	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
+				OMAP_PIN_OFF_WAKEUPENABLE),
+	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
+	/* AM/DM37x EVM: DSS data bus muxed with sys_boot */
+	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT0, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT1, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT3, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT4, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(SYS_BOOT6, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define omap35x_board_mux	NULL
+#define omap36x_board_mux	NULL
 #endif
 
 static struct omap_musb_board_data musb_board_data = {
@@ -712,7 +738,11 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+
+	if (cpu_is_omap3630())
+		omap3_mux_init(omap36x_board_mux, OMAP_PACKAGE_CBB);
+	else
+		omap3_mux_init(omap35x_board_mux, OMAP_PACKAGE_CBB);
 
 	omap3_evm_i2c_init();
 
-- 
1.6.2.4

