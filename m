From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/5] DT: misc: w2sg0004: add bindings documentation (GPS module with serdev UART)
Date: Sun, 12 Nov 2017 21:59:55 +0100
Message-ID: <069ce12d5609c4e968f2a468e6c58a57f59f3ffb.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
In-Reply-To: <cover.1510520397.git.hns@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

add bindings documentation for Wi2Wi W2SG00x4 GPS module

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt

diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
new file mode 100644
index 000000000000..ccec9361a1a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
@@ -0,0 +1,24 @@
+Wi2Wi GPS module connected through UART
+
+Should be a subnode of the SoC UART it is connected to (serdev).
+
+Required properties:
+- compatible:	should be one of (depending on precise model)
+	"wi2wi,w2sg0004"
+	"wi2wi,w2sg0084"
+- enable-gpio:	the GPIO that controls the module's power toggle
+	input. A positive impulse of sufficent length toggles the
+	power state.
+
+Optional properties:
+- lna-supply:	an (optional) LNA regulator that is enabled together with the GPS receiver
+
+Example:
+
+&uart2 {
+	w2sg0004: gps {
+		compatible = "wi2wi,w2sg0004";
+		lna-supply = <&vsim>;   /* LNA regulator */
+		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
+        };
+};
-- 
2.12.2
