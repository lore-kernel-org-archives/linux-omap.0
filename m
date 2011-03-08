From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 18/18] I2C: OMAP1/OMAP2+: prepend I2C IP version to probed
 version shown in dev_info
Date: Tue, 08 Mar 2011 11:09:34 +0000
Message-ID: <20110308110934.23531.70384.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34500 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab1CHLJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:09:38 -0500
Received: by eyx24 with SMTP id 24so1912707eyx.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:09:37 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

The IP version is prepended to the existing printed probed
version as an "epoch" version.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c997c55..d53cd61 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1093,8 +1093,8 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
-		 pdev->id, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
+		 pdata->rev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
 
 	omap_i2c_idle(dev);
 

