From: David Brownell <david-b@pacbell.net>
Subject: [patch linux-omap-git] twl4030-core: cleanups
Date: Thu, 25 Sep 2008 00:33:57 -0700
Message-ID: <200809250033.58063.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:36209 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751619AbYIYHeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 03:34:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

A bunch of little cleanups to twl4030-core.

 - Remove needless header inclusions, symbols, and
   forward declarations.

 - Make coding style more standard.

And shrink the object size a bit.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/twl4030-core.c |   79 +++++++++++++------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -25,34 +25,23 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
-#include <linux/module.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
-#include <linux/time.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/random.h>
-#include <linux/syscalls.h>
 #include <linux/kthread.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-gpio.h>
 #include <linux/i2c/twl4030-madc.h>
 #include <linux/i2c/twl4030-pwrirq.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/device.h>
-#include <linux/irq.h>
-
-#include <asm/mach/irq.h>
-
-#include <mach/gpio.h>
-#include <mach/mux.h>
 
 #define DRIVER_NAME			"twl4030"
 
@@ -70,16 +59,13 @@
 /* Last - for index max*/
 #define TWL4030_MODULE_LAST		TWL4030_MODULE_SECURED_REG
 
+#define TWL4030_NUM_SLAVES		4
+
 /* Slave address */
-#define TWL4030_NUM_SLAVES		0x04
 #define TWL4030_SLAVENUM_NUM0		0x00
 #define TWL4030_SLAVENUM_NUM1		0x01
 #define TWL4030_SLAVENUM_NUM2		0x02
 #define TWL4030_SLAVENUM_NUM3		0x03
-#define TWL4030_SLAVEID_ID0		0x48
-#define TWL4030_SLAVEID_ID1		0x49
-#define TWL4030_SLAVEID_ID2		0x4A
-#define TWL4030_SLAVEID_ID3		0x4B
 
 /* Base Address defns */
 /* USB ID */
@@ -143,9 +129,6 @@
 #define HFCLK_FREQ_38p4_MHZ		(3 << 0)
 #define HIGH_PERF_SQ			(1 << 3)
 
-/* on I2C-1 for 2430SDP */
-#define CONFIG_I2C_TWL4030_ID		1
-
 /* SIH_CTRL registers that aren't defined elsewhere */
 #define TWL4030_INTERRUPTS_BCISIHCTRL	0x0d
 #define TWL4030_MADC_MADC_SIH_CTRL	0x67
@@ -284,9 +267,6 @@ static const struct twl4030_mod_iregs __
 };
 
 
-/* Helper functions */
-static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc);
-
 /* Data Structures */
 /* To have info on T2 IRQ substem activated or not */
 static struct completion irq_event;
@@ -294,8 +274,7 @@ static struct completion irq_event;
 /* Structure to define on TWL4030 Slave ID */
 struct twl4030_client {
 	struct i2c_client *client;
-	const unsigned char address;
-	const char adapter_index;
+	u8 address;
 	bool inuse;
 
 	/* max numb of i2c_msg required is for read =2 */
@@ -337,33 +316,24 @@ static struct twl4030mapping twl4030_map
 	{ TWL4030_SLAVENUM_NUM3, TWL4030_BASEADD_SECURED_REG },
 };
 
-static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES] = {
-	{
-		.address	= TWL4030_SLAVEID_ID0,
-		.adapter_index	= CONFIG_I2C_TWL4030_ID,
-	},
-	{
-		.address	= TWL4030_SLAVEID_ID1,
-		.adapter_index	= CONFIG_I2C_TWL4030_ID,
-	},
-	{
-		.address	= TWL4030_SLAVEID_ID2,
-		.adapter_index	= CONFIG_I2C_TWL4030_ID,
-	},
-	{
-		.address	= TWL4030_SLAVEID_ID3,
-		.adapter_index	= CONFIG_I2C_TWL4030_ID,
-	},
-};
+static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES];
 
 /*
  * TWL4030 doesn't have PIH mask, hence dummy function for mask
  * and unmask.
  */
 
-static void twl4030_i2c_ackirq(unsigned int irq) {}
-static void twl4030_i2c_disableint(unsigned int irq) {}
-static void twl4030_i2c_enableint(unsigned int irq) {}
+static void twl4030_i2c_ackirq(unsigned int irq)
+{
+}
+
+static void twl4030_i2c_disableint(unsigned int irq)
+{
+}
+
+static void twl4030_i2c_enableint(unsigned int irq)
+{
+}
 
 /* information for processing in the Work Item */
 static struct irq_chip twl4030_irq_chip = {
@@ -749,7 +719,7 @@ static struct task_struct * __init start
 			     "twl4030 irq %d", irq);
 	if (!thread)
 		pr_err("%s: could not create twl4030 irq %d thread!\n",
-		       __func__, irq);
+		       DRIVER_NAME, irq);
 
 	return thread;
 }
@@ -799,9 +769,15 @@ static int __init power_companion_init(v
 	clk_put(osc);
 
 	switch (rate) {
-	case 19200000 : ctrl = HFCLK_FREQ_19p2_MHZ; break;
-	case 26000000 : ctrl = HFCLK_FREQ_26_MHZ; break;
-	case 38400000 : ctrl = HFCLK_FREQ_38p4_MHZ; break;
+	case 19200000:
+		ctrl = HFCLK_FREQ_19p2_MHZ;
+		break;
+	case 26000000:
+		ctrl = HFCLK_FREQ_26_MHZ;
+		break;
+	case 38400000:
+		ctrl = HFCLK_FREQ_38p4_MHZ;
+		break;
 	}
 
 	ctrl |= HIGH_PERF_SQ;
@@ -980,6 +956,7 @@ twl4030_probe(struct i2c_client *client,
 	for (i = 0; i < TWL4030_NUM_SLAVES; i++) {
 		struct twl4030_client	*twl = &twl4030_modules[i];
 
+		twl->address = client->addr + i;
 		if (i == 0)
 			twl->client = client;
 		else {
