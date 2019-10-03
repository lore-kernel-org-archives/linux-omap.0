From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Fix selected panels after generic
 panel changes
Date: Thu,  3 Oct 2019 09:55:39 -0700
Message-ID: <20191003165539.50318-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

The old omapdrm panels got removed for v5.4 in favor of generic panels,
and the Kconfig options changed. Let's update omap2plus_defconfig
accordingly so the same panels are still enabled.

Cc: Jyri Sarha <jsarha@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -356,14 +356,14 @@ CONFIG_DRM_OMAP_CONNECTOR_HDMI=m
 CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV=m
 CONFIG_DRM_OMAP_PANEL_DPI=m
 CONFIG_DRM_OMAP_PANEL_DSI_CM=m
-CONFIG_DRM_OMAP_PANEL_SONY_ACX565AKM=m
-CONFIG_DRM_OMAP_PANEL_LGPHILIPS_LB035Q02=m
-CONFIG_DRM_OMAP_PANEL_SHARP_LS037V7DW01=m
-CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
-CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
-CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
 CONFIG_DRM_TILCDC=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_PANEL_LG_LB035Q02=m
+CONFIG_DRM_PANEL_NEC_NL8048HL11=m
+CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
+CONFIG_DRM_PANEL_SONY_ACX565AKM=m
+CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
+CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.23.0
