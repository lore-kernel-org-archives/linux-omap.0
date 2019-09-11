From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/2] ARM: omap2plus_defconfig: Update for removed items
Date: Wed, 11 Sep 2019 09:52:25 -0500
Message-ID: <20190911145226.21088-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omap panel-dpi driver was removed in
Commit 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

The tFP410 and DVI connector was remove in
Commit be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")

This patch removes these items from the omap2plus_defconfig.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c7bf9c493646..166b36be2ca6 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -349,12 +349,9 @@ CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
 CONFIG_DRM_OMAP_ENCODER_OPA362=m
-CONFIG_DRM_OMAP_ENCODER_TFP410=m
 CONFIG_DRM_OMAP_ENCODER_TPD12S015=m
-CONFIG_DRM_OMAP_CONNECTOR_DVI=m
 CONFIG_DRM_OMAP_CONNECTOR_HDMI=m
 CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV=m
-CONFIG_DRM_OMAP_PANEL_DPI=m
 CONFIG_DRM_OMAP_PANEL_DSI_CM=m
 CONFIG_DRM_OMAP_PANEL_SONY_ACX565AKM=m
 CONFIG_DRM_OMAP_PANEL_LGPHILIPS_LB035Q02=m
-- 
2.17.1
