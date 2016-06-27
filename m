From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 12/27] ARM: dts: omap3: overo: remove unneded unit names in display nodes
Date: Mon, 27 Jun 2016 15:20:53 -0400
Message-ID: <1467055268-13194-13-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-overo-gallop43.dtb,
omap3-overo-chestnut43.dtb, omap3-overo-storm-chestnut43.dtb,
omap3-overo-palo43.dtb, and omap3-overo-storm-palo43.dtb:

"display@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi | 2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 6314da2580f5..ca86da68220c 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -119,7 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi1_pins>;
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "lgphilips,lb035q02";
 		label = "lcd35";
 
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 7e3fe85a8ad9..b0753ef8abd4 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -96,7 +96,7 @@
 		display0 = &lcd0;
 	};
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "samsung,lte430wq-f0c", "panel-dpi";
 		label = "lcd43";
 
-- 
2.5.5
