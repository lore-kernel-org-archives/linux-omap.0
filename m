From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RESEND] arm: omap2plus_defconfig: enable AM33xx SOC EVM audio
Date: Tue, 5 Nov 2013 10:42:38 +0200
Message-ID: <481115f4e0c15e22f0fa61f1f013fd2851e2737a.1383639261.git.jsarha@ti.com>
References: <cover.1383639261.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39900 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3KEImp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Nov 2013 03:42:45 -0500
In-Reply-To: <cover.1383639261.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: Jyri Sarha <jsarha@ti.com>

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

