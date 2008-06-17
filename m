From: Jean Delvare <khali@linux-fr.org>
Subject: testers wanted: isp1301_omap conversion to new-style i2c driver
Date: Tue, 17 Jun 2008 20:43:00 +0200
Message-ID: <20080617204300.77c8e516@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/hPkB.PxeQ19voBOnKoB3aQ3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:2477 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759620AbYFQSnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 14:43:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Linux I2C <i2c@lm-sensors.org>

--MP_/hPkB.PxeQ19voBOnKoB3aQ3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I have converted the isp1301_omap driver to a new-style i2c driver. The
problem is that I don't have an OMAP system nor even an ARM compiler,
so I cannot test my work at all. So, I would appreciate if someone with
access to an OMAP system could test if the isp1301_omap driver still
builds and works fine after applying the two attached patches.

Thanks,
-- 
Jean Delvare

--MP_/hPkB.PxeQ19voBOnKoB3aQ3
Content-Type: text/plain;
 name=i2c-isp1301_omap-convert-to-new-style-part-1.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=i2c-isp1301_omap-convert-to-new-style-part-1.patch

From: Felipe Balbi <me@felipebalbi.com>
Subject: i2c/isp1301_omap: Convert to a new-style i2c driver, part 1

Based on David Brownell's patch for tps65010, this patch
starts converting isp1301_omap.c to new-style i2c driver.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This needs testing! Both build-time and run-time.

 drivers/i2c/chips/isp1301_omap.c |   59 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/i2c/chips/isp1301_omap.c	2008-05-04 09:49:48.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/isp1301_omap.c	2008-06-17 16:07:46.000000000 +0200
