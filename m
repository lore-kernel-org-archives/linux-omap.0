From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 11/12] i2c: algo: bit: add flag to whitelist atomic transfers
Date: Wed,  3 Apr 2019 14:40:18 +0200
Message-ID: <20190403124019.8947-12-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

Use the new xfer_atomic callback to check a newly introduced flag to
whitelist atomic transfers. This will report configurations which
worked accidently.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/algos/i2c-algo-bit.c | 22 ++++++++++++++++++++--
 include/linux/i2c-algo-bit.h     |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 5e5990a83da5..913db013fe90 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -603,6 +603,23 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 	return ret;
 }
 
+/*
+ * We print a warning when we are not flagged to support atomic transfers but
+ * will try anyhow. That's what the I2C core would do as well. Sadly, we can't
+ * modify the algorithm struct at probe time because this struct is exported
+ * 'const'.
+ */
+static int bit_xfer_atomic(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+			   int num)
+{
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+
+	if (!adap->can_do_atomic)
+		dev_warn(&i2c_adap->dev, "not flagged for atomic transfers\n");
+
+	return bit_xfer(i2c_adap, msgs, num);
+}
+
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
@@ -615,8 +632,9 @@ static u32 bit_func(struct i2c_adapter *adap)
 /* -----exported algorithm data: -------------------------------------	*/
 
 const struct i2c_algorithm i2c_bit_algo = {
-	.master_xfer	= bit_xfer,
-	.functionality	= bit_func,
+	.master_xfer = bit_xfer,
+	.master_xfer_atomic = bit_xfer_atomic,
+	.functionality = bit_func,
 };
 EXPORT_SYMBOL(i2c_bit_algo);
 
diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index 69045df78e2d..7fd5575a368f 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -33,6 +33,7 @@ struct i2c_algo_bit_data {
 				   minimum 5 us for standard-mode I2C and SMBus,
 				   maximum 50 us for SMBus */
 	int timeout;		/* in jiffies */
+	bool can_do_atomic;	/* callbacks don't sleep, we can be atomic */
 };
 
 int i2c_bit_add_bus(struct i2c_adapter *);
-- 
2.11.0
