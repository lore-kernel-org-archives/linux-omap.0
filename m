From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3] OMAP: DSS2: Support for UMSH-8173MD TFT panel
Date: Tue, 20 Dec 2011 10:54:32 +0100
Message-ID: <1324374872-5132-1-git-send-email-zonque@gmail.com>
References: <1324370436.2042.4.camel@deskari>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:47054 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab1LTJyq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 04:54:46 -0500
In-Reply-To: <1324370436.2042.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch adds support for Microtip Technologies' UMSH-8173MD 800x480
RGB TFT panel. Tested with an OMAP3 board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 519c47d..cbcf164 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -297,6 +297,31 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "apollon",
 	},
+
+	/* Microtips Technologies - UMSH-8173MD */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+
+			.pixel_clock	= 34560,
+
+			.hsw		= 13,
+			.hfp		= 101,
+			.hbp		= 101,
+
+			.vsw		= 23,
+			.vfp		= 1,
+			.vbp		= 1,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "UMSH-8173MD",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.7.4

