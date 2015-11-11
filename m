From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] rtc: ds1307: fix kernel splat due to wakeup irq handling
Date: Wed, 11 Nov 2015 10:11:01 -0600
Message-ID: <1447258261-2102-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Nishanth Menon <nm@ti.com>, rtc-linux@googlegroups.com, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Since commit 3fffd1283927 ("i2c: allow specifying
separate wakeup interrupt in device tree") we have
automatic wakeup irq support for i2c devices. That
commit missed the fact that rtc-1307 had its own
wakeup irq handling and ended up introducing a
kernel splat for at least Beagle x15 boards.

Fix that by reverting original commit _and_ passing
correct interrupt names on DTS so i2c-core can
choose correct IRQ as wakeup.

Now that we have automatic wakeirq support, we can
revert the original commit which did it manually.

Fixes the following warning:

[   10.346582] WARNING: CPU: 1 PID: 263 at linux/drivers/base/power/wakeirq.c:43 dev_pm_attach_wake_irq+0xbc/0xd4()
[   10.359244] rtc-ds1307 2-006f: wake irq already initialized

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |  1 +
 drivers/rtc/rtc-ds1307.c                | 36 +++------------------------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d9ba6b879fc1..00352e761b8c 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -604,6 +604,7 @@
 		reg = <0x6f>;
 		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
 				      <&dra7_pmx_core 0x424>;
+		interrupt-names = "irq", "wakeup";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 188006c55ce0..325836818826 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -15,9 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/pm_wakeirq.h>
 #include <linux/rtc/ds1307.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -117,7 +114,6 @@ struct ds1307 {
 #define HAS_ALARM	1		/* bit 1 == irq claimed */
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
-	int			wakeirq;
 	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
 			       u8 length, u8 *values);
 	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
@@ -1146,8 +1142,6 @@ read_rtc:
 	}
 
 	if (want_irq) {
-		struct device_node *node = client->dev.of_node;
-
 		err = devm_request_threaded_irq(&client->dev,
 						client->irq, NULL, irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
@@ -1155,34 +1149,13 @@ read_rtc:
 		if (err) {
 			client->irq = 0;
 			dev_err(&client->dev, "unable to request IRQ!\n");
-			goto no_irq;
-		}
-
-		set_bit(HAS_ALARM, &ds1307->flags);
-		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
-
-		/* Currently supported by OF code only! */
-		if (!node)
-			goto no_irq;
-
-		err = of_irq_get(node, 1);
-		if (err <= 0) {
-			if (err == -EPROBE_DEFER)
-				goto exit;
-			goto no_irq;
-		}
-		ds1307->wakeirq = err;
+		} else {
 
-		err = dev_pm_set_dedicated_wake_irq(&client->dev,
-						    ds1307->wakeirq);
-		if (err) {
-			dev_err(&client->dev, "unable to setup wakeIRQ %d!\n",
-				err);
-			goto exit;
+			set_bit(HAS_ALARM, &ds1307->flags);
+			dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
 		}
 	}
 
-no_irq:
 	if (chip->nvram_size) {
 
 		ds1307->nvram = devm_kzalloc(&client->dev,
@@ -1226,9 +1199,6 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (ds1307->wakeirq)
-		dev_pm_clear_wake_irq(&client->dev);
-
 	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
 		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
 
-- 
2.6.2
