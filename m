From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: Adding macro for DISPC_DIVISOR register
Date: Thu,  3 Feb 2011 19:39:20 +0530
Message-ID: <1296742161-9395-4-git-send-email-raghuveer.murthy@ti.com>
References: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34563 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab1BCOOr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:14:47 -0500
In-Reply-To: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

Added macro for DISPC_DIVISOR. This is different from DISPC_DIVISOR1 and
DISPC_DIVISOR2. OMAP4 supports all the above 3 registers.

DISPC_DIVISOR1 and DISPC_DIVISOR2 registers are accessed through
DISPC_DIVISORo(ch) macro

Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e52a413..6225d12 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -132,6 +132,17 @@ struct dispc_reg { u16 idx; };
 
 #define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
 
+/*
+ * The OMAP4 DISPC_DIVISOR1 is backward compatible to OMAP3xxx DISPC_DIVISOR.
+ * However DISPC_DIVISOR is also provided in OMAP4, to control DISPC_CORE_CLK.
+ * This allows DISPC_CORE_CLK to be independent of logical clock dividers (lcd)
+ * of LCD1 (primary) and LCD2 (secondary) displays.
+ *
+ * To derive pixel clocks for Primary and Secondary LCD channels, configure the
+ * lcd and pcd in DISPC_DIVISOR1 and DISPC_DIVISOR2 respectively, using the
+ * DISPC_DIVISORo(ch).
+ */
+#define DISPC_DIVISOR			DISPC_REG(0x0804)
 
 #define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_OCP_ERR | \
-- 
1.7.0.4

