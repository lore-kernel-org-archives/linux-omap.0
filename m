From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/8] i2c-omap: Mark init-only functions as __init
Date: Thu, 25 Sep 2008 10:16:32 +0300
Message-ID: <1222326994-26836-7-git-send-email-tony@atomide.com>
References: <1222326994-26836-1-git-send-email-tony@atomide.com>
 <1222326994-26836-2-git-send-email-tony@atomide.com>
 <1222326994-26836-3-git-send-email-tony@atomide.com>
 <1222326994-26836-4-git-send-email-tony@atomide.com>
 <1222326994-26836-5-git-send-email-tony@atomide.com>
 <1222326994-26836-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55575 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYIYHQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:16:58 -0400
In-Reply-To: <1222326994-26836-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Mark functions called only at init time as __init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fdebf96..52ecddd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -154,7 +154,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
-static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
+static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
@@ -694,7 +694,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 	.functionality	= omap_i2c_func,
 };
 
-static int
+static int __init
 omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
-- 
1.5.6.rc3.21.g8c6b5

