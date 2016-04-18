From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/5] ARM: dts: omap5-board-common: describe gpadc for Palmas
Date: Mon, 18 Apr 2016 20:20:58 +0200
Message-ID: <5ad40bc4de235c368e08ecb6684eba9dff71b769.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

tested on OMP5432 EVM

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 902657d..c0da5ff 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -391,6 +391,16 @@
 			ti,backup-battery-charge-high-current;
 		};
 
+		gpadc {
+			compatible = "ti,palmas-gpadc";
+			interrupts = <18 0
+				      16 0
+				      17 0>;
+			#io-channel-cells = <1>;
+			ti,channel0-current-microamp = <5>;
+			ti,channel3-current-microamp = <10>;
+		};
+
 		palmas_pmic {
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
-- 
2.7.3
