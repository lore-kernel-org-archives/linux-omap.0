From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAPDSS: Displays: Make PICODLP driver depend on DPI
Date: Mon, 12 Dec 2011 11:47:43 +0530
Message-ID: <1323670663-17793-4-git-send-email-archit@ti.com>
References: <1323670663-17793-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40109 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab1LLGSf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 01:18:35 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC6IZOt010712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:35 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pBC6IZJZ015614
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:35 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC6IZ5t011656
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 00:18:35 -0600 (CST)
In-Reply-To: <1323670663-17793-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Make PICODLP driver on OMAP2_DSS_DPI since it is the display interface it uses.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 8d8e1fe..74d29b5 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -41,7 +41,7 @@ config PANEL_NEC_NL8048HL11_01B
 
 config PANEL_PICODLP
 	tristate "TI PICO DLP mini-projector"
-	depends on OMAP2_DSS && I2C
+	depends on OMAP2_DSS_DPI && I2C
 	help
 		A mini-projector used in TI's SDP4430 and EVM boards
 		For more info please visit http://www.dlp.com/projector/
-- 
1.7.4.1

