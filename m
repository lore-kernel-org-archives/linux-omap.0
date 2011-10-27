From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] omap4: panda: Pass regulator data from DT
Date: Thu, 27 Oct 2011 13:34:34 +0530
Message-ID: <1319702674-16304-4-git-send-email-rnayak@ti.com>
References: <1319702674-16304-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51177 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab1J0IFc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Oct 2011 04:05:32 -0400
In-Reply-To: <1319702674-16304-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

Pass the fixed and adjustable voltage regulator information for
omap4panda board from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 2c6ce2b..4c3069f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -48,6 +48,40 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vwl1271: fixedregulator@0 {
+			compatible = "regulator-fixed";
+			regulator-fixed-supply = "vwl1271";
+			regulator-fixed-microvolts = <1800000>;
+			regulator-fixed-gpio = <43>;
+			regulator-fixed-startup-delay = <70000>;
+			regulator-fixed-enable-high;
+			regulator-fixed-enabled-at-boot;
+		};
+
+		vaux2: regulator@0 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <2800000>;
+		};
+
+		vaux3: regulator@1 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-uV = <1000000>;
+			regulator-max-uV = <3000000>;
+		};
+
+		vmmc: regulator@2 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-uV = <1200000>;
+			regulator-max-uV = <3000000>;
+		};
+
+		vpp: regulator@3 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-uV = <1800000>;
+			regulator-max-uV = <2500000>;
+		};
 	};
 };
 
-- 
1.7.1

