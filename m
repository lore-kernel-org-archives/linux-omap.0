From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 19/19] ARM: omap2plus_defconfig: Enable OMAP4+ HDMI audio support
Date: Mon, 12 May 2014 12:12:30 +0300
Message-ID: <f6446d5ea83e0b90f7b2ac4af2fdc3fa2b0ec381.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45082 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbaELJNP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:13:15 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This patch is here only as an example on how to enable HDMI audio for
OMAP4+ HW. Adds CONFIG_SND_SIMPLE_CARD=m and CONFIG_SND_SOC_HDMI_CODEC=m.
Also builds SND_OMAP_SOC in kernel to support in kernel built OMAPDSS
with integrated HDMI DAI driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 363733e..8b512c7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -204,20 +204,22 @@ CONFIG_LCD_PLATFORM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
-CONFIG_SOUND=m
-CONFIG_SND=m
+CONFIG_SOUND=y
+CONFIG_SND=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
-CONFIG_SND_SOC=m
-CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_SOC=y
+CONFIG_SND_OMAP_SOC=y
 CONFIG_SND_AM33XX_SOC_EVM=m
 CONFIG_SND_DAVINCI_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SOC_HDMI_CODEC=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.7.9.5

