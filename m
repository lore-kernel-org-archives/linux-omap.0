From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 02/10] ARM: dts: omap3: overo: add missing unit name for lcd35 display
Date: Mon,  1 Aug 2016 12:46:56 -0400
Message-ID: <1470070024-30281-3-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Commit b8d368caa8dc ("ARM: dts: omap3: overo: remove unneded unit names
in display nodes") removed the unit names for all Overo display nodes
that didn't have a reg property.

But the display in arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi does
have a reg property so the correct fix was to make the unit name match
the value of the reg property, instead of removing it.

This patch fixes the following DTC warning for boards using this dtsi:

"ocp/spi@48098000/display has a reg or ranges property, but no unit name"

Fixes: b8d368caa8dc ("ARM: dts: omap3: overo: remove unneded unit names in display nodes")
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index ca86da68220c..854117dc0b77 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -119,7 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi1_pins>;
 
-	lcd0: display {
+	lcd0: display@1 {
 		compatible = "lgphilips,lb035q02";
 		label = "lcd35";
 
-- 
2.5.5
