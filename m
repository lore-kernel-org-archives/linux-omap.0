From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 1/4] omapdrm: panel: fix compatible vendor string for
 td028ttec1
Date: Tue, 28 Nov 2017 16:48:54 +0100
Message-ID: <6ae8f4b7d794c536650cc99025e5b026089cea30.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The vendor name was "toppoly" but other panels and the vendor list
have defined it as "tpo". So let's fix it in driver and bindings.

We keep the old definition in parallel to stay compatible with
potential older DTB setup.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 3 +++
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

diff --git a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
similarity index 84%
rename from Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
rename to Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
index 7175dc3740ac..ed34253d9fb1 100644
--- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
@@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
 ========================
 
 Required properties:
-- compatible: "toppoly,td028ttec1"
+- compatible: "tpo,td028ttec1"
 
 Optional properties:
 - label: a symbolic name for the panel
@@ -14,7 +14,7 @@ Example
 -------
 
 lcd-panel: td028ttec1@0 {
-	compatible = "toppoly,td028ttec1";
+	compatible = "tpo,td028ttec1";
 	reg = <0>;
 	spi-max-frequency = <100000>;
 	spi-cpol;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index 0a38a0e8c925..a0dfa14f4fab 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
+	{ .compatible = "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible = "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -471,6 +473,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 57e9e146ff74..4aeb908f2d1e 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -455,6 +455,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
+	{ .compatible = "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible = "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -474,6 +476,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
-- 
2.12.2
