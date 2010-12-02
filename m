From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
 driver
Date: Thu, 2 Dec 2010 10:46:17 -0800
Message-ID: <20101202184617.GS17222@atomide.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-10-git-send-email-manjugk@ti.com>
 <20101202184419.GR17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48181 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab0LBSq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 13:46:26 -0500
Content-Disposition: inline
In-Reply-To: <20101202184419.GR17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

* Tony Lindgren <tony@atomide.com> [101202 10:34]:
> 
> This fails on omap1 as d is not allocated. Please merge the
> following fix.

And another fix here:

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Dec 2010 10:19:15 -0800
Subject: [PATCH] Fix omap1_system_dma_init to use ioremap

Fix omap1_system_dma_init to use ioremap

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -280,6 +280,12 @@ static int __init omap1_system_dma_init(void)
 		return -ENOMEM;
 	}
 
+	dma_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!dma_base) {
+		pr_err("%s: Unable to ioremap\n", __func__);
+		return -ENODEV;
+	}
+
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
@@ -337,8 +343,6 @@ static int __init omap1_system_dma_init(void)
 
 	p->dma_attr = d;
 
-	dma_base		= (void __iomem *)res[0].start;
-
 	p->show_dma_caps	= omap1_show_dma_caps;
 	p->clear_lch_regs	= omap1_clear_lch_regs;
 	p->clear_dma		= omap1_clear_dma;
