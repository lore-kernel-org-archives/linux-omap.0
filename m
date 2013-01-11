From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count
Date: Fri, 11 Jan 2013 13:39:18 +0800
Message-ID: <50EFA586.5010508@asianux.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:7154 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3AKFi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 00:38:26 -0500
In-Reply-To: <50EE9C87.6060407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


  'omap_dma_reserve_channels' when used is suppose to be from command.
    so, it alreay has value before 1st call of omap_system_dma_probe.
    and it will never be changed again during running (not from ioctl).

  but 'dma_lch_count' is zero before 1st call of omap_system_dma_probe.
    so it will be failed for omap_dma_reserve_channels, when 1st call.

  so, need use 'd->lch_count' instead of 'dma_lch_count' for judging.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4136b20..e06c34b 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2019,7 +2019,7 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	errata			= p->errata;
 
 	if ((d->dev_caps & RESERVE_CHANNEL) && omap_dma_reserve_channels
-			&& (omap_dma_reserve_channels <= dma_lch_count))
+			&& (omap_dma_reserve_channels < d->lch_count))
 		d->lch_count	= omap_dma_reserve_channels;
 
 	dma_lch_count		= d->lch_count;
-- 
1.7.10.4