@@ -49,7 +49,8 @@ MODULE_LICENSE("GPL");
 
 struct isp1301 {
 	struct otg_transceiver	otg;
-	struct i2c_client	client;
+	struct i2c_client	*client;
+	struct i2c_client	c;
 	void			(*i2c_release)(struct device *dev);
 
 	int			irq;
@@ -153,25 +154,25 @@ static struct i2c_driver isp1301_driver;
 static inline u8
 isp1301_get_u8(struct isp1301 *isp, u8 reg)
 {
-	return i2c_smbus_read_byte_data(&isp->client, reg + 0);
+	return i2c_smbus_read_byte_data(isp->client, reg + 0);
 }
 
 static inline int
 isp1301_get_u16(struct isp1301 *isp, u8 reg)
 {
-	return i2c_smbus_read_word_data(&isp->client, reg);
+	return i2c_smbus_read_word_data(isp->client, reg);
 }
 
 static inline int
 isp1301_set_bits(struct isp1301 *isp, u8 reg, u8 bits)
 {
-	return i2c_smbus_write_byte_data(&isp->client, reg + 0, bits);
+	return i2c_smbus_write_byte_data(isp->client, reg + 0, bits);
 }
 
 static inline int
 isp1301_clear_bits(struct isp1301 *isp, u8 reg, u8 bits)
 {
-	return i2c_smbus_write_byte_data(&isp->client, reg + 1, bits);
+	return i2c_smbus_write_byte_data(isp->client, reg + 1, bits);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -349,10 +350,10 @@ isp1301_defer_work(struct isp1301 *isp, 
 	int status;
 
 	if (isp && !test_and_set_bit(work, &isp->todo)) {
-		(void) get_device(&isp->client.dev);
+		(void) get_device(&isp->client->dev);
 		status = schedule_work(&isp->work);
 		if (!status && !isp->working)
-			dev_vdbg(&isp->client.dev,
+			dev_vdbg(&isp->client->dev,
 				"work item %d may be lost\n", work);
 	}
 }
@@ -1107,7 +1108,7 @@ isp1301_work(struct work_struct *work)
 		/* transfer state from otg engine to isp1301 */
 		if (test_and_clear_bit(WORK_UPDATE_ISP, &isp->todo)) {
 			otg_update_isp(isp);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 #endif
 		/* transfer state from isp1301 to otg engine */
@@ -1115,7 +1116,7 @@ isp1301_work(struct work_struct *work)
 			u8		stat = isp1301_clear_latch(isp);
 
 			isp_update_otg(isp, stat);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (test_and_clear_bit(WORK_HOST_RESUME, &isp->todo)) {
@@ -1150,7 +1151,7 @@ isp1301_work(struct work_struct *work)
 			}
 			host_resume(isp);
 			// mdelay(10);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (test_and_clear_bit(WORK_TIMER, &isp->todo)) {
@@ -1159,15 +1160,15 @@ isp1301_work(struct work_struct *work)
 			if (!stop)
 				mod_timer(&isp->timer, jiffies + TIMER_JIFFIES);
 #endif
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (isp->todo)
-			dev_vdbg(&isp->client.dev,
+			dev_vdbg(&isp->client->dev,
 				"work done, todo = 0x%lx\n",
 				isp->todo);
 		if (stop) {
-			dev_dbg(&isp->client.dev, "stop\n");
+			dev_dbg(&isp->client->dev, "stop\n");
 			break;
 		}
 	} while (isp->todo);
@@ -1191,7 +1192,7 @@ static void isp1301_release(struct devic
 {
 	struct isp1301	*isp;
 
-	isp = container_of(dev, struct isp1301, client.dev);
+	isp = device_get_drvdata(dev);
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1205,7 +1206,7 @@ static int isp1301_detach_client(struct 
 {
 	struct isp1301	*isp;
 
-	isp = container_of(i2c, struct isp1301, client);
+	isp = i2c_get_clientdata(i2c);
 
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_FALLING, ~0);
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
@@ -1257,7 +1258,7 @@ static int isp1301_otg_enable(struct isp
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
 		INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
 
-	dev_info(&isp->client.dev, "ready for dual-role USB ...\n");
+	dev_info(&isp->client->dev, "ready for dual-role USB ...\n");
 
 	return 0;
 }
@@ -1282,7 +1283,7 @@ isp1301_set_host(struct otg_transceiver 
 
 #ifdef	CONFIG_USB_OTG
 	isp->otg.host = host;
-	dev_dbg(&isp->client.dev, "registered host\n");
+	dev_dbg(&isp->client->dev, "registered host\n");
 	host_suspend(isp);
 	if (isp->otg.gadget)
 		return isp1301_otg_enable(isp);
@@ -1297,7 +1298,7 @@ isp1301_set_host(struct otg_transceiver 
 	if (machine_is_omap_h2())
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
 
-	dev_info(&isp->client.dev, "A-Host sessions ok\n");
+	dev_info(&isp->client->dev, "A-Host sessions ok\n");
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
 		INTR_ID_GND);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
@@ -1315,7 +1316,7 @@ isp1301_set_host(struct otg_transceiver 
 	return 0;
 
 #else
-	dev_dbg(&isp->client.dev, "host sessions not allowed\n");
+	dev_dbg(&isp->client->dev, "host sessions not allowed\n");
 	return -EINVAL;
 #endif
 
@@ -1341,7 +1342,7 @@ isp1301_set_peripheral(struct otg_transc
 
 #ifdef	CONFIG_USB_OTG
 	isp->otg.gadget = gadget;
-	dev_dbg(&isp->client.dev, "registered gadget\n");
+	dev_dbg(&isp->client->dev, "registered gadget\n");
 	/* gadget driver may be suspended until vbus_connect () */
 	if (isp->otg.host)
 		return isp1301_otg_enable(isp);
@@ -1364,7 +1365,7 @@ isp1301_set_peripheral(struct otg_transc
 		INTR_SESS_VLD);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
 		INTR_VBUS_VLD);
-	dev_info(&isp->client.dev, "B-Peripheral sessions ok\n");
+	dev_info(&isp->client->dev, "B-Peripheral sessions ok\n");
 	dump_regs(isp, __func__);
 
 	/* If this has a Mini-AB connector, this mode is highly
@@ -1377,7 +1378,7 @@ isp1301_set_peripheral(struct otg_transc
 	return 0;
 
 #else
-	dev_dbg(&isp->client.dev, "peripheral sessions not allowed\n");
+	dev_dbg(&isp->client->dev, "peripheral sessions not allowed\n");
 	return -EINVAL;
 #endif
 }
@@ -1493,12 +1494,12 @@ static int isp1301_probe(struct i2c_adap
 	isp->timer.data = (unsigned long) isp;
 
 	isp->irq = -1;
-	isp->client.addr = address;
-	i2c_set_clientdata(&isp->client, isp);
-	isp->client.adapter = bus;
-	isp->client.driver = &isp1301_driver;
-	strlcpy(isp->client.name, DRIVER_NAME, I2C_NAME_SIZE);
-	i2c = &isp->client;
+	isp->c.addr = address;
+	i2c_set_clientdata(&isp->c, isp);
+	isp->c.adapter = bus;
+	isp->c.driver = &isp1301_driver;
+	strlcpy(isp->c.name, DRIVER_NAME, I2C_NAME_SIZE);
+	isp->client = i2c = &isp->c;
 
 	/* if this is a true probe, verify the chip ... */
 	if (kind < 0) {
@@ -1583,7 +1584,7 @@ fail2:
 		goto fail1;
 	}
 
-	isp->otg.dev = &isp->client.dev;
+	isp->otg.dev = &isp->client->dev;
 	isp->otg.label = DRIVER_NAME;
 
 	isp->otg.set_host = isp1301_set_host,

--MP_/hPkB.PxeQ19voBOnKoB3aQ3
Content-Type: text/plain;
 name=i2c-isp1301_omap-convert-to-new-style-part-2.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=i2c-isp1301_omap-convert-to-new-style-part-2.patch

From: Jean Delvare <khali@linux-fr.org>
Subject: i2c/isp1301_omap: Convert to a new-style i2c driver, part 2

Based on David Brownell's patch for tps65010 and previous work by
Felipe Balbi, this patch finishes conversting isp1301_omap to a
new-style i2c driver.

There's definitely room for further drivers cleanups, but these are
out of the scope of this patch.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This needs testing! Both build-time and run-time.

 arch/arm/mach-omap1/board-h3.c   |    4 +
 arch/arm/mach-omap2/board-h4.c   |   11 ++++
 drivers/i2c/chips/isp1301_omap.c |   98 ++++++++++++--------------------------
 3 files changed, 48 insertions(+), 65 deletions(-)

--- linux-2.6.26-rc6.orig/arch/arm/mach-omap1/board-h3.c	2008-06-17 16:07:25.000000000 +0200
+++ linux-2.6.26-rc6/arch/arm/mach-omap1/board-h3.c	2008-06-17 16:07:54.000000000 +0200
@@ -476,6 +476,10 @@ static struct i2c_board_info __initdata 
 		I2C_BOARD_INFO("tps65013", 0x48),
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2d),
+		.irq		= OMAP_GPIO_IRQ(14),
+	},
 };
 
 static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
--- linux-2.6.26-rc6.orig/arch/arm/mach-omap2/board-h4.c	2008-06-17 16:07:25.000000000 +0200
+++ linux-2.6.26-rc6/arch/arm/mach-omap2/board-h4.c	2008-06-17 16:07:54.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -392,6 +393,13 @@ static struct omap_board_config_kernel h
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static struct i2c_board_info __initdata h4_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("isp1301_omap", 0x2d),
+		.irq		= OMAP_GPIO_IRQ(125),
+	},
+};
+
 static void __init omap_h4_init(void)
 {
 	/*
@@ -412,6 +420,9 @@ static void __init omap_h4_init(void)
 	}
 #endif
 
+	i2c_register_board_info(1, h4_i2c_board_info,
+			ARRAY_SIZE(h4_i2c_board_info));
+
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/isp1301_omap.c	2008-06-17 16:07:46.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/isp1301_omap.c	2008-06-17 16:19:55.000000000 +0200
@@ -50,10 +50,8 @@ MODULE_LICENSE("GPL");
 struct isp1301 {
 	struct otg_transceiver	otg;
 	struct i2c_client	*client;
-	struct i2c_client	c;
 	void			(*i2c_release)(struct device *dev);
 
-	int			irq;
 	int			irq_type;
 
 	u32			last_otg_ctrl;
@@ -139,14 +137,6 @@ static inline void notresponding(struct 
 
 /*-------------------------------------------------------------------------*/
 
-/* only two addresses possible */
-#define	ISP_BASE		0x2c
-static unsigned short normal_i2c[] = {
-	ISP_BASE, ISP_BASE + 1,
-	I2C_CLIENT_END };
-
-I2C_CLIENT_INSMOD;
-
 static struct i2c_driver isp1301_driver;
 
 /* smbus apis are used for portability */
@@ -1202,7 +1192,7 @@ static void isp1301_release(struct devic
 
 static struct isp1301 *the_transceiver;
 
-static int isp1301_detach_client(struct i2c_client *i2c)
+static int __exit isp1301_remove(struct i2c_client *i2c)
 {
 	struct isp1301	*isp;
 
@@ -1210,7 +1200,7 @@ static int isp1301_detach_client(struct 
 
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_FALLING, ~0);
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
-	free_irq(isp->irq, isp);
+	free_irq(i2c->irq, isp);
 #ifdef	CONFIG_USB_OTG
 	otg_unbind(isp);
 #endif
@@ -1225,7 +1215,7 @@ static int isp1301_detach_client(struct 
 	put_device(&i2c->dev);
 	the_transceiver = 0;
 
-	return i2c_detach_client(i2c);
+	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1474,12 +1464,10 @@ isp1301_start_hnp(struct otg_transceiver
 
 /*-------------------------------------------------------------------------*/
 
-/* no error returns, they'd just make bus scanning stop */
-static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
+static int __init isp1301_probe(struct i2c_client *i2c)
 {
 	int			status;
 	struct isp1301		*isp;
-	struct i2c_client	*i2c;
 
 	if (the_transceiver)
 		return 0;
@@ -1493,37 +1481,19 @@ static int isp1301_probe(struct i2c_adap
 	isp->timer.function = isp1301_timer;
 	isp->timer.data = (unsigned long) isp;
 
-	isp->irq = -1;
-	isp->c.addr = address;
-	i2c_set_clientdata(&isp->c, isp);
-	isp->c.adapter = bus;
-	isp->c.driver = &isp1301_driver;
-	strlcpy(isp->c.name, DRIVER_NAME, I2C_NAME_SIZE);
-	isp->client = i2c = &isp->c;
-
-	/* if this is a true probe, verify the chip ... */
-	if (kind < 0) {
-		status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
-		if (status != I2C_VENDOR_ID_PHILIPS) {
-			dev_dbg(&bus->dev, "addr %d not philips id: %d\n",
-				address, status);
-			goto fail1;
-		}
-		status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
-		if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
-			dev_dbg(&bus->dev, "%d not isp1301, %d\n",
-				address, status);
-			goto fail1;
-		}
-	}
+	i2c_set_clientdata(i2c, isp);
+	isp->client = i2c;
 
-	status = i2c_attach_client(i2c);
-	if (status < 0) {
-		dev_dbg(&bus->dev, "can't attach %s to device %d, err %d\n",
-				DRIVER_NAME, address, status);
-fail1:
-		kfree(isp);
-		return 0;
+	/* verify the chip (shouldn't be necesary) */
+	status = isp1301_get_u16(isp, ISP1301_VENDOR_ID);
+	if (status != I2C_VENDOR_ID_PHILIPS) {
+		dev_dbg(&i2c->dev, "not philips id: %d\n", status);
+		goto fail;
+	}
+	status = isp1301_get_u16(isp, ISP1301_PRODUCT_ID);
+	if (status != I2C_PRODUCT_ID_PHILIPS_1301) {
+		dev_dbg(&i2c->dev, "not isp1301, %d\n", status);
+		goto fail;
 	}
 	isp->i2c_release = i2c->dev.release;
 	i2c->dev.release = isp1301_release;
@@ -1552,7 +1522,7 @@ fail1:
 	status = otg_bind(isp);
 	if (status < 0) {
 		dev_dbg(&i2c->dev, "can't bind OTG\n");
-		goto fail2;
+		goto fail;
 	}
 #endif
 
@@ -1565,26 +1535,21 @@ fail1:
 
 		/* IRQ wired at M14 */
 		omap_cfg_reg(M14_1510_GPIO2);
-		isp->irq = OMAP_GPIO_IRQ(2);
 		if (gpio_request(2, "isp1301") == 0)
 			gpio_direction_input(2);
 		isp->irq_type = IRQF_TRIGGER_FALLING;
 	}
 
 	isp->irq_type |= IRQF_SAMPLE_RANDOM;
-	status = request_irq(isp->irq, isp1301_irq,
+	status = request_irq(i2c->irq, isp1301_irq,
 			isp->irq_type, DRIVER_NAME, isp);
 	if (status < 0) {
 		dev_dbg(&i2c->dev, "can't get IRQ %d, err %d\n",
-				isp->irq, status);
-#ifdef	CONFIG_USB_OTG
-fail2:
-#endif
-		i2c_detach_client(i2c);
-		goto fail1;
+				i2c->irq, status);
+		goto fail;
 	}
 
-	isp->otg.dev = &isp->client->dev;
+	isp->otg.dev = &i2c->dev;
 	isp->otg.label = DRIVER_NAME;
 
 	isp->otg.set_host = isp1301_set_host,
@@ -1615,22 +1580,25 @@ fail2:
 			status);
 
 	return 0;
-}
 
-static int isp1301_scan_bus(struct i2c_adapter *bus)
-{
-	if (!i2c_check_functionality(bus, I2C_FUNC_SMBUS_BYTE_DATA
-			| I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EINVAL;
-	return i2c_probe(bus, &addr_data, isp1301_probe);
+fail:
+	kfree(isp);
+	return -ENODEV;
 }
 
+static struct i2c_device_id isp1301_id[] = {
+	{ "isp1301_omap", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isp1301_id);
+
 static struct i2c_driver isp1301_driver = {
 	.driver = {
 		.name	= "isp1301_omap",
 	},
-	.attach_adapter	= isp1301_scan_bus,
-	.detach_client	= isp1301_detach_client,
+	.probe		= isp1301_probe,
+	.remove		= __exit_p(isp1301_remove),
+	.id_table	= isp1301_id,
 };
 
 /*-------------------------------------------------------------------------*/

--MP_/hPkB.PxeQ19voBOnKoB3aQ3--
