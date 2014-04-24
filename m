From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/23] OMAPDSS: HDMI: support larger register offsets for OMAP5 HDMI core
Date: Thu, 24 Apr 2014 13:17:15 +0300
Message-ID: <1398334639-14172-20-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47179 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbaDXKT1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:27 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

The HDMI core IP on OMAP5 has a wider address range for registers. The offsets
for the later registers can't fit into the u16 type currently used for hdmi
register read and write functions. Use u32 for offsets instead.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index d784b2cced9d..0e5979ef933c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -361,13 +361,13 @@ struct hdmi_core_data {
 	struct hdmi_core_infoframe_avi avi_cfg;
 };
 
-static inline void hdmi_write_reg(void __iomem *base_addr, const u16 idx,
+static inline void hdmi_write_reg(void __iomem *base_addr, const u32 idx,
 		u32 val)
 {
 	__raw_writel(val, base_addr + idx);
 }
 
-static inline u32 hdmi_read_reg(void __iomem *base_addr, const u16 idx)
+static inline u32 hdmi_read_reg(void __iomem *base_addr, const u32 idx)
 {
 	return __raw_readl(base_addr + idx);
 }
-- 
1.9.1

