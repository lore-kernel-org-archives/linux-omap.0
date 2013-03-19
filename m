From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 08/11] ARM: dts: OMAP4/5: Update l3-noc dt nodes
Date: Tue, 19 Mar 2013 19:00:54 +0530
Message-ID: <1363699857-5505-9-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51638 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab3CSN3m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:42 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add l3-noc node for OMAP4 and OMAP5 devices.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 arch/arm/boot/dts/omap5.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index ddfc54a..3329140 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -94,6 +94,11 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+		reg = <0x44000000 0x1000>,
+		      <0x44800000 0x2000>,
+		      <0x45000000 0x1000>;
+		interrupts = <0 41 0x4>,
+			     <0 42 0x4>;
 
 		counter32k: counter@4a304000 {
 			compatible = "ti,omap-counter32k";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e539258..59e05c5 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -87,6 +87,11 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
+		reg = <0x44000000 0x2000>,
+		      <0x44800000 0x3000>,
+		      <0x45000000 0x4000>;
+		interrupts = <0 41 0x4>,
+			     <0 42 0x4>;
 
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
-- 
1.7.9.5

