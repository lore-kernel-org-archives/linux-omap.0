From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 12/18] I2C: OMAP1/OMAP2+: add flags field to omap i2c
 platform data
Date: Tue, 08 Mar 2011 11:08:49 +0000
Message-ID: <20110308110849.23531.87678.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56816 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab1CHLIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:08:53 -0500
Received: by wwi17 with SMTP id 17so809401wwi.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:08:52 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

OMAP I2C driver can access the configuration flags through
its platform data.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index b321211..776c8e1 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -18,6 +18,7 @@
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
+	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);

