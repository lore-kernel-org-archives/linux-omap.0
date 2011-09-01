From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/7] arm/dts: OMAP3: Add i2c controllers nodes
Date: Thu, 1 Sep 2011 19:25:08 +0200
Message-ID: <1314897912-18178-4-git-send-email-b-cousson@ti.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466Ab1IARZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:25:37 -0400
In-Reply-To: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 5a95a69..aab2129 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -13,6 +13,12 @@
 / {
 	compatible = "ti,omap3430", "ti,omap3";
 
+	aliases {
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
 	/*
 	 * XXX: The cpus node is mandatory, but since the CPUs are as well part
 	 * of the mpu subsystem below, it is not clear where the information
@@ -64,5 +70,26 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
+
+		i2c1: i2c@1 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c1";
+		};
+
+		i2c2: i2c@2 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c2";
+		};
+
+		i2c3: i2c@3 {
+			compatible = "ti,omap3-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c3";
+		};
 	};
 };
-- 
1.7.0.4

