From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/3] dt-bindings: Add Logic PD Type 28 display panel
Date: Tue, 17 Sep 2019 11:12:12 -0500
Message-ID: <20190917161214.2913-2-aford173@gmail.com>
References: <20190917161214.2913-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190917161214.2913-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds documentation of device tree bindings for the WVGA panel
Logic PD Type 28 display.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt b/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt
new file mode 100644
index 000000000000..829fc5210e06
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.txt
@@ -0,0 +1,26 @@
+Logic PD Type 28 4.3" WQVGA TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "logicpd,type28"
+
+Optional properties:
+- power-supply: regulator to provide the supply voltage
+- enable-gpios: GPIO pin to enable or disable the panel
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for RGB input.
+
+Example:
+	lcd0: display {
+		compatible = "logicpd,type28";
+		enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
-- 
2.17.1
