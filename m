From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 6/9] ARM: dts: cm-t3x: add TV out support
Date: Tue, 18 Nov 2014 11:13:21 +0200
Message-ID: <1416302004-22199-7-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:44900 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbaKRJNq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 04:13:46 -0500
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add TV out support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 58205f0..1a8262c 100644
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
@@ -214,3 +225,16 @@
 		linux,wakeup;
 	};
 };
+
+&venc {
+	status = "ok";
+
+	vdda-supply = <&vdac>;
+
+	port {
+		venc_out: endpoint {
+			remote-endpoint = <&tv_connector_in>;
+			ti,channels = <2>;
+		};
+	};
+};
-- 
1.7.5.4

