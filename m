From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/2] dts: omap5: baord-common: add phandle to reference Palmas gpadc
Date: Tue, 25 Oct 2016 18:48:25 +0200
Message-ID: <500798689d98862d94e4ef6c11c61ddb0f0281bc.1477414105.git.hns@goldelico.com>
References: <cover.1477414105.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477414105.git.hns@goldelico.com>
In-Reply-To: <cover.1477414105.git.hns@goldelico.com>
References: <cover.1477414105.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Will be needed for iio based drivers.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 7500283..b04adee 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -415,7 +415,7 @@
 			ti,backup-battery-charge-high-current;
 		};
 
-		gpadc {
+		gpadc: gpadc {
 			compatible = "ti,palmas-gpadc";
 			interrupts = <18 0
 				      16 0
-- 
2.7.3
