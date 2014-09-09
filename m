From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 01/12] ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
Date: Tue, 9 Sep 2014 17:55:23 +0300
Message-ID: <1410274534-22826-2-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668AbaIIOz4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Sep 2014 10:55:56 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Display and DCAN drivers use syscon regmap to access some registers
in the CORE control area. Add the syscon regmap node for this
area.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d678152..370009e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -200,6 +200,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dra7_ctrl_core: ctrl_core@4a002000 {
+			compatible = "syscon";
+			reg = <0x4a002000 0x6d0>;
+		};
+
 		dra7_ctrl_general: tisyscon@4a002e00 {
 			compatible = "syscon";
 			reg = <0x4a002e00 0x7c>;
-- 
1.8.3.2

