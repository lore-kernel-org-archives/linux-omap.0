From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 02/11] ARM: dts: OMAP5: Align the local timer dt node as per the current binding code
Date: Tue, 19 Mar 2013 19:00:48 +0530
Message-ID: <1363699857-5505-3-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab3CSN3h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:37 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

It has been decided to not duplicate banked modules dt nodes and that is
how the current arch timer dt extraction code is.

Update the OMAP5 dt file accordingly.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b760c11..aefecf7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -33,24 +33,19 @@
 	cpus {
 		cpu@0 {
 			compatible = "arm,cortex-a15";
-			timer {
-				compatible = "arm,armv7-timer";
-				/* 14th PPI IRQ, active low level-sensitive */
-				interrupts = <1 14 0x308>;
-				clock-frequency = <6144000>;
-			};
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a15";
-			timer {
-				compatible = "arm,armv7-timer";
-				/* 14th PPI IRQ, active low level-sensitive */
-				interrupts = <1 14 0x308>;
-				clock-frequency = <6144000>;
-			};
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		/* 14th PPI IRQ, active low level-sensitive */
+		interrupts = <1 14 0x308>;
+		clock-frequency = <6144000>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
-- 
1.7.9.5

