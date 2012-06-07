From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 03/31] dmaengine: PL08x: remove redundant spinlock
Date: Thu, 07 Jun 2012 11:46:42 +0100
Message-ID: <E1ScaEk-0003jx-DF@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54163 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759769Ab2FGKqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:46:47 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

The pl08x_driver_data spinlock is only ever initialized.  Nothing else
uses it.  Let's get rid of it.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f3ab004..9c5bae6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -146,7 +146,6 @@ struct pl08x_driver_data {
 	int pool_ctr;
 	u8 lli_buses;
 	u8 mem_buses;
-	spinlock_t lock;
 };
 
 /*
@@ -1897,8 +1896,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_lli_pool;
 	}
 
-	spin_lock_init(&pl08x->lock);
-
 	pl08x->base = ioremap(adev->res.start, resource_size(&adev->res));
 	if (!pl08x->base) {
 		ret = -ENOMEM;
-- 
1.7.4.4

