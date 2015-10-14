From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 13:44:16 +0300
Message-ID: <1444819456-26728-3-git-send-email-rogerq@ti.com>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444819456-26728-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: wsa@the-dreams.de, sre@kernel.org, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Let's keep the SSI ports disabled in the omap3.dtsi to avoid
getting the following noise on the console for boards that don't
use the SSI ports.

"omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=-2)"

As omap3-n900 uses one SSI port, mark it enabled there.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 1 +
 arch/arm/boot/dts/omap3.dtsi     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 5f5e0f3..bdb72fb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -949,6 +949,7 @@
 };
 
 &ssi_port1 {
+	status = "ok";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ssi_pins>;
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8a2b253..25b0b37 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -815,6 +815,7 @@
 				interrupt-parent = <&intc>;
 				interrupts = <67>,
 					     <68>;
+				status = "disabled";
 			};
 
 			ssi_port2: ssi-port@4805b000 {
@@ -828,6 +829,7 @@
 				interrupt-parent = <&intc>;
 				interrupts = <69>,
 					     <70>;
+				status = "disabled";
 			};
 		};
 	};
-- 
2.1.4
