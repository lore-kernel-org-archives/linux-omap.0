From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 2/4] ARM: dts: IGEP: Add WiLink UART node
Date: Thu,  3 Oct 2019 15:41:45 +0200
Message-ID: <20191003134147.9458-3-sre@kernel.org>
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

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 8 ++++++++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 03dcd05fb8a0..001decc20b3d 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -49,3 +49,11 @@
 		interrupts = <17 IRQ_TYPE_EDGE_RISING>; /* gpio 177 */
 	};
 };
+
+&uart2 {
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>; /* gpio 137 */
+		max-speed = <300000>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
index 060acd1e803a..9a8975799e16 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -71,3 +71,11 @@
 		interrupts = <8 IRQ_TYPE_EDGE_RISING>; /* gpio 136 */
 	};
 };
+
+&uart2 {
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>; /* gpio 137 */
+		max-speed = <300000>;
+	};
+};
-- 
2.23.0
