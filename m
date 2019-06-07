From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/5] dt-bindings: drm/panel: simple: add ortustech,com37h3m05dtc panel
Date: Fri,  7 Jun 2019 13:11:09 +0200
Message-ID: <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
References: <cover.1559905870.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559905870.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../display/panel/ortustech,com37h3m05dtc.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
new file mode 100644
index 000000000000..c16907c02f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
@@ -0,0 +1,12 @@
+OrtusTech COM37H3M05DTC Blanview 3.7" VGA portrait TFT-LCD panel
+
+Required properties:
+- compatible: should be "ortustech,com37h3m05dtc"
+
+Optional properties:
+- enable-gpios: GPIO pin to enable or disable the panel
+- backlight: phandle of the backlight device attached to the panel
+- power-supply: phandle of the regulator that provides the supply voltage
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.19.1
