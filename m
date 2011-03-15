From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 11/18] I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8
 to u32
Date: Tue, 15 Mar 2011 19:57:11 +0000
Message-ID: <20110315195711.30000.91979.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab1COT5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:15 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1206062wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:14 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

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

