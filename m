From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v4 11/18] I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8 to u32
Date: Wed,  1 Jun 2011 17:19:37 -0700
Message-ID: <1306973984-15165-12-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47243 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759230Ab1FBAUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:20:06 -0400
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

As part of removing cpu_...() from the OMAP I2C driver, we need to
convert the CPU tests into functionality flags that are set by
hwmod class in the same way the IP revision is.

More flags are needed than will fit in the existing u8 flags
member of omap_i2c_dev_attr.

These flags can refer to options inside the IP block but they are
most needed for information about cpu implementation specific
options that are not part of the IP block itself.  For example,
how the CPU data bus is wired to the IP block databus differs
between OMAP cpus and affects how you must shift the address in
the IP block, but is not a feature of the IP block itself.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index a1d3d06..fd75dad 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -47,7 +47,7 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
  */
 struct omap_i2c_dev_attr {
 	u8	fifo_depth;
-	u8	flags;
+	u32	flags;
 };
 
 void __init omap1_i2c_mux_pins(int bus_id);
-- 
1.7.4

