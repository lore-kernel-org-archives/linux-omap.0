From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 7/7] i2c: algo: bit: HACK! add atomic callback
Date: Sat,  2 Mar 2019 14:47:35 +0100
Message-ID: <20190302134735.4393-8-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

This is only for testing and will work only for bitbanging which is done
without generating irqs. Not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/algos/i2c-algo-bit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 5e5990a83da5..a9c361947de1 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -615,8 +615,9 @@ static u32 bit_func(struct i2c_adapter *adap)
 /* -----exported algorithm data: -------------------------------------	*/
 
 const struct i2c_algorithm i2c_bit_algo = {
-	.master_xfer	= bit_xfer,
-	.functionality	= bit_func,
+	.master_xfer = bit_xfer,
+	.master_xfer_atomic = bit_xfer,
+	.functionality = bit_func,
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
-- 
2.11.0
