From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 6/7] ARM: dts: omap3-gta04: Enable mmc2 for wifi
Date: Sat,  1 Mar 2014 14:58:53 +0100
Message-ID: <1393682334-26805-7-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, NeilBrown <neilb@suse.de>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neilb@suse.de>

This requires vaux4.

Reset line isn't used yet, so wifi isn't reliable.
But it does work once per boot.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 41a21bd..d556e3a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -178,7 +178,9 @@
 };
 
 &mmc2 {
-	status = "disabled";
+	vmmc-supply = <&vaux4>;
+	bus-width = <4>;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -204,3 +206,8 @@
 	bb_uvolt = <3200000>;
 	bb_uamp = <150>;
 };
+
+&vaux4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <3150000>;
+};
-- 
1.8.3.2
