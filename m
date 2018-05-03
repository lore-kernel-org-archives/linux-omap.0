From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 2/6] dt-bindings: gnss: add w2sg0004 bindings documentation
Date: Thu,  3 May 2018 11:35:47 +0200
Message-ID: <851a39473dcdd852040c59b83ef50c3318e74c87.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, afd@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add bindings documentation for Wi2Wi W2SG0004 GPS module.

This is a quite old module which does not support a WAKEUP
line and hence can't use a generic SirfStar driver.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gnss/wi2wi,w2sg0004.txt    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/wi2wi,w2sg0004.txt

diff --git a/Documentation/devicetree/bindings/gnss/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/gnss/wi2wi,w2sg0004.txt
new file mode 100644
index 000000000000..ac4ec479ea98
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/wi2wi,w2sg0004.txt
@@ -0,0 +1,23 @@
+Wi2Wi W2SG0004 GPS module connected through UART
+
+Should be a subnode of the SoC UART it is connected to.
+
+Required properties:
+- compatible:	must be
+	"wi2wi,w2sg0004"
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
