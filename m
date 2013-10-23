From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 4/4] arm: omap2plus_defconfig: enable AM33xx SOC EVM audio
Date: Wed, 23 Oct 2013 15:30:16 +0300
Message-ID: <7460251f6a5b21ca843c652a35dfb042a3c54b42.1382529191.git.jsarha@ti.com>
References: <cover.1382529191.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab3JWMae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Oct 2013 08:30:34 -0400
In-Reply-To: <cover.1382529191.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, joelf@ti.com, tony@atomide.com, Jyri Sarha <jsarha@ti.com>

Modifying the omap2plus_defconfig to enable the audio support for
AM335x EVM and other AM33xx based devices with TLV320AIC3X connected
to McASP.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 254cf05..4443b92 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -210,6 +210,8 @@ CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_AM33XX_SOC_EVM=m
+CONFIG_SND_DAVINCI_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
-- 
1.7.9.5

