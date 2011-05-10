From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/8] OMAP: DSS2: RFBI: add omap_rfbi_configure
Date: Tue, 10 May 2011 19:24:13 +0300
Message-ID: <1305044656-31512-6-git-send-email-tomi.valkeinen@ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36122 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932983Ab1EJQYi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:38 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add omap_rfbi_configure() which the panel driver can use to reconfigure
the data element size and the number of data lines in the RFBI bus.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/dss/rfbi.c            |    8 +++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e6629eb..7215a8d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -614,5 +614,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 int omap_rfbi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(void *), void *data);
+int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
+		int data_lines);
 
 #endif
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index fadfaae..e6bbb67 100644
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
-- 
1.7.4.1

