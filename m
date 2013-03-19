From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 03/11] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer
Date: Tue, 19 Mar 2013 19:00:49 +0530
Message-ID: <1363699857-5505-4-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab3CSN3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 09:29:36 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Specify both secure as well as nonsecure PPI IRQ for arch
timer. This fixes the following errors seen on DT OMAP5 boot..

[    0.000000] arch_timer: No interrupt available, giving up

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index aefecf7..71be239 100644
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

