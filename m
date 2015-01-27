From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/14] OMAPDSS: add define for DRA7xx HW version
Date: Tue, 27 Jan 2015 12:50:34 +0200
Message-ID: <1422355842-11234-7-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51613 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbbA0KvE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 05:51:04 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add define for DRA7xx DSS version.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6a84498ea513..60de61fea8e3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -314,6 +314,7 @@ enum omapdss_version {
 	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
 	OMAPDSS_VER_OMAP5,
 	OMAPDSS_VER_AM43xx,
+	OMAPDSS_VER_DRA7xx,
 };
 
 /* Board specific data */
-- 
2.2.2

