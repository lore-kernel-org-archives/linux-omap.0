From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 03/11] hwrng: omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:02 +0530
Message-ID: <1340372890-10091-4-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34290 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762182Ab2FVNsb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:48:31 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Deepak Saxena <dsaxena@plexity.net>, Matt Mackall <mpm@selenic.com>

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the rng interface clock as part of the drivers
probe() and remove() routines.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Deepak Saxena <dsaxena@plexity.net>
Cc: Matt Mackall <mpm@selenic.com>
---
 drivers/char/hw_random/omap-rng.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 1412565..500604a 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -110,7 +110,7 @@ static int __devinit omap_rng_probe(struct platform_device *pdev)
 			ret = PTR_ERR(rng_ick);
 			return ret;
 		} else
-			clk_enable(rng_ick);
+			clk_prepare_enable(rng_ick);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -138,7 +138,7 @@ err_register:
 	rng_base = NULL;
 err_ioremap:
 	if (cpu_is_omap24xx()) {
-		clk_disable(rng_ick);
+		clk_disable_unprepare(rng_ick);
 		clk_put(rng_ick);
 	}
 	return ret;
@@ -151,7 +151,7 @@ static int __exit omap_rng_remove(struct platform_device *pdev)
 	omap_rng_write_reg(RNG_MASK_REG, 0x0);
 
 	if (cpu_is_omap24xx()) {
-		clk_disable(rng_ick);
+		clk_disable_unprepare(rng_ick);
 		clk_put(rng_ick);
 	}
 
-- 
1.7.1

