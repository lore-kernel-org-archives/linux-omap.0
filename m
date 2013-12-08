From: Jyri Sarha <jsarha@ti.com>
Subject: [RFC v2 8/8] ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio support
Date: Sun, 8 Dec 2013 14:16:51 +0200
Message-ID: <e278754ab32a2fdd25e2a7e90cedbdbcd146c1e4.1386503348.git.jsarha@ti.com>
References: <cover.1386503347.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60305 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab3LHMRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Dec 2013 07:17:39 -0500
In-Reply-To: <cover.1386503347.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, tony@atomide.com

Select following:
CONFIG_SND_DAVINCI_SOC=m
CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m

Signed-off-by: Jyri Sarha <jsarha@ti.com>
cc: tony@atomide.com
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 52b0d92..c1a9730 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -216,6 +216,8 @@ CONFIG_SND_OMAP_SOC=m
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

