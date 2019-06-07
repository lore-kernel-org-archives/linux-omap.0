From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 5/5] dt-bindings: drm/panel: simple: add sharp,lq070y3dg3b panel
Date: Fri,  7 Jun 2019 13:11:11 +0200
Message-ID: <ee90ed56d2c294ce8ac3b44bf2229c5ab9f85e91.1559905870.git.hns@goldelico.com>
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
 .../bindings/display/panel/sharp,lq070y3dg3b.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
new file mode 100644
index 000000000000..95534b55ee5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
@@ -0,0 +1,12 @@
+Sharp LQ070Y3DG3B 7.0" WVGA landscape TFT LCD panel
+
+Required properties:
+- compatible: should be "sharp,lq070y3dg3b"
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
