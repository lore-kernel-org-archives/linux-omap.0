From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 1/2] ARM: dts: am4372: Add cpsw phy sel dt node
Date: Tue, 13 May 2014 14:14:30 +0530
Message-ID: <1399970671-29203-2-git-send-email-mugunthanvnm@ti.com>
References: <1399970671-29203-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399970671-29203-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

Add cpsw phy sel device tree node for selecting phy mode in control module

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ac37ac9..0ff84cf 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -521,6 +521,12 @@
 				/* Filled in by U-Boot */
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
+
+			phy_sel: cpsw-phy-sel@44e10650 {
+				compatible = "ti,am43xx-cpsw-phy-sel";
+				reg= <0x44e10650 0x4>;
+				reg-names = "gmii-sel";
+			};
 		};
 
 		epwmss0: epwmss@48300000 {
-- 
1.9.2.459.g68773ac
