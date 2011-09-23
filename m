From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to l3-noc driver
Date: Fri, 23 Sep 2011 22:23:18 +0200
Message-ID: <1316809399-19579-11-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab1IWUYr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:47 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Used the main OCP node to add bindings with the l3_noc driver.
Remove l3_noc static device creation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi  |    3 ++-
 arch/arm/mach-omap2/devices.c |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d4131e3..b85a39d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -63,10 +63,11 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "ti,omap4-l3-noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
 		gic: interrupt-controller@48241000 {
 			compatible = "arm,cortex-a9-gic";
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2d4a199..0f8e0eb 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -77,6 +78,10 @@ static int __init omap4_l3_init(void)
 	struct platform_device *pdev;
 	char oh_name[L3_MODULES_MAX_LEN];
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	/*
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
-- 
1.7.0.4

