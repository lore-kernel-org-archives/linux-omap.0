From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected, so mark it "disabled"
Date: Thu, 22 Jan 2015 21:38:18 +0100
Message-ID: <1421959099-28319-13-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de, NeilBrown <neil@brown.name>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 228e79b..8d2b0a1 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -357,6 +357,10 @@
 	pinctrl-0 = <&uart3_pins>;
 };
 
+&uart4 {
+	status = "disabled";
+};
+
 &charger {
 	ti,bb-uvolt = <3200000>;
 	ti,bb-uamp = <150>;
-- 
1.9.1
