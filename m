From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v4 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality flags for each cpu_... test
Date: Wed,  1 Jun 2011 17:19:40 -0700
Message-ID: <1306973984-15165-15-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:48180 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759248Ab1FBAUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:20:12 -0400
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

These represent the 8 kinds of implementation functionality
that up until now were inferred by the 16 remaining cpu_...()
tests in the omap i2c driver.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 include/linux/i2c-omap.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 776c8e1..98ae49b 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -15,6 +15,21 @@
 #define OMAP_I2C_IP_VERSION_1 1
 #define OMAP_I2C_IP_VERSION_2 2
 
+/* struct omap_i2c_bus_platform_data .flags meanings */
+
+#define OMAP_I2C_FLAG_NO_FIFO 1
+#define OMAP_I2C_FLAG_SIMPLE_CLOCK 2
+#define OMAP_I2C_FLAG_16BIT_DATA_REG 4
+#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE 8
+#define OMAP_I2C_FLAG_APPLY_ERRATA_I207 0x10
+#define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK 0x20
+#define OMAP_I2C_FLAG_FORCE_19200_INT_CLK 0x40
+/* how the CPU address bus must be translated for I2C unit access */
+#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
+#define OMAP_I2C_FLAG_BUS_SHIFT_1 0x80
+#define OMAP_I2C_FLAG_BUS_SHIFT_2 0x100
+#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
-- 
1.7.4

