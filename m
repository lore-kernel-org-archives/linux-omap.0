From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 4/5] DTS: gta04: add serdev node for w2sg00x4
Date: Sun, 12 Nov 2017 21:59:57 +0100
Message-ID: <55121e359ace8568711411de7da68205fc039d56.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

GTA04 has a W2SG0004/84 connected to UART2 of the OMAP3
processor. A GPIO can pulse the on/off toggle switch.

The VSIM regulator is used to power on/off the LNA of an external
active GPS antenna so that a driver can turn the LNA off if GPS is
not needed to save battery energy.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..e967d738aaaf 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -477,6 +477,12 @@
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
+
+	gps: gps {
+		compatible = "wi2wi,w2sg0004";
+		lna-supply = <&vsim>;   /* LNA regulator */
+		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
+	};
 };
 
 &uart3 {
-- 
2.12.2
