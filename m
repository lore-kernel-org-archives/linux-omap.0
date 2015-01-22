From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 11/13] ARM: dts: omap3-gta04: only power DSS when necessary.
Date: Thu, 22 Jan 2015 21:38:17 +0100
Message-ID: <1421959099-28319-12-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de, NeilBrown <neil@brown.name>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neil@brown.name>

i.e. configure vpll2 as a supply for the dss rather
than being always-on.

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 08f0b25..228e79b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -393,16 +393,12 @@
 	regulator-max-microvolt = <3150000>;
 };
 
-/* Needed to power the DPI pins */
-&vpll2 {
-	regulator-always-on;
-};
-
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = < &dss_dpi_pins >;
 
 	status = "okay";
+	vdds_dsi-supply = <&vpll2>;
 
 	port {
 		dpi_out: endpoint {
-- 
1.9.1
