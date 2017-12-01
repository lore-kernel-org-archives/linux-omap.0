From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v5 4/5] DTS: gta04: add uart2 child node for w2sg00x4
Date: Fri,  1 Dec 2017 08:49:37 +0100
Message-ID: <1b1c7a8319eaf61a46eebd7a366ea745b7a54634.1512114577.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1512114576.git.hns@goldelico.com>
In-Reply-To: <cover.1512114576.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

GTA04 has a W2SG0004/84 connected to UART2 of the OMAP3
processor. A GPIO can pulse the on/off toggle switch.

The VSIM regulator is used to power on/off the LNA of an external
active GPS antenna so that a driver can turn the LNA off if GPS is
not needed to save battery energy.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..1ad744a25c36 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -477,6 +477,13 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+
+	gps: gps {
+		compatible = "wi2wi,w2sg0004";
+		lna-supply = <&vsim>;   /* LNA regulator */
+		/* GPIO_145: trigger for on/off-impulse for w2sg0004 */
+		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &uart3 {
-- 
2.12.2
