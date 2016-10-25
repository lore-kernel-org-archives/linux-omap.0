From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/2] dts: omap5: baord-common: enable twl6040 headset jack detection
Date: Tue, 25 Oct 2016 18:48:26 +0200
Message-ID: <7771a9fb3b9133fc361c87970444c1a3918891d0.1477414105.git.hns@goldelico.com>
References: <cover.1477414105.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477414105.git.hns@goldelico.com>
In-Reply-To: <cover.1477414105.git.hns@goldelico.com>
References: <cover.1477414105.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index b04adee..91456b4 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -124,6 +124,7 @@
 		compatible = "ti,abe-twl6040";
 		ti,model = "omap5-uevm";
 
+		ti,jack_detection;
 		ti,mclk-freq = <19200000>;
 
 		ti,mcpdm = <&mcpdm>;
-- 
2.7.3
