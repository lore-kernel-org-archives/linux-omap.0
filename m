From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before judging
 omap_dma_reserve_channels
Date: Thu, 10 Jan 2013 18:29:41 +0800
Message-ID: <50EE9815.2080402@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:15810 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3AJK2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 05:28:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


  dma_lch_count is zero before 1st call of omap_system_dma_probe.
  omap_dma_reserve_channels has value before 1st call of omap_system_dma_probe

  when 1st call of omap_system_dma_probe
    we need set dma_lch_count before use it for judging
    or which will be failed for omap_dma_reserve_channels

  additional info:
    this patch is only for fixing bug, not touch the features.
    so, not use d->lch_count instead of dma_lch_count for the statement:

                        && (omap_dma_reserve_channels <= dma_lch_count))

    at least, now, current fixing is equal to above.
    in the future
      maybe omap_dma_reserve_channels can be set by outside (such as from /proc)
      dma_lch_count is a static global variable which has effect to all devices.
      maybe the original author do not hope the newer is larger than the older

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/plat-omap/dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4136b20..b382eef 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2018,6 +2018,9 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	d			= p->dma_attr;
 	errata			= p->errata;
 
+	if (!dma_lch_count)
+		dma_lch_count	= d->lch_count;
+
 	if ((d->dev_caps & RESERVE_CHANNEL) && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
 		d->lch_count	= omap_dma_reserve_channels;
-- 
1.7.10.4
