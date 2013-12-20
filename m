From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 REPOST 7/8] ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc and TDA998X HDMI support
Date: Fri, 20 Dec 2013 12:42:35 +0200
Message-ID: <356519246c8bea1ef776924810b824255f166bae.1387535303.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46158 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3LTKnL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 05:43:11 -0500
In-Reply-To: <cover.1387535299.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, tony@atomide.com
Cc: broonie@kernel.org, Jyri Sarha <jsarha@ti.com>

This enables HDMI video support on Beaglebone-Black.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony@atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 254cf05..52b0d92 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -176,6 +176,9 @@ CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
+CONFIG_DRM=m
+CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_TILCDC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5

