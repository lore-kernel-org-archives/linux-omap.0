From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v6 4/8] OMAP4: hwmod data: enable HSMMC
Date: Mon, 28 Feb 2011 20:48:01 +0530
Message-ID: <1298906285-29895-5-git-send-email-kishore.kadiyala@ti.com>
References: <1298906285-29895-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739Ab1B1PKt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 10:10:49 -0500
In-Reply-To: <1298906285-29895-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: Anand Gadiyar <gadiyar@ti.com>

Enabling hsmmc hwmod for OMAP4

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Acked-by: Benoit Cousson<b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..dd39e75 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5077,11 +5077,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_mcspi4_hwmod,
 
 	/* mmc class */
-/*	&omap44xx_mmc1_hwmod, */
-/*	&omap44xx_mmc2_hwmod, */
-/*	&omap44xx_mmc3_hwmod, */
-/*	&omap44xx_mmc4_hwmod, */
-/*	&omap44xx_mmc5_hwmod, */
+	&omap44xx_mmc1_hwmod,
+	&omap44xx_mmc2_hwmod,
+	&omap44xx_mmc3_hwmod,
+	&omap44xx_mmc4_hwmod,
+	&omap44xx_mmc5_hwmod,
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
-- 
1.7.1

