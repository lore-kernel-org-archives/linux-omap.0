From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 05/11] arm/dts: OMAP3: Add i2c controller nodes
Date: Tue, 20 Dec 2011 17:27:18 +0100
Message-ID: <1324398444-23296-6-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53393 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab1LTQ2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 11:28:04 -0500
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Add i2c controllers nodes into the main ocp bus.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6866dc7..697b210 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -61,5 +61,26 @@
 			ti,intc-size = <96>;
 			reg = <0x48200000 0x1000>;
 		};
+
+		i2c1: i2c@1 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+		};
+
+		i2c2: i2c@2 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+		};
+
+		i2c3: i2c@3 {
+			compatible = "ti,omap3-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+		};
 	};
 };
-- 
1.7.0.4

