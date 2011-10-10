From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 2/7] arm: omap: smartreflex: add missing platform_set_drvdata()
Date: Mon, 10 Oct 2011 15:26:14 +0300
Message-ID: <1318249579-4089-2-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:32900 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753740Ab1JJM02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 08:26:28 -0400
Received: by mail-bw0-f48.google.com with SMTP id zu5so11014339bkb.35
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 05:26:27 -0700 (PDT)
In-Reply-To: <1318249579-4089-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

that's very useful to fetch the correct struct sr_info
from PM handlers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index af158c0..55e297e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -855,6 +855,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, sr_info);
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
 		ret = -EINVAL;
-- 
1.7.6.396.ge0613

