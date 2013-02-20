From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/8] ARM: dts: OMAP5: Align the local timer dt node as per the current binding code
Date: Wed, 20 Feb 2013 21:08:49 +0530
Message-ID: <1361374735-22018-3-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58828 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935799Ab3BTPho (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:37:44 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <b-cousson@ti.com>

It has been decided to not duplicate banked modules dt nodes and that is
how the current arch timer dt extraction code is.

Update the OMAP5 dt file accordingly.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..6609754 100644
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

