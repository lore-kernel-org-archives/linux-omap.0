From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 7/8] ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc and TDA998X HDMI support
Date: Mon, 27 Jan 2014 17:37:56 +0200
Message-ID: <6bc6cf572b55bcc572d14c39a8dd3b85380f7d59.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37496 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaA0Pi6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jan 2014 10:38:58 -0500
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, tony@atomide.com

This enables HDMI video support on Beaglebone-Black.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony@atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bfa80a1..9288172 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -180,6 +180,9 @@ CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5

