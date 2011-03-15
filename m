From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 13/18] I2C: OMAP2+: Pass flags up to omap i2c platform_data
 as well
Date: Tue, 15 Mar 2011 19:57:27 +0000
Message-ID: <20110315195726.30000.51420.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62524 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424Ab1COT53 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:29 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so915512wya.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:29 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

This is how the driver can find the flags for its implementation
functionality in its platform_data

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 34a3319..abe070c 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -141,6 +141,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	struct omap_device *od;
 	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
 	struct omap_i2c_bus_platform_data *pdata;
+	struct omap_i2c_dev_attr *dev_attr;
 
 	omap2_i2c_mux_pins(bus_id);
 
@@ -156,10 +157,14 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	pdata = &i2c_pdata[bus_id - 1];
 	/*
 	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
-	 * use up to the OMAP I2C driver via platform data
+	 * use, and functionality implementation flags, up to the OMAP I2C
+	 * driver via platform data
 	 */
 	pdata->rev = oh->class->rev;
 
+	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
+	pdata->flags = dev_attr->flags;
+
 	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to

