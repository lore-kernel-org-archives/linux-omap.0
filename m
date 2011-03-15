From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 16/18] I2C: OMAP1: set i2c unit feature implementation flags
 in platform data
Date: Tue, 15 Mar 2011 19:57:49 +0000
Message-ID: <20110315195749.30000.36662.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64279 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab1COT5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:52 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1208159wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:52 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

Most of the OMAP1 implementation flags are set statically, with the
exception that omap7xx has its data bus wired up differently.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index abe070c..710c5d5 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -111,6 +111,19 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	/* all OMAP1 have IP version 1 register set */
 	pdata->rev = OMAP_I2C_IP_VERSION_1;
 
+	/* all OMAP1 I2C are implemented like this */
+	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
+		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
+		       OMAP_I2C_FLAG_16BIT_DATA_REG |
+		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
+
+	/* how the cpu bus is wired up differs for 7xx only */
+
+	if (cpu_is_omap7xx())
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_1;
+	else
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
+
 	return platform_device_register(pdev);
 }
 

