From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 8/8] ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio support
Date: Mon, 27 Jan 2014 17:37:57 +0200
Message-ID: <7bb9708316dc4f8e68c4b36dafa5a0432a232da8.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54449 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbaA0PjA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jan 2014 10:39:00 -0500
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, tony@atomide.com

Select following:
CONFIG_SND_DAVINCI_SOC=m
CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony@atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9288172..62c4f51 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -214,6 +214,8 @@ CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_DAVINCI_SOC=m
+CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.7.9.5

