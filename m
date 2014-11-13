From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 01/10] ARM: dts: dra7: Add syscon regmap for CORE CONTROL area
Date: Thu, 13 Nov 2014 14:22:42 +0200
Message-ID: <1415881371-4982-2-git-send-email-rogerq@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415881371-4982-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

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
index 9cc9843..5fd52cd 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -201,6 +201,11 @@
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

