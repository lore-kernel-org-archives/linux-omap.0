From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] AM35x: fix UI card EHCI port and LCD dependency
Date: Tue,  4 May 2010 13:55:39 +0530
Message-ID: <1272961539-6622-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43532 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab0EDIZo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 04:25:44 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o448Ped0025510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 4 May 2010 03:25:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hvaibhav@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

EHCI port on UI card and LCD share two pins (GPIO 181 and 182) thus
they have to be mutually exclusive.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Patch adding config (CONFIG_PANEL_SHARP_LQ043T1DG01) in AM3517 defconfig
is already accepted and available in linux-omap/dss2 branch.

 arch/arm/mach-omap2/board-am3517evm.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c1c4389..837f294 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -119,6 +119,8 @@ static int __init am3517_evm_i2c_init(void)
 static int lcd_enabled;
 static int dvi_enabled;
 
+#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
+		defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
 static void __init am3517_evm_display_init(void)
 {
 	int r;
@@ -162,6 +164,9 @@ err_2:
 err_1:
 	gpio_free(LCD_PANEL_BKLIGHT_PWR);
 }
+#else
+static void __init am3517_evm_display_init(void) {}
+#endif
 
 static int am3517_evm_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
@@ -275,7 +280,12 @@ static void __init am3517_evm_init_irq(void)
 
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
-- 
1.6.2.4

