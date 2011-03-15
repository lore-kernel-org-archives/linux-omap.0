From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 08/18] I2C: OMAP2+: use platform_data ip revision to select
 register map
Date: Tue, 15 Mar 2011 19:56:49 +0000
Message-ID: <20110315195648.30000.78684.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62524 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab1COT4w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:56:52 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so915512wya.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:56:51 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

Change the register map names to reflect the IP revision they
are representing, and use the platform_data IP revision index
to select between them at init time.

Eliminates 1 of 17 cpu_...() calls in the driver.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2826c13..eee0bb8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -205,7 +205,7 @@ struct omap_i2c_dev {
 	u16			errata;
 };
 
-const static u8 reg_map[] = {
+const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
 	[OMAP_I2C_IE_REG] = 0x01,
 	[OMAP_I2C_STAT_REG] = 0x02,
@@ -226,7 +226,7 @@ const static u8 reg_map[] = {
 	[OMAP_I2C_BUFSTAT_REG] = 0x10,
 };
 
-const static u8 omap4_reg_map[] = {
+const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_REV_REG] = 0x04,
 	[OMAP_I2C_IE_REG] = 0x2c,
 	[OMAP_I2C_STAT_REG] = 0x28,
@@ -1037,10 +1037,10 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->reg_shift = 2;
 
-	if (cpu_is_omap44xx())
-		dev->regs = (u8 *) omap4_reg_map;
+	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
+		dev->regs = (u8 *)reg_map_ip_v2;
 	else
-		dev->regs = (u8 *) reg_map;
+		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(&pdev->dev);
 	omap_i2c_unidle(dev);

