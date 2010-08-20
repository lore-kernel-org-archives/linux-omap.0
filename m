From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 10/10] [PM-WIP-MMC] omap4 hsmmc: Fix the init if
     CONFIG_MMC_OMAP_HS is not set
Date: Sat, 21 Aug 2010 01:41:23 +0530 (IST)
Message-ID: <16186.10.24.255.18.1282335083.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34575 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0HTUML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 16:12:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, madhu.cr@ti.com

From: Benoit Cousson <b-cousson@ti.com
Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..3a0dafd 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -235,8 +235,13 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)

 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;
+
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev)
+		return;

+	pdata = dev->platform_data;
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }

-- 
1.7.0.4

