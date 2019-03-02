From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 2/7] i2c: core: use I2C locking behaviour also for SMBUS
Date: Sat,  2 Mar 2019 14:47:30 +0100
Message-ID: <20190302134735.4393-3-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If I2C transfers are executed in atomic contexts, trylock is used
instead of lock. This behaviour was missing for SMBUS, although a lot of
transfers are of SMBUS type, either emulated or direct. So, factor out
the locking routine into a helper and use it for I2C and SMBUS.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/i2c-core-base.c  | 11 +++--------
 drivers/i2c/i2c-core-smbus.c |  7 ++++++-
 drivers/i2c/i2c-core.h       | 12 ++++++++++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cb6c5cb0df0b..004f8a3b6365 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1946,14 +1946,9 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 *    one (discarding status on the second message) or errno
 	 *    (discarding status on the first one).
 	 */
-	if (in_atomic() || irqs_disabled()) {
-		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
-		if (!ret)
-			/* I2C activity is ongoing. */
-			return -EAGAIN;
-	} else {
-		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
-	}
+	ret = __i2c_lock_bus_helper(adap);
+	if (ret)
+		return ret;
 
 	ret = __i2c_transfer(adap, msgs, num);
 	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 132119112596..357e083e8f45 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -20,6 +20,8 @@
 #include <linux/i2c-smbus.h>
 #include <linux/slab.h>
 
+#include "i2c-core.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/smbus.h>
 
@@ -530,7 +532,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 {
 	s32 res;
 
-	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	res = __i2c_lock_bus_helper(adapter);
+	if (res)
+		return res;
+
 	res = __i2c_smbus_xfer(adapter, addr, flags, read_write,
 			       command, protocol, data);
 	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 37576f50fe20..6e98aa811980 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -29,6 +29,18 @@ extern int		__i2c_first_dynamic_bus_num;
 
 int i2c_check_7bit_addr_validity_strict(unsigned short addr);
 
+static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
+{
+	int ret = 0;
+
+	if (in_atomic() || irqs_disabled())
+		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
+	else
+		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
-- 
2.11.0
