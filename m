From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Mon,  9 Mar 2015 17:36:42 +0200
Message-ID: <1425915402-10012-3-git-send-email-eliad@wizery.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45703 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbCIPgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2015 11:36:55 -0400
Received: by wibbs8 with SMTP id bs8so22063125wib.4
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2015 08:36:53 -0700 (PDT)
In-Reply-To: <1425915402-10012-1-git-send-email-eliad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>

Add wl18xx (wilink8) bindings to omap3-igep0030-rev-g and
omap3-igep0020-rev-f dts files, instead of defining the
platform data through the pdata-quirks.

The patch was compile-tested only.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 9 +++++++++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 9 +++++++++
 arch/arm/mach-omap2/pdata-quirks.c         | 2 --
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index cc8bd0c..8e5b44e 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -42,4 +42,13 @@
 	vmmc-supply = <&lbep5clwmc_wlen>;
 	bus-width = <4>;
 	non-removable;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <17 IRQ_TYPE_NONE>;
+	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index 9326b28..02c4eec 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -64,4 +64,13 @@
 	vmmc-supply = <&lbep5clwmc_wlen>;
 	bus-width = <4>;
 	non-removable;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <8 IRQ_TYPE_NONE>;
+	};
 };
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 190fa43..abc8a20 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -159,14 +159,12 @@ static struct platform_device btwilink_device = {
 
 static void __init omap3_igep0020_rev_f_legacy_init(void)
 {
-	legacy_init_wl12xx(0, 0, 177);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
 
 static void __init omap3_igep0030_rev_g_legacy_init(void)
 {
-	legacy_init_wl12xx(0, 0, 136);
 	platform_device_register(&wl18xx_device);
 	platform_device_register(&btwilink_device);
 }
-- 
1.8.5.2.229.g4448466.dirty

