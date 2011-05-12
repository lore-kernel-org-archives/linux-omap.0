From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 5/8] OMAP: DSS2: RFBI: add omap_rfbi_configure
Date: Thu, 12 May 2011 14:40:10 +0300
Message-ID: <1305200413-23697-6-git-send-email-tomi.valkeinen@ti.com>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35502 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755540Ab1ELLke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:40:34 -0400
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add omap_rfbi_configure() which the panel driver can use to reconfigure
the data element size and the number of data lines in the RFBI bus.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |    8 +++++++-
 include/video/omapdss.h        |    2 ++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1c19d17..155caf0 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -851,7 +851,13 @@ int rfbi_configure(int rfbi_module, int bpp, int lines)
 
 	return 0;
 }
-EXPORT_SYMBOL(rfbi_configure);
+
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
+		int data_lines)
+{
+	return rfbi_configure(dssdev->phy.rfbi.channel, pixel_size, data_lines);
+}
+EXPORT_SYMBOL(omap_rfbi_configure);
 
 int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		u16 *x, u16 *y, u16 *w, u16 *h)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1ea151e..9b00748 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -612,5 +612,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
+		int data_lines);
 
 #endif
-- 
1.7.4.1

