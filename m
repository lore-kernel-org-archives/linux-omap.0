From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: dss2: Add SPI dependency to Kconfig of ACX565AKM panel
Date: Wed, 11 Aug 2010 15:23:02 +0300
Message-ID: <1281529382-11523-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52655 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab0HKMXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 08:23:17 -0400
Received: by ewy23 with SMTP id 23so2177ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 05:23:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Roger Quadros <roger.quadros@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

This panel driver is using SPI for its communication so add CONFIG_SPI
dependency.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Roger Quadros <roger.quadros@nokia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
I'm not sure would the select SPI be better but I'm following the same style
than TPO_TD043MTEA1.
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 881c9f7..12327bb 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -40,7 +40,7 @@ config PANEL_TPO_TD043MTEA1
 
 config PANEL_ACX565AKM
 	tristate "ACX565AKM Panel"
-	depends on OMAP2_DSS_SDI
+	depends on OMAP2_DSS_SDI && SPI
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900
-- 
1.7.1

