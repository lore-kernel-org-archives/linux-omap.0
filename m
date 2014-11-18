From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/10] arm: omap: omap2plus_defconfig: enable AM33XX SoC sound
Date: Tue, 18 Nov 2014 12:07:01 -0600
Message-ID: <1416334028-7766-3-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbaKRSHR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 13:07:17 -0500
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Without this, sound on AM437x Starter Kit will
not work.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c893487..a5abc67 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -281,6 +281,8 @@ CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
+CONFIG_SND_EDMA_SOC=m
+CONFIG_SND_AM33XX_SOC_EVM=m
 CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
-- 
2.1.0.GIT

