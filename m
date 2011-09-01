From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 06/13] arm/dts: OMAP4: Add i2c controller nodes
Date: Thu, 1 Sep 2011 19:21:22 +0200
Message-ID: <1314897689-17791-7-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40238 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab1IARWj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:22:39 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index b5c798c..fb81a4d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -21,6 +21,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
 	};
 
 	/*
@@ -178,5 +182,33 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 		};
+
+		i2c1: i2c@1 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c1";
+		};
+
+		i2c2: i2c@2 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c2";
+		};
+
+		i2c3: i2c@3 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c3";
+		};
+
+		i2c4: i2c@4 {
+			compatible = "ti,omap4-i2c", "ti,omap-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hwmods = "i2c4";
+		};
 	};
 };
-- 
1.7.0.4

