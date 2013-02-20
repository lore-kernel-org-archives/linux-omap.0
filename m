From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/8] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer
Date: Wed, 20 Feb 2013 21:08:50 +0530
Message-ID: <1361374735-22018-4-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58832 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935848Ab3BTPhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:37:48 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Specify both secure as well as nonsecure PPI IRQ for arch
timer. This fixes the following errors seen on DT OMAP5 boot..

[    0.000000] arch_timer: No interrupt available, giving up

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6609754..4c9d984 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -41,8 +41,9 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		/* 14th PPI IRQ, active low level-sensitive */
-		interrupts = <1 14 0x308>;
+		/* PPI secure/nonsecure IRQ, active low level-sensitive */
+		interrupts = <1 13 0x308>,
+			     <1 14 0x308>;
 		clock-frequency = <6144000>;
 	};
 
-- 
1.7.9.5

