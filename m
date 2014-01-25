From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 4/9] ARM: dts: omap3-gta04: Enable mmc2 for wifi.
Date: Sat, 25 Jan 2014 22:28:58 +0100
Message-ID: <1390685343-11663-5-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, neilb@suse.de, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

This requires vaux4.

Reset line isn't used yet, so wifi isn't reliable.
But it does work once per boot.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 6011151..7e09410 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -79,6 +79,11 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+		vaux4: regulator-vaux4 {
+			compatible = "ti,twl4030-vaux4";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3150000>;
+		};
 	};
 };
 
@@ -154,7 +159,9 @@
 };
 
 &mmc2 {
-	status = "disabled";
+	vmmc-supply = <&vaux4>;
+	bus-width = <4>;
+	ti,non-removable;
 };
 
 &mmc3 {
-- 
1.8.3.2
