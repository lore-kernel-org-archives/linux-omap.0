From: <mythripk@ti.com>
Subject: [PATCH 3/5] OMAPDSS: HDMI: Add missing register definitions
Date: Tue, 20 Sep 2011 18:19:12 +0530
Message-ID: <1316522954-16594-4-git-send-email-mythripk@ti.com>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
 <1316522954-16594-2-git-send-email-mythripk@ti.com>
 <1316522954-16594-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1ITM5U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 08:57:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8KCvHV8029548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 07:57:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8KCvGp2005709
	for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 18:27:16 +0530 (IST)
In-Reply-To: <1316522954-16594-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add some of the missing register definitions, which are h/w indexable.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 694888a..2040956 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -100,15 +100,15 @@
 #define HDMI_CORE_AV_AVI_CHSUM			0x10C
 #define HDMI_CORE_AV_AVI_DBYTE(n)		(n * 4 + 0x110)
 #define HDMI_CORE_AV_AVI_DBYTE_NELEMS		15
-#define HDMI_CORE_AV_SPD_DBYTE			0x190
+#define HDMI_CORE_AV_SPD_DBYTE(n)		(n * 4 + 0x190)
 #define HDMI_CORE_AV_SPD_DBYTE_NELEMS		27
 #define HDMI_CORE_AV_AUD_DBYTE(n)		(n * 4 + 0x210)
 #define HDMI_CORE_AV_AUD_DBYTE_NELEMS		10
-#define HDMI_CORE_AV_MPEG_DBYTE			0x290
+#define HDMI_CORE_AV_MPEG_DBYTE(n)		(n * 4 + 0x290)
 #define HDMI_CORE_AV_MPEG_DBYTE_NELEMS		27
-#define HDMI_CORE_AV_GEN_DBYTE			0x300
+#define HDMI_CORE_AV_GEN_DBYTE(n)		(n * 4 + 0x300)
 #define HDMI_CORE_AV_GEN_DBYTE_NELEMS		31
-#define HDMI_CORE_AV_GEN2_DBYTE			0x380
+#define HDMI_CORE_AV_GEN2_DBYTE(n)		(n * 4 + 0x380)
 #define HDMI_CORE_AV_GEN2_DBYTE_NELEMS		31
 #define HDMI_CORE_AV_ACR_CTRL			0x4
 #define HDMI_CORE_AV_FREQ_SVAL			0x8
-- 
1.7.5.4

