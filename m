From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not set
Date: Fri, 01 Oct 2010 16:34:20 -0700
Message-ID: <20101001233420.31894.98797.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50469 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab0JAXeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:34:25 -0400
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Benoit Cousson <b-cousson@ti.com>

Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1bed1e6..cdb9373 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -275,8 +275,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 
 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;
 
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed %s\n", __func__);
+		return;
+	}
+	pdata = dev->platform_data;
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }
 

