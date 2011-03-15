From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
 flags for each cpu_... test
Date: Tue, 15 Mar 2011 19:57:34 +0000
Message-ID: <20110315195734.30000.12009.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62524 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab1COT5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:37 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so915512wya.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:36 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

These represent the 8 kinds of implementation functionality
that up until now were inferred by the 16 remaining cpu_...()
tests in the omap i2c driver.

Changed to use BIT() as suggested by Balaji T Krishnamoorthy.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 include/linux/i2c-omap.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 776c8e1..56a9924 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -15,6 +15,21 @@
 #define OMAP_I2C_IP_VERSION_1 1
 #define OMAP_I2C_IP_VERSION_2 2
 
+/* struct omap_i2c_bus_platform_data .flags meanings */
+
+#define OMAP_I2C_FLAG_NO_FIFO			BIT(0)
+#define OMAP_I2C_FLAG_SIMPLE_CLOCK		BIT(1)
+#define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
+#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE	BIT(3)
+#define OMAP_I2C_FLAG_APPLY_ERRATA_I207	BIT(4)
+#define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
+#define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
+/* how the CPU address bus must be translated for I2C unit access */
+#define OMAP_I2C_FLAG_BUS_SHIFT_NONE 0
+#define OMAP_I2C_FLAG_BUS_SHIFT_1		BIT(7)
+#define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
+#define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;

