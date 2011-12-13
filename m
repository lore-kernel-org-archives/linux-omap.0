From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/3] ARM: omap4-sdp: Pass regulator data from dt
Date: Tue, 13 Dec 2011 15:49:34 +0530
Message-ID: <1323771575-3550-3-git-send-email-rnayak@ti.com>
References: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38762 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab1LMKUY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 05:20:24 -0500
In-Reply-To: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Pass the adjustable voltage regulator information for
omap4sdp board from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 0ab14cb..daf8b69 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -40,6 +40,42 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vaux1: regulator@0 {
+			compatible = "ti,twl6030-vaux1","ti,twl6030";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vaux2: regulator@1 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		vaux3: regulator@2 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vmmc: regulator@3 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vpp: regulator@4 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2500000>;
+		};
+
+		vusim: regulator@5 {
+			compatible = "ti,twl6030-vusim","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2900000>;
+		};
 	};
 };
 
-- 
1.7.1

