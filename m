From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 15/16] ARM: omap: resolve nebulous 'Error setting wl12xx
 data'
Date: Wed, 08 Feb 2012 16:40:51 +0000
Message-ID: <E1RvAZf-0006Hm-40@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35021 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab2BHQk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:40:56 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

It's useful to print the error code when a called function fails so a
diagnosis of why it failed is possible.  In this case, it fails because
we try to register some data for the wl12xx driver, but as the driver
is not configured, a stub function is used which simply returns -ENOSYS.

Let's do the simple thing for -rc and print the error code.

Also, the return code from platform_register_device() at each of these
sites was not being checked.  Add some checking, and again print the
error code.

This should be fixed properly for the next merge window so we don't
issue error messages merely because a driver is not configured.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/board-4430sdp.c          |   13 +++++++++----
 arch/arm/mach-omap2/board-omap3evm.c         |   23 ++++++++++++++++-------
 arch/arm/mach-omap2/board-omap4panda.c       |    6 ++++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 3d820bb..f0942f0 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -868,12 +868,17 @@ static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata = {
 	.board_tcxo_clock = WL12XX_TCXOCLOCK_26,
 };
 
-static void omap4_sdp4430_wifi_init(void)
+static void __init omap4_sdp4430_wifi_init(void)
 {
+	int ret;
+
 	omap4_sdp4430_wifi_mux_init();
-	if (wl12xx_set_platform_data(&omap4_sdp4430_wlan_data))
-		pr_err("Error setting wl12xx data\n");
-	platform_device_register(&omap_vwlan_device);
+	ret = wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
+	if (ret)
+		pr_err("Error setting wl12xx data: %d\n", ret);
+	ret = platform_device_register(&omap_vwlan_device);
+	if (ret)
+		pr_err("Error registering wl12xx device: %d\n", ret);
 }
 
 static void __init omap_4430sdp_init(void)
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 003fe34..c775bea 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -617,6 +617,21 @@ static struct gpio omap3_evm_ehci_gpios[] __initdata = {
 	{ OMAP3_EVM_EHCI_SELECT, GPIOF_OUT_INIT_LOW,   "select EHCI port" },
 };
 
+static void __init omap3_evm_wl12xx_init(void)
+{
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+	int ret;
+
+	/* WL12xx WLAN Init */
+	ret = wl12xx_set_platform_data(&omap3evm_wlan_data);
+	if (ret)
+		pr_err("error setting wl12xx data: %d\n", ret);
+	ret = platform_device_register(&omap3evm_wlan_regulator);
+	if (ret)
+		pr_err("error registering wl12xx device: %d\n", ret);
+#endif
+}
+
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_get_revision();
@@ -665,13 +680,7 @@ static void __init omap3_evm_init(void)
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
-
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
-	/* WL12xx WLAN Init */
-	if (wl12xx_set_platform_data(&omap3evm_wlan_data))
-		pr_err("error setting wl12xx data\n");
-	platform_device_register(&omap3evm_wlan_regulator);
-#endif
+	omap3_evm_wl12xx_init();
 }
 
 MACHINE_START(OMAP3EVM, "OMAP3 EVM")
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 30ad40d..8a5c65d 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -478,13 +478,15 @@ void omap4_panda_display_init(void)
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
+	int ret;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);
 
-	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
-		pr_err("error setting wl12xx data\n");
+	ret = wl12xx_set_platform_data(&omap_panda_wlan_data);
+	if (ret)
+		pr_err("error setting wl12xx data: %d\n", ret);
 
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8d7ce11..c126461 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -296,8 +296,10 @@ static void enable_board_wakeup_source(void)
 
 void __init zoom_peripherals_init(void)
 {
-	if (wl12xx_set_platform_data(&omap_zoom_wlan_data))
-		pr_err("error setting wl12xx data\n");
+	int ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
+
+	if (ret)
+		pr_err("error setting wl12xx data: %d\n", ret);
 
 	omap_i2c_init();
 	platform_device_register(&omap_vwlan_device);
-- 
1.7.4.4

