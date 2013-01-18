From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer
Date: Fri, 18 Jan 2013 21:02:21 +0530
Message-ID: <1358523141-12295-6-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab3ARPbh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 10:31:37 -0500
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Specify both secure as well as nonsecure PPI IRQ for arch
timer. This fixes the following errors seen on DT OMAP5 boot..

[    0.000000] arch_timer: No interrupt available, giving up

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..7a78d1b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -35,8 +35,12 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				/* 14th PPI IRQ, active low level-sensitive */
-				interrupts = <1 14 0x308>;
+				/*
+				 * PPI secure/nonsecure IRQ,
+				 * active low level-sensitive
+				 */
+				interrupts = <1 13 0x308>,
+					     <1 14 0x308>;
 				clock-frequency = <6144000>;
 			};
 		};
@@ -44,8 +48,12 @@
 			compatible = "arm,cortex-a15";
 			timer {
 				compatible = "arm,armv7-timer";
-				/* 14th PPI IRQ, active low level-sensitive */
-				interrupts = <1 14 0x308>;
+				/*
+				 * PPI secure/nonsecure IRQ,
+				 * active low level-sensitive
+				 */
+				interrupts = <1 13 0x308>,
+					     <1 14 0x308>;
 				clock-frequency = <6144000>;
 			};
 		};
-- 
1.7.9.5

