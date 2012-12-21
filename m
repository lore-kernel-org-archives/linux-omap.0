From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 04/15] ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
Date: Fri, 21 Dec 2012 09:28:04 -0700
Message-ID: <1356107295-11121-5-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38815 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2LUQ2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:33 -0500
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the error message that prints when there is no SHA IP
present to make it consistent with all the other IPs.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index a217408..598ab1e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -466,20 +466,15 @@ static void omap_init_rng(void)
 
 static void __init omap_init_sham(void)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		struct omap_hwmod *oh;
-		struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
 
-		oh = omap_hwmod_lookup("sham");
-		if (!oh)
-			return;
+	oh = omap_hwmod_lookup("sham");
+	if (!oh)
+		return;
 
-		pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL,
-					 0, 0);
-		WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
-	}
+	pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
 }
 
 #if defined(CONFIG_CRYPTO_DEV_OMAP_AES) || defined(CONFIG_CRYPTO_DEV_OMAP_AES_MODULE)
-- 
1.7.12

