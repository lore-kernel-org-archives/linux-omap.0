From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 1/4] ARM: dts: LogicPD Torpedo: Add WiLink UART node
Date: Thu,  3 Oct 2019 15:41:44 +0200
Message-ID: <20191003134147.9458-2-sre@kernel.org>
References: <20191003134147.9458-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003134147.9458-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add a node for the UART part of WiLink chip.

This is compile tested only!

Cc: Adam Ford <aford173@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 18c27e85051f..c34ba0ef8b4d 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -50,6 +50,14 @@
 	};
 };
 
+&uart2 {
+	bluetooth {
+		compatible = "ti,wl1283-st";
+		enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162 */
+		max-speed = <3000000>;
+	};
+};
+
 &omap3_pmx_core {
 	mmc3_pins: pinmux_mm3_pins {
 		pinctrl-single,pins = <
-- 
2.23.0
