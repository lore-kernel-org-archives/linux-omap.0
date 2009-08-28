From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP
Date: Fri, 28 Aug 2009 11:28:46 +0300
Message-ID: <1251448127-27336-2-git-send-email-khilman@deeprootsystems.com>
References: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62772 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZH1I2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 04:28:52 -0400
Received: by bwz19 with SMTP id 19so1464180bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 01:28:53 -0700 (PDT)
In-Reply-To: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Reddy, Teerth" <teerth@ti.com>

From: Reddy, Teerth <teerth@ti.com>

This patch changes for setting the padconf value for sys_nirq line
which is connected to T2 INTR1.  This will fix the T2 keypad wakeup
issue on OMAP3 SDP.

Signed-off-by: Teerth Reddy <teerth@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c   |    6 ++++++
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h |    3 +++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7e9b76c..31d9f56 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -473,6 +473,11 @@ static inline void board_smc91x_init(void)
 
 #endif
 
+static void enable_board_wakeup_source(void)
+{
+	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
+}
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -490,6 +495,7 @@ static void __init omap_3430sdp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
+	enable_board_wakeup_source();
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index f63f3a2..2daa595 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -542,6 +542,11 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
 		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
 		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+
+/* SYS_NIRQ T2 INT1 */
+MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
+		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
+		OMAP34XX_MUX_MODE0)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 2c57bad..98dfab6 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -885,6 +885,9 @@ enum omap34xx_index {
 	AH9_3430_MMC3_DAT1,
 	AF13_3430_MMC3_DAT2,
 	AF13_3430_MMC3_DAT3,
+
+	/* SYS_NIRQ T2 INT1 */
+	AF26_34XX_SYS_NIRQ,
 };
 
 struct omap_mux_cfg {
-- 
1.6.4

