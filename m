From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 07/13] ARM: dts: dra72-evm: Add CAN support
Date: Mon, 8 Sep 2014 17:10:36 +0300
Message-ID: <1410185442-907-8-git-send-email-rogerq@ti.com>
References: <1410185442-907-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1410185442-907-1-git-send-email-rogerq@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: tglx@linutronix.de, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The board has 2 CAN ports but only the first one can be used.
Enable the first CAN port.

The second one cannot be used without hardware modification
so we don't enable the second port.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 5147023..e5b7172 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -19,6 +19,29 @@
 	};
 };
 
+&dra7_pmx_core {
+	dcan1_pins_default: dcan1_pins_default {
+		pinctrl-single,pins = <
+			0x3d4	(PIN_INPUT | MUX_MODE0)		/* dcan1_tx */
+			0x418	(PIN_INPUT | MUX_MODE1)		/* wakeup0.dcan1_rx */
+		>;
+	};
+
+	dcan1_pins_sleep: dcan1_pins_sleep {
+		pinctrl-single,pins = <
+			0x3d4	(PIN_INPUT | MUX_MODE15)	/* dcan1_tx.off */
+			0x418	(PIN_INPUT | MUX_MODE15)	/* wakeup0.off */
+		>;
+	};
+};
+
 &uart1 {
 	status = "okay";
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
