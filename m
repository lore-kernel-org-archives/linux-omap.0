From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH 7/7] OMAP4: DSS: Adding picodlp panel entry in Kconfig and Makefile
Date: Mon, 18 Apr 2011 11:45:50 +0530
Message-ID: <1303107350-22747-8-git-send-email-mayur@ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42359 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1DRF7Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 01:59:25 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3I5xP80023264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 00:59:25 -0500
In-Reply-To: <1303107350-22747-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>, Mayuresh Janorkar <mayur@ti.com>

From: Mythri P K <mythripk@ti.com>

A new panel picodlp for OMAP4 has been introduced
picodlp is a projector available on OMAP4430SDP and EVM platforms.

Signed-off-by: Mythri P K <mythripk@ti.com>
Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/displays/Kconfig  |    7 +++++++
 drivers/video/omap2/displays/Makefile |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index d18ad6b..374c06c 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -29,6 +29,13 @@ config PANEL_NEC_NL8048HL11_01B
 		This NEC NL8048HL11-01B panel is TFT LCD
 		used in the Zoom2/3/3630 sdp boards.
 
+config PANEL_PICODLP
+	tristate "OMAP PICO DLP Panel"
+	depends on OMAP2_DSS
+	help
+		Projector Panel used in TI's SDP4430 and EVM boards
+		For more info please visit http://www.dlp.com/projector/
+
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 0f601ab..d90f73c 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
+obj-$(CONFIG_PANEL_PICODLP) +=  panel-picodlp.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
-- 
1.7.1

