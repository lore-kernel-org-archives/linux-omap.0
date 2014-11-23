From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 2/4] ARM: dts: cm-t3x: add TV out support
Date: Sun, 23 Nov 2014 11:42:00 +0200
Message-ID: <1416735722-26167-3-git-send-email-lifshitz@compulab.co.il>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52248 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbaKWJma (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Nov 2014 04:42:30 -0500
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add TV out support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 620a3f4..63bea24 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -56,6 +56,17 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	tv0: connector@1 {
+		compatible = "svideo-connector";
+		label = "tv";
+
+		port {
+			tv_connector_in: endpoint {
+				remote-endpoint = <&venc_out>;
+			};
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -221,3 +232,14 @@
 		linux,wakeup;
 	};
 };
+
+&venc {
+	status = "ok";
+
+	port {
+		venc_out: endpoint {
+			remote-endpoint = <&tv_connector_in>;
+			ti,channels = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 3cbaf98..9cc7185 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -66,6 +66,10 @@
 #include "twl4030_omap3.dtsi"
 #include <dt-bindings/input/input.h>
 
+&venc {
+	vdda-supply = <&vdac>;
+};
+
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 };
-- 
1.7.5.4

