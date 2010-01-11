From: hvaibhav@ti.com
Subject: [PATCH 1/4-V1] AM3517: Enable basic I2C Support
Date: Mon, 11 Jan 2010 11:49:59 +0530
Message-ID: <1263190802-1101-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab0AKGUJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 01:20:09 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add basic I2C board Hook-up support, where all the 3 I2C instances
are getting registered.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 8cce7d1..300b165 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -33,6 +33,15 @@

 #include "mux.h"

+static int __init am3517_evm_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+
+	return 0;
+}
+
 /*
  * Board initialization
  */
@@ -73,6 +82,8 @@ static struct omap_board_mux board_mux[] __initdata = {

 static void __init am3517_evm_init(void)
 {
+	am3517_evm_i2c_init();
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
--
1.6.2.4

