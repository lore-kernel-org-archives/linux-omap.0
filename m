From: Samreen <samreen@ti.com>
Subject: [PATCH v6] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Date: Thu, 24 Feb 2011 11:56:40 +0530
Message-ID: <1298528800-7399-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33316 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab1BXGdT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 01:33:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Mundt <lethal@linux-sh.org>, Samreen <samreen@ti.com>

Enabling all the display interface options to be built as module
And enabling all the display panels to be built as modules.

Signed-off-by: Samreen <samreen@ti.com>
---
 Version6:
        Enabling all the display interface options and all the display
 panels.

 Version5:
        Incorporating the comments from Tony Lindgren, Kevin Hilman,
 Paul Mundt & Tomi Valkeinen to build DSS & panels as modules.
 See: https://patchwork.kernel.org/patch/281492/

 Version4:
       Remove the enabling of the display panels by default.

 Version3:
       Eliminate the separate default number of FBs for
 different architecture. Keeping default FBs as 3 as before.

 Version2:
        Enables by default NEC panel used in zoom2/3/3630sdp, instead of
 Sharp LQ043T1DG01 panel enabled in previous version of this patch.

Testing:
---------
The base used for OMAP3 testing is:
branch: master
commit: bb95b65a
URL: git://gitorious.org/linux-omap-dss2/linux.git

And OMAP4 testing is on the following branch + few patches to enable DSI taal panel:
branch: lo-dss2-Feb18
commit: 67bcb5600
URL: git://dev.omapzoom.org/pub/scm/axelcx/kernel-display.git

The patch is tested on 3630zoom, 3430sdp & 4430sdp, it was not tested
on OMAP2 platform due crash seen while boot.
(See: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43921.html)


 arch/arm/configs/omap2plus_defconfig |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ae890ca..407ccf8 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -192,6 +192,17 @@ CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_OMAP_LCD_VGA=y
+CONFIG_OMAP2_DSS=m
+CONFIG_OMAP2_DSS_RFBI=y
+CONFIG_OMAP2_DSS_SDI=y
+CONFIG_OMAP2_DSS_DSI=y
+CONFIG_FB_OMAP2=m
+CONFIG_PANEL_GENERIC_DPI=m
+CONFIG_PANEL_SHARP_LS037V7DW01=m
+CONFIG_PANEL_NEC_NL8048HL11_01B=m
+CONFIG_PANEL_TAAL=m
+CONFIG_PANEL_TPO_TD043MTEA1=m
+CONFIG_PANEL_ACX565AKM=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
-- 
1.5.6.3

