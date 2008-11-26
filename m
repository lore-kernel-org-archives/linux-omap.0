From: "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Subject: [PATCH][OMAPZOOM][2/2] Disable OV3640 sensor support in
 omap_zoom2_defconfig file
Date: Wed, 26 Nov 2008 12:40:55 -0600
Message-ID: <23D0CDE7C386D144A4F26EB0F427F8C019844101@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45718 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492AbYKZSlC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 13:41:02 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAQIevTh013967
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 12:41:02 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAQIevX4028986
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 12:40:57 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

OV3640 smart sensor is not supported on zoom2 platform.

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Ack-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index cf73335..fd8377c 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.27-omap1
-# Fri Nov  7 13:16:24 2008
+# Wed Nov 26 12:18:23 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -957,8 +957,7 @@ CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_OV9640 is not set
 # CONFIG_VIDEO_MT9P012 is not set
 # CONFIG_VIDEO_DW9710 is not set
-CONFIG_VIDEO_OV3640=y
-CONFIG_VIDEO_OV3640_CSI2=y
+# CONFIG_VIDEO_OV3640 is not set
 # CONFIG_VIDEO_SAA711X is not set
 # CONFIG_VIDEO_SAA717X is not set
 # CONFIG_VIDEO_TVP5150 is not set
-- 
1.6.0

