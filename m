From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 14/32] ARM: dts: omap3-gta04: replace ti,non-removable with generic non-removable
Date: Wed, 25 Jul 2018 08:58:46 +0200
Message-ID: <3361cb71f6b92d2c29e4f73aee9ac6a281895a91.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

For a while the mmc core supports the generic non-removable property
so that we do no longer need the ti-specific one.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index f6166b37405d..036a25afd003 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -504,13 +504,13 @@
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
-	ti,non-removable;
+	non-removable;
 };
 
 &mmc2 {
 	vmmc-supply = <&vaux4>;
 	bus-width = <4>;
-	ti,non-removable;
+	non-removable;
 	cap-power-off-card;
 	mmc-pwrseq = <&wifi_pwrseq>;
 };
-- 
2.12.2
