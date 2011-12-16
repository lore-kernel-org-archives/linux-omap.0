From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] OMAP: DSS2: Support for UMSH-8173MD TFT panel
Date: Fri, 16 Dec 2011 18:30:24 +0100
Message-ID: <1324056624-16283-1-git-send-email-zonque@gmail.com>
References: <1324056181-14360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:33981 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760266Ab1LPRag (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 12:30:36 -0500
In-Reply-To: <1324056181-14360-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---

v2 is a resent with ".power_on_delay" and ".acb" values corrected.


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

