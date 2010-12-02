From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
 driver
Date: Thu, 2 Dec 2010 10:49:25 -0800
Message-ID: <20101202184925.GT17222@atomide.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-10-git-send-email-manjugk@ti.com>
 <20101202184419.GR17222@atomide.com>
 <20101202184617.GS17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52981 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab0LBSte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 13:49:34 -0500
Content-Disposition: inline
In-Reply-To: <20101202184617.GS17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

* Tony Lindgren <tony@atomide.com> [101202 10:36]:
> * Tony Lindgren <tony@atomide.com> [101202 10:34]:
> > 
> > This fails on omap1 as d is not allocated. Please merge the
> > following fix.
> 
> And another fix here:

One more fix below.

Note that even with these three fixes, 5912OSK still fails to
boot to init. Maybe something wrong with the framebuffer DMA?

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Dec 2010 10:34:18 -0800
Subject: [PATCH] Fix omap1_system_dma_init to initialize d->lch_count earlier

Otherwise the kzalloc will allocate wrong amount of memory.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -309,13 +309,7 @@ static int __init omap1_system_dma_init(void)
 		goto exit_release_p;
 	}
 
-	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
-					(d->lch_count), GFP_KERNEL);
-	if (!d->chan) {
-		dev_err(&pdev->dev, "%s: Memory allocation failed"
-					"for d->chan!!!\n", __func__);
-		goto exit_release_d;
-	}
+	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
 
 	/* Valid attributes for omap1 plus processors */
 	if (cpu_is_omap15xx())
@@ -330,7 +324,14 @@ static int __init omap1_system_dma_init(void)
 	d->dev_caps		|= CLEAR_CSR_ON_READ;
 	d->dev_caps		|= IS_WORD_16;
 
-	d->lch_count		= OMAP1_LOGICAL_DMA_CH_COUNT;
+
+	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
+					(d->lch_count), GFP_KERNEL);
+	if (!d->chan) {
+		dev_err(&pdev->dev, "%s: Memory allocation failed"
+					"for d->chan!!!\n", __func__);
+		goto exit_release_d;
+	}
 
 	if (cpu_is_omap15xx())
 		d->chan_count = 9;
