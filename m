From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Get OMAP4 DPLL fclk for DPI interface
Date: Thu,  3 Feb 2011 19:26:59 +0530
Message-ID: <1296741419-9037-5-git-send-email-raghuveer.murthy@ti.com>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421Ab1BCOC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:02:28 -0500
In-Reply-To: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

DSS DPLL fclk pointer is set, to configure pixel clock for DPI interface.

Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dss.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 654f5e6..d76bc26 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -628,6 +628,13 @@ static int dss_init(bool skip_init)
 			r = PTR_ERR(dss.dpll_per_mx_ck);
 			goto fail2;
 		}
+	} else if (cpu_is_omap44xx()) {
+		dss.dpll_per_mx_ck = clk_get(NULL, "dpll_per_m5x2_ck");
+		if (IS_ERR(dss.dpll_per_mx_ck)) {
+			DSSERR("Failed to get dpll_per_mx_ck\n");
+			r = PTR_ERR(dss.dpll_per_mx_ck);
+			goto fail2;
+		}
 	}
 
 	dss.dsi_clk_source = DSS_SRC_DSS1_ALWON_FCLK;
-- 
1.7.0.4

