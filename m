From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 05/11] ARM: dts: OMAP5: Update the timer and gic nodes for HYP kernel support
Date: Tue, 19 Mar 2013 19:00:51 +0530
Message-ID: <1363699857-5505-6-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57869 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500Ab3CSN3j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:39 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

To be able to run kernel in HYP mode, virtual timer and gic node information
needs to be popullated.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4701244..ff09720 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -46,7 +46,9 @@
 		compatible = "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ, active low level-sensitive */
 		interrupts = <1 13 0x308>,
-			     <1 14 0x308>;
+			     <1 14 0x308>,
+			     <1 11 0x308>,
+			     <1 10 0x308>;
 		clock-frequency = <6144000>;
 	};
 
@@ -55,7 +57,9 @@
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0x48211000 0x1000>,
-		      <0x48212000 0x1000>;
+		      <0x48212000 0x1000>,
+		      <0x48214000 0x2000>,
+		      <0x48216000 0x2000>;
 	};
 
 	/*
-- 
1.7.9.5

