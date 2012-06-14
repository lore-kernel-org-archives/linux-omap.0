From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 06/29] hwrng: omap: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 14 Jun 2012 18:16:55 +0530
Message-ID: <1339678038-23082-7-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab2FNMrq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:47:46 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Deepak Saxena <dsaxena@plexity.net>, Matt Mackall <mpm@selenic.com>

As we move to Common clk framework use clk_prepare_enable()
instead of clk_enable() and similarly clk_disable_unprepare()
instead of clk_disable()

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

