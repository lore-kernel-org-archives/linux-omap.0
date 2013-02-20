From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/8] ARM: dts: OMAP5: Move the gic node out of ocp space
Date: Wed, 20 Feb 2013 21:08:51 +0530
Message-ID: <1361374735-22018-5-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935733Ab3BTPhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:37:42 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <b-cousson@ti.com>

GIC is not part of OCP space so move the gic dt node out of ocp
dt address space.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4c9d984..5b6b72c 100644
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
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
1.7.9.5

