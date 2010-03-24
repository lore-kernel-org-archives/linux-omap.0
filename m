From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 5/9] OMAP: Devkit8000: Change position of init calls
Date: Wed, 24 Mar 2010 13:52:14 +0100
Message-ID: <1269435138-27192-6-git-send-email-weber@corscience.de>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52526 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab0CXMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:53:01 -0400
In-Reply-To: <1269435138-27192-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

Change position of calling serial and ethernet initialization.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 33880f1..c3b5e02 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -649,6 +649,10 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init devkit8000_init(void)
 {
+	omap_serial_init();
+
+	omap_dm9000_init();
+
 	devkit8000_i2c_init();
 	platform_add_devices(devkit8000_devices,
 			ARRAY_SIZE(devkit8000_devices));
@@ -658,10 +662,6 @@ static void __init devkit8000_init(void)
 	spi_register_board_info(devkit8000_spi_board_info,
 	ARRAY_SIZE(devkit8000_spi_board_info));
 
-	omap_serial_init();
-
-	omap_dm9000_init();
-
 	devkit8000_ads7846_init();
 
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-- 
1.6.4.4

