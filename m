From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 05/14] ARM: OMAP3+: SmartReflex: use __devexit_p annotation
Date: Wed,  8 Feb 2012 18:43:50 +0100
Message-ID: <1328723039-15952-6-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34688 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab2BHRo3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:29 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so574409wer.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:28 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

Use __devexit_p() in struct platform_driver for functions that are
defined with __devexit.

Reported-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9c39484..24ba80b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1079,7 +1079,7 @@ static void __devexit omap_sr_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.shutdown	= __devexit_p(omap_sr_shutdown),
 	.driver		= {
 		.name	= "smartreflex",
-- 
1.7.5.4

