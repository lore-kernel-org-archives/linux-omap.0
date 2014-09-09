From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 06/12] ARM: dts: AM43xx: Add aliases to d_can nodes
Date: Tue, 9 Sep 2014 17:55:28 +0300
Message-ID: <1410274534-22826-7-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817AbaIIO4N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Sep 2014 10:56:13 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The d_can driver expects appropriately named aliases for
the d_can nodes for the RAMINIT control register access.

Provide those, otherwise RAMINIT register won't be configured.
Get's rid of the following messages during boot.

[   16.419354] c_can_platform 481cc000.can: control memory is not used for raminit
[   16.449142] c_can_platform 481d0000.can: control memory is not used for raminit

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 3514d0a..a705e50 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -25,6 +25,8 @@
 		serial0 = &uart0;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
+		d_can0 = &dcan0;
+		d_can1 = &dcan1;
 	};
 
 	cpus {
-- 
1.8.3.2

