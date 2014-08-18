From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 7/8] ARM: OMAP2+: omap2plus_defconfig: TDA998X HDMI trough tilcdc,slave
Date: Tue, 19 Aug 2014 00:46:45 +0300
Message-ID: <2eb2bb5cecb95727986abdb3c76cf925d2a9ef9c.1408397864.git.jsarha@ti.com>
References: <cover.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34972 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbaHRVrI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2014 17:47:08 -0400
In-Reply-To: <cover.1408397864.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, ezequiel.garcia@free-electrons.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>

Select CONFIG_DRM=m, CONFIG_DRM_I2C_NXP_TDA998X=m, and
CONFIG_DRM_TILCDC=m, for Beaglebone-Black HDMI video support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index f650f00..97eade2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -193,6 +193,9 @@ CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_PBIAS=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5

