From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: dts: am335x sk: add touchscreen support
Date: Mon, 21 Oct 2013 15:13:24 -0500
Message-ID: <1382386404-6659-3-git-send-email-balbi@ti.com>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1382386404-6659-1-git-send-email-balbi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Add missing nodes for the touchscreen available
on AM335x EVM SK.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4f339fa..d7c2c0c 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -419,3 +419,13 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii-txid";
 };
+
+&tscadc {
+	status = "okay";
+	tsc {
+		ti,wires = <4>;
+		ti,x-plate-resistance = <200>;
+		ti,coordinate-readouts = <5>;
+		ti,wire-config = <0x00 0x11 0x22 0x33>;
+	};
+};
-- 
1.8.4.GIT

