From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 07/18] I2C: OMAP2+: Pass hwmod rev knowledge via
 platform_data when i2c bus added
Date: Tue, 08 Mar 2011 11:08:12 +0000
Message-ID: <20110308110812.23531.96169.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52226 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab1CHLIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:08:15 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so951436wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:08:14 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

Mark each OMAP I2C bus with the hwmod's knowledge of which I2C
IP version is in the chip we're running on.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a938df0..0d3eda7 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -155,6 +155,12 @@ static inline int omap2_i2c_add_bus(int bus_id)
 
 	pdata = &i2c_pdata[bus_id - 1];
 	/*
+	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
+	 * use up to the OMAP I2C driver via platform data
+	 */
+	pdata->rev = oh->class->rev;
+
+	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to
 	 * ensure quick enough wakeup from idle, when transfer

