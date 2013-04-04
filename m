From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: dts: OMAP4+: Correct L3 interrupts
Date: Thu, 4 Apr 2013 13:06:30 -0500
Message-ID: <1365098790-9078-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33673 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764294Ab3DDSGr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 14:06:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The L3 interrupt numbers are incorrect for OMAP4+ and are conflicting
with some of the timer interrupts causing the allocation of timer
interrupts to fail.

The problem is caused by adding 32 to the interrupt number for the L3
interrupts to account for per processor interrupts (PPI) and software
generated interrupts (SGI) which typically are mapped to the first 32
interrupts in the ARM GIC. This is not necessary because the first
parameter of the ARM GIC interrupt property specifies the GIC interrupt
type (ie. SGI, PPI, etc). Hence, fix the interrupt number fo the L3
interrupts by substracting 32.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---

Please note that this problem is observed in Benoit's for_3.10/dts branch [1].

[1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git

 arch/arm/boot/dts/omap4.dtsi |    4 ++--
 arch/arm/boot/dts/omap5.dtsi |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3329140..3ae6a3f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -97,8 +97,8 @@
 		reg = <0x44000000 0x1000>,
 		      <0x44800000 0x2000>,
 		      <0x45000000 0x1000>;
-		interrupts = <0 41 0x4>,
-			     <0 42 0x4>;
+		interrupts = <0 9 0x4>,
+			     <0 10 0x4>;
 
 		counter32k: counter@4a304000 {
 			compatible = "ti,omap-counter32k";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f4c71d9..86f784e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -90,8 +90,8 @@
 		reg = <0x44000000 0x2000>,
 		      <0x44800000 0x3000>,
 		      <0x45000000 0x4000>;
-		interrupts = <0 41 0x4>,
-			     <0 42 0x4>;
+		interrupts = <0 9 0x4>,
+			     <0 10 0x4>;
 
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
-- 
1.7.10.4

