From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 10/32] ARM: dts: omap3-gta04: update gpmc NAND setup
Date: Tue, 31 Jul 2018 09:11:13 +0200
Message-ID: <39dafcd863ec03a531ac86c602f96450ba3dd71b.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

to better match omap3-beagle.dts (which was the basis
of designing the GTA04).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 34e9a3c05cb5..8e785cff539d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -616,27 +616,27 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		ti,nand-ecc-opt = "ham1";
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-		gpmc,sync-clk-ps = <0>;
+		gpmc,device-width = <2>;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <44>;
 		gpmc,cs-wr-off-ns = <44>;
 		gpmc,adv-on-ns = <6>;
 		gpmc,adv-rd-off-ns = <34>;
 		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
 		gpmc,oe-off-ns = <54>;
+		gpmc,we-off-ns = <40>;
 		gpmc,access-ns = <64>;
 		gpmc,rd-cycle-ns = <82>;
 		gpmc,wr-cycle-ns = <82>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
-		gpmc,device-width = <2>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
+		gpmc,sync-clk-ps = <0>;
 
 		x-loader@0 {
 			label = "X-Loader";
-- 
2.12.2
