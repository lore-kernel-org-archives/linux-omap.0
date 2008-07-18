From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] i2c-omap: mark init-only functions as __init
Date: Thu, 17 Jul 2008 19:44:13 -0600
Message-ID: <20080718014410.22295.70085.stgit@localhost.localdomain>
References: <20080718013912.22295.5368.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50369 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716AbYGRBor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:44:47 -0400
In-Reply-To: <20080718013912.22295.5368.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mark functions called only at init time as __init.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 55779f5..ed60693 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -160,7 +160,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
-static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
+static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
@@ -701,7 +701,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
-static int
+static int __init
 omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;


