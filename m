From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v4 16/18] I2C: OMAP1: set i2c unit feature implementation flags in platform data
Date: Wed,  1 Jun 2011 17:19:42 -0700
Message-ID: <1306973984-15165-17-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44121 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759309Ab1FBAUR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:20:17 -0400
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

Most of the OMAP1 implementation flags are set statically, with the
exception that omap7xx has its data bus wired up differently.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/i2c.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 9098669..2388b8e 100644
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
 
-- 
1.7.4

