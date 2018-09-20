From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/4] i2c: core: introduce master_xfer_irqless callback
Date: Thu, 20 Sep 2018 18:14:23 +0200
Message-ID: <20180920161423.13990-5-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We had the request to access devices very late when interrupts are not
available anymore multiple times now. Mostly to prepare shutdown or
reboot. Allow adapters to specify a specific callback for this case.
Note that we fall back to the generic master_xfer callback if this new
irqless one is not present. This is intentional to preserve the previous
behaviour and avoid regressions. Because there are drivers not using
interrupts or because it might have worked "accidently" before.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c |  6 +++++-
 include/linux/i2c.h         | 10 +++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 904b4d2ebefa..f827446c3089 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1887,7 +1887,11 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	/* Retry automatically on arbitration loss */
 	orig_jiffies = jiffies;
 	for (ret = 0, try = 0; try <= adap->retries; try++) {
-		ret = adap->algo->master_xfer(adap, msgs, num);
+		if ((in_atomic() || irqs_disabled()) && adap->algo->master_xfer_irqless)
+			ret = adap->algo->master_xfer_irqless(adap, msgs, num);
+		else
+			ret = adap->algo->master_xfer(adap, msgs, num);
+
 		if (ret != -EAGAIN)
 			break;
 		if (time_after(jiffies, orig_jiffies + adap->timeout))
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..11e615123bd0 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -498,6 +498,8 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
  *   defined by the msgs array, with num messages available to transfer via
  *   the adapter specified by adap.
+ * @master_xfer_irqless: same as master_xfer. Yet, not using any interrupts
+ *   so e.g. PMICs can be accessed very late before shutdown
  * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If this
  *   is not present, then the bus layer will try and convert the SMBus calls
  *   into I2C transfers instead.
@@ -511,9 +513,9 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
  * to name two of the most common.
  *
- * The return codes from the @master_xfer field should indicate the type of
- * error code that occurred during the transfer, as documented in the kernel
- * Documentation file Documentation/i2c/fault-codes.
+ * The return codes from the @master_xfer{_irqless} field should indicate the
+ * type of error code that occurred during the transfer, as documented in the
+ * Kernel Documentation file Documentation/i2c/fault-codes.
  */
 struct i2c_algorithm {
 	/* If an adapter algorithm can't do I2C-level access, set master_xfer
@@ -524,6 +526,8 @@ struct i2c_algorithm {
 	   processed, or a negative value on error */
 	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num);
+	int (*master_xfer_irqless)(struct i2c_adapter *adap,
+				   struct i2c_msg *msgs, int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
 			   unsigned short flags, char read_write,
 			   u8 command, int size, union i2c_smbus_data *data);
-- 
2.18.0
