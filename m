From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig
Date: Fri, 30 Apr 2010 13:34:11 -0700
Message-ID: <20100430203411.25812.30019.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65497 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab0D3UeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:13 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
at least on zoom3 for multi-omap. Disable CONFIG_FB until the
omap FB code is fixed.

This allows booting omap3_defconfig on various omaps. Tested on
2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
still has issues with starting user space because of TLS and
VFP.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 7855edb..1efb833 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -1359,16 +1359,8 @@ CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP is not set
 CONFIG_FB_OMAP_LCD_VGA=y
-# CONFIG_FB_OMAP_031M3R is not set
-# CONFIG_FB_OMAP_048M3R is not set
-CONFIG_FB_OMAP_079M3R=y
-# CONFIG_FB_OMAP_092M9R is not set
-# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
-# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_OMAP2_DSS is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y

