From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 15/20] ARM: OMAP3+: SmartReflex: add missing platform_set_drvdata()
Date: Wed,  1 Feb 2012 09:49:54 +0100
Message-ID: <1328086199-28486-16-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46589 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab2BAIuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:44 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so1012846wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:44 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

That's very useful to fetch the correct struct sr_info
from the PM handlers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 65e1a7c..eacf4b3 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1062,6 +1062,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, sr_info);
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
 		ret = -EINVAL;
-- 
1.7.5.4

