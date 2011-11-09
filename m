From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] OMAP2+: Fix Compilation error when omap_l3_noc built as module
Date: Wed, 9 Nov 2011 17:16:39 +0530
Message-ID: <1320839199-4006-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35715 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab1KILrH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Nov 2011 06:47:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Fix below compilation failure on mainline kernel 3.2-rc1
when omap_l3_noc.c is built as module.

arch/arm/mach-omap2/omap_l3_noc.c:240: error: expected ',' or ';' before 'MODULE_DEVICE_TABLE'

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 6a66aa5..d15225f 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -237,7 +237,7 @@ static int __devexit omap4_l3_remove(struct platform_device *pdev)
 static const struct of_device_id l3_noc_match[] = {
 	{.compatible = "ti,omap4-l3-noc", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, l3_noc_match);
 #else
 #define l3_noc_match NULL
-- 
1.7.4.1

