From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 03/10] ARM: dts: dra7-evm: Add CAN support
Date: Tue, 4 Nov 2014 12:48:47 +0200
Message-ID: <1415098134-26405-4-git-send-email-rogerq@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The board has 2 CAN ports but only the first one can be used.
Enable the first CAN port.

WAKEUP0 pin doesn't have INPUT enable bit so we just disable
weak PULLs.

The second CAN port cannot be used without hardware modification
so we don't enable the second port.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index c6ce625..8c2c37b 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -171,6 +171,22 @@
 			0xd0	(PIN_OUTPUT | MUX_MODE0)	/* gpmc_be0n_cle */
 		>;
 	};
+
+	dcan1_pins_default: dcan1_pins_default {
+		pinctrl-single,pins = <
+			0x3d0   (PIN_OUTPUT | MUX_MODE0) /* dcan1_tx */
+			0x3d4   (MUX_MODE15)		/* dcan1_rx.off */
+			0x418   (PULL_DIS | MUX_MODE1) /* wakeup0.dcan1_rx */
+		>;
+	};
+
+	dcan1_pins_sleep: dcan1_pins_sleep {
+		pinctrl-single,pins = <
+			0x3d0   (MUX_MODE15)	/* dcan1_tx.off */
+			0x3d4   (MUX_MODE15)	/* dcan1_rx.off */
+			0x418   (MUX_MODE15)	/* wakeup0.off */
+		>;
+	};
 };
 
 &i2c1 {
@@ -528,3 +544,10 @@
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
+
+&dcan1 {
+	status = "ok";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dcan1_pins_default>;
+	pinctrl-1 = <&dcan1_pins_sleep>;
+};
-- 
1.8.3.2

