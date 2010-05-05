From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/18] AM35x: fix UI card EHCI port and LCD dependency
Date: Wed, 05 May 2010 12:33:25 -0700
Message-ID: <20100505193325.21568.78883.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57423 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757981Ab0EETdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:25 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

EHCI port on UI card and LCD share two pins (GPIO 181 and 182) thus
they have to be mutually exclusive.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 02e2097..19b9e41 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -216,6 +216,8 @@ static int __init am3517_evm_i2c_init(void)
 static int lcd_enabled;
 static int dvi_enabled;
 
+#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
+		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
 static void __init am3517_evm_display_init(void)
 {
 	int r;
@@ -259,6 +261,9 @@ err_2:
 err_1:
 	gpio_free(LCD_PANEL_BKLIGHT_PWR);
 }
+#else
+static void __init am3517_evm_display_init(void) {}
+#endif
 
 static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
@@ -372,7 +377,12 @@ static void __init am3517_evm_init_irq(void)
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
+		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+#else
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+#endif
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,

