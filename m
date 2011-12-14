From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 1/1] omap3: add definition for CONTROL_CAMERA_PHY_CTRL
Date: Wed, 14 Dec 2011 17:14:16 +0200
Message-ID: <1323875656-17147-1-git-send-email-sakari.ailus@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:17670 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193Ab1LNPOU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 10:14:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

The register is used to configure the behaviour of the CSI-2 and CCP-2
receivers. This register is available only in OMAP3630.

The original patch was submitted by Vimarsh Zutshi.

Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
---
 arch/arm/mach-omap2/control.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index d4ef75d..6a26a0d 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -183,6 +183,7 @@
 #define OMAP3630_CONTROL_FUSE_OPP120_VDD1       (OMAP2_CONTROL_GENERAL + 0x0120)
 #define OMAP3630_CONTROL_FUSE_OPP50_VDD2        (OMAP2_CONTROL_GENERAL + 0x0128)
 #define OMAP3630_CONTROL_FUSE_OPP100_VDD2       (OMAP2_CONTROL_GENERAL + 0x012C)
+#define OMAP3630_CONTROL_CAMERA_PHY_CTRL	(OMAP2_CONTROL_GENERAL + 0x02f0)
 
 /* OMAP44xx control efuse offsets */
 #define OMAP44XX_CONTROL_FUSE_IVA_OPP50		0x22C
-- 
1.7.2.5

