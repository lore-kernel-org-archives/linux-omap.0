From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/6] omapdss: hdmi: support larger register offsets for OMAP5 HDMI core
Date: Thu, 17 Oct 2013 16:56:37 +0530
Message-ID: <1382009202-18984-2-git-send-email-archit@ti.com>
References: <1382009202-18984-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab3JQL1h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Oct 2013 07:27:37 -0400
In-Reply-To: <1382009202-18984-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The HDMI core IP on OMAP5 has a wider register address range. The offsets for
these registers can't fit into the u16 type currently used for hdmi register
read and write functions. Use u32 for offsets instead.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.h b/drivers/video/omap2/dss/hdmi.h
index b049376..b410b14 100644
--- a/drivers/video/omap2/dss/hdmi.h
+++ b/drivers/video/omap2/dss/hdmi.h
@@ -360,13 +360,13 @@ struct hdmi_core_data {
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
1.8.1.2

