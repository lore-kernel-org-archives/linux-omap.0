From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 05/18] I2C: OMAP: add rev to omap i2c platform data
Date: Tue, 15 Mar 2011 19:56:26 +0000
Message-ID: <20110315195626.30000.99578.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1COT43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:56:29 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1206062wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:56:28 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

We need to pass the I2C IP revision from the hwmod class up
into the OMAP I2C driver, which does not have direct
access to it.

This adds a member to the platform data the OMAP I2C driver
does use already to hold the I2C IP revision.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 701886d..b321211 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -17,6 +17,7 @@
 
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
+	u32		rev;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);

