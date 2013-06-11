From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
Date: Tue, 11 Jun 2013 10:31:59 +0200
Message-ID: <1370939520-16132-3-git-send-email-peter.ujfalusi@ti.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57437 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FKIcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 04:32:31 -0400
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

It means that the SoC does not have DMIC IP
.
Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b82538d..8f268b4 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -393,10 +393,8 @@ static void __init omap_init_dmic(void)
 	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("dmic");
-	if (!oh) {
-		pr_err("Could not look up dmic hw_mod\n");
+	if (!oh)
 		return;
-	}
 
 	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap-dmic.\n");
-- 
1.8.2.1

