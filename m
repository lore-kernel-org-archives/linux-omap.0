From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 04/11] ARM: dts: OMAP5: Move the gic node out of ocp space
Date: Tue, 19 Mar 2013 19:00:50 +0530
Message-ID: <1363699857-5505-5-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32939 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab3CSN3j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:39 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

GIC is not part of OCP space so move the gic dt node out of ocp
dt address space.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 71be239..4701244 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -18,6 +18,9 @@
 /include/ "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	compatible = "ti,omap5";
 	interrupt-parent = <&gic>;
 
@@ -47,6 +50,14 @@
 		clock-frequency = <6144000>;
 	};
 
+	gic: interrupt-controller@48211000 {
+		compatible = "arm,cortex-a15-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48211000 0x1000>,
+		      <0x48212000 0x1000>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
@@ -96,14 +107,6 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
-		gic: interrupt-controller@48211000 {
-			compatible = "arm,cortex-a15-gic";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			reg = <0x48211000 0x1000>,
-			      <0x48212000 0x1000>;
-		};
-
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
1.7.9.5

