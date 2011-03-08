From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 11/18] I2C: OMAP2+: increase omap_i2c_dev_attr flags from u8
 to u32
Date: Tue, 08 Mar 2011 11:08:42 +0000
Message-ID: <20110308110842.23531.98228.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52226 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab1CHLIp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:08:45 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so951436wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:08:44 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
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

