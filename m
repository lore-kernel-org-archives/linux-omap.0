From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 06/10] arm/dts: OMAP3: Add i2c controller nodes
Date: Fri, 9 Dec 2011 15:02:37 +0100
Message-ID: <1323439361-1647-7-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab1LIOD3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:03:29 -0500
In-Reply-To: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6866dc7..81d8e2c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,5 +61,33 @@
 			ti,intc-size = <96>;
 			reg = <0x48200000 0x1000>;
 		};
+
+		/*
+		 * Flags for all i2c instances: 0x118
+		 * APPLY_ERRATA_I207 | RESET_REGS_POSTIDLE | BUS_SHIFT_2
+		 */
+		i2c1: i2c@1 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+			ti,flags = <0x118>;
+		};
+
+		i2c2: i2c@2 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+			ti,flags = <0x118>;
+		};
+
+		i2c3: i2c@3 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+			ti,flags = <0x118>;
+		};
 	};
 };
-- 
1.7.0.4

