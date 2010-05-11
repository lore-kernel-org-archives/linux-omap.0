From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] OMAP3: I2C: Clean up Errata 1p153 handling
Date: Tue, 11 May 2010 11:35:23 -0700
Message-ID: <20100511183523.15596.19585.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49997 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0EKSfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 14:35:21 -0400
In-Reply-To: <20100511182854.15596.56293.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, ben-linux@fluff.org
Cc: Nishanth Menon <nm@ti.com>, Manjunatha GK <manjugk@ti.com>, linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

From: manjugk manjugk <manjugk@ti.com>

Clean up existing Errata 1p153 handling to use generic
errata handling mechanism through dev flag.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fdba131..7674efb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -168,6 +168,7 @@ enum {
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
+#define I2C_OMAP3_1P153			(1 << 1)
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -954,7 +955,7 @@ complete:
 					break;
 				}
 
-				if ((dev->rev <= OMAP_I2C_REV_ON_3430) &&
+				if ((dev->errata & I2C_OMAP3_1P153) &&
 				    errata_omap3_1p153(dev, &stat, &err))
 					goto complete;
 
@@ -1057,6 +1058,9 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
+	if (dev->rev <= OMAP_I2C_REV_ON_3430)
+		dev->errata |= I2C_OMAP3_1P153;
+
 	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
 		u16 s;
 

