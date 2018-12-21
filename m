From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 02/14] ARM: dts: IGEP: Add WiLink UART node
Date: Fri, 21 Dec 2018 02:17:40 +0100
Message-ID: <20181221011752.25627-3-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add a node for the UART part of WiLink chip.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
This is compile tested only!
---
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 8 ++++++++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
index 285681d7af49..8bb4298ca05e 100644
--- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
+++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
@@ -52,3 +52,11 @@
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
index 1adc73bd2ca0..03be171e9de7 100644
--- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
+++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
@@ -74,3 +74,11 @@
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
2.19.2
