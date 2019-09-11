From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable DRM_TI_TFP410
Date: Wed, 11 Sep 2019 12:46:47 -0500
Message-ID: <20190911174647.29721-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, sre@kernel.org, Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The TFP410 driver was removed but the replacement driver was
never enabled.  This patch enableds the DRM_TI_TFP410

Fixes: be3143d8b27f ("drm/omap: Remove TFP410 and DVI connector drivers")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a0449d3b48a5..d384c13de19a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -359,6 +359,7 @@ CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
 CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
 CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
 CONFIG_DRM_TILCDC=m
+CONFIG_DRM_TI_TFP410=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.17.1
