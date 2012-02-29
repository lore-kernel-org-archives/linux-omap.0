From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
Date: Wed, 29 Feb 2012 10:48:21 +0200
Message-ID: <1330505302-8258-2-git-send-email-tomi.valkeinen@ti.com>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59434 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932216Ab2B2Isl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 03:48:41 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so8938561lah.37
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 00:48:39 -0800 (PST)
In-Reply-To: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

panel-dvi uses i2c, but the Kconfig didn't have dependency on I2C. Add
it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 74d29b5..408a992 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -12,7 +12,7 @@ config PANEL_GENERIC_DPI
 
 config PANEL_DVI
 	tristate "DVI output"
-	depends on OMAP2_DSS_DPI
+	depends on OMAP2_DSS_DPI && I2C
 	help
 	  Driver for external monitors, connected via DVI. The driver uses i2c
 	  to read EDID information from the monitor.
-- 
1.7.4.1

