From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/8] ARM: dts: OMAP5: Update the timer and gic nodes for HYP kernel support
Date: Wed, 20 Feb 2013 21:08:52 +0530
Message-ID: <1361374735-22018-6-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935845Ab3BTPhp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:37:45 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <b-cousson@ti.com>

To be able to run kernel in HYP mode, virtual timer and gic node information
needs to be popullated.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5b6b72c..fa0c66b 100644
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

