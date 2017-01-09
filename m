From: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] ARM: dts: am335x-phycore-som: Remove partition tables
Date: Mon, 9 Jan 2017 09:37:30 +0100
Message-ID: <1483951050-46588-1-git-send-email-t.remmet@phytec.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As the bootloader passes the NAND and the SPI flash partition tables
there is no need to keep them in the kernel device tree.
Removed them.

Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 58 -------------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 25f5449..14533ff 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -211,43 +211,6 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-
-		partition@0 {
-			label = "xload";
-			reg = <0x0 0x20000>;
-		};
-		partition@1 {
-			label = "xload_backup1";
-			reg = <0x20000 0x20000>;
-		};
-		partition@2 {
-			label = "xload_backup2";
-			reg = <0x40000 0x20000>;
-		};
-		partition@3 {
-			label = "xload_backup3";
-			reg = <0x60000 0x20000>;
-		};
-		partition@4 {
-			label = "barebox";
-			reg = <0x80000 0x80000>;
-		};
-		partition@5 {
-			label = "bareboxenv";
-			reg = <0x100000 0x40000>;
-		};
-		partition@6 {
-			label = "oftree";
-			reg = <0x140000 0x40000>;
-		};
-		partition@7 {
-			label = "kernel";
-			reg = <0x180000 0x800000>;
-		};
-		partition@8 {
-			label = "root";
-			reg = <0x980000 0x0>;
-		};
 	};
 };
 
@@ -358,26 +321,5 @@
 		status = "disabled";
 		#address-cells = <1>;
 		#size-cells = <1>;
-
-		partition@0 {
-			label = "xload";
-			reg = <0x0 0x20000>;
-		};
-		partition@1 {
-			label = "barebox";
-			reg = <0x20000 0x80000>;
-		};
-		partition@2 {
-			label = "bareboxenv";
-			reg = <0xa0000 0x20000>;
-		};
-		partition@3 {
-			label = "oftree";
-			reg = <0xc0000 0x20000>;
-		};
-		partition@4 {
-			label = "kernel";
-			reg = <0xe0000 0x0>;
-		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
