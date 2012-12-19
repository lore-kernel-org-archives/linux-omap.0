From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip support
Date: Wed, 19 Dec 2012 13:33:39 +0100
Message-ID: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41576 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2LSMdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 07:33:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Many OMAP3 based boards such as Beagle, Overo and IGEP use
the TFP410 DPI-to-DVI chip. So, it's good to have it built
as a module by default on OMAP2+ config.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a1dc5c0..da530a0 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -146,6 +146,7 @@ CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
 CONFIG_FB_OMAP2=m
 CONFIG_PANEL_GENERIC_DPI=m
+CONFIG_PANEL_TFP410=m
 CONFIG_PANEL_SHARP_LS037V7DW01=m
 CONFIG_PANEL_NEC_NL8048HL11_01B=m
 CONFIG_PANEL_TAAL=m
-- 
1.7.7.6

