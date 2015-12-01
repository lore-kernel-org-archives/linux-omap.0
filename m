From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] ARM: dts: Fix dm814x entries for pllss and prcm
Date: Tue,  1 Dec 2015 15:38:20 -0800
Message-ID: <1449013103-23238-8-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Otherwise drivers under pllss and prcm won't probe properly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 7988b42..5c8de19 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -215,7 +215,10 @@
 
 			prcm: prcm@180000 {
 				compatible = "ti,dm814-prcm", "simple-bus";
-				reg = <0x180000 0x4000>;
+				reg = <0x180000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x180000 0x2000>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -226,9 +229,13 @@
 				};
 			};
 
+			/* See TRM PLL_SUBSYS_BASE and "PLLSS Registers" */
 			pllss: pllss@1c5000 {
 				compatible = "ti,dm814-pllss", "simple-bus";
-				reg = <0x1c5000 0x2000>;
+				reg = <0x1c5000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1c5000 0x1000>;
 
 				pllss_clocks: clocks {
 					#address-cells = <1>;
-- 
2.6.2
