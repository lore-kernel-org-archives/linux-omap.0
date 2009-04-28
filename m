From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [RFC] [Patch 2/2] Proposal for changes to TWL4030/TWL5030 framework
 for integrating the new TWL6030 chip
Date: Tue, 28 Apr 2009 10:54:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BDE9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40151 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757742AbZD1FYn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 01:24:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3S5OaxL005775
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 00:24:42 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3S5OZfZ015488
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 10:54:35 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch:
        - Creates a new file twl.c
        - Segregates functions common between TWL4030 and TWL6030 and moves them from twl4030-core.c            into twl.c

Index: linux-omap-2.6/drivers/mfd/twl.c
===================================================================
--- /dev/null
+++ linux-omap-2.6/drivers/mfd/twl.c
@@ -0,0 +1,279 @@
+/*
+ * twl.c - driver for TWL device
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *
+ * Modifications to defer interrupt handling to a kernel thread:
+ * Copyright (C) 2006 MontaVista Software, Inc.
+ *
+ * Based on tlv320aic23.c:
+ * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
+ *
+ * Code cleanup and modifications to IRQ handler.
+ * by syed khasim <x0khasim@ti.com>
+ *
+ * Moved twl generic code from twl4030-core.c to twl.c
+ * - Jagadeesh Pakaravoor <j-pakaravoor@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+
+
+/*----------------------------------------------------------------------*/
+
+/* Exported Functions */
+
+/**
+ * twl_i2c_write - Writes a n bit register in TWL
+ * @mod_no: module number
+ * @value: an array of num_bytes+1 containing data to write
+ * @reg: register address (just offset will do)
+ * @num_bytes: number of bytes to transfer
+ *
+ * IMPORTANT: for 'value' parameter: Allocate value num_bytes+1 and
+ * valid data starts at Offset 1.
+ *
+ * Returns the result of operation - 0 is success
+ */
+int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+{
+       int ret;
+       int sid;
+       struct twl_client *twl;
+       struct i2c_msg *msg;
+
+       if (unlikely(mod_no > TWL_MODULE_LAST)) {
+               pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+               return -EPERM;
+       }
+       sid = twl_map[mod_no].sid;
+       twl = &twl_modules[sid];
+
+       if (unlikely(!inuse)) {
+               pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
+               return -EPERM;
+       }
+       mutex_lock(&twl->xfer_lock);
+       /*
+        * [MSG1]: fill the register address data
+        * fill the data Tx buffer
+        */
+       msg = &twl->xfer_msg[0];
+       msg->addr = twl->address;
+       msg->len = num_bytes + 1;
+       msg->flags = 0;
+       msg->buf = value;
+       /* over write the first byte of buffer with the register address */
+       *value = twl_map[mod_no].base + reg;
+       ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
+       mutex_unlock(&twl->xfer_lock);
+
+       /* i2cTransfer returns num messages.translate it pls.. */
+       if (ret >= 0)
+               ret = 0;
+       return ret;
+}
+EXPORT_SYMBOL(twl_i2c_write);
+
+/**
+ * twl_i2c_read - Reads a n bit register in TWL
+ * @mod_no: module number
+ * @value: an array of num_bytes containing data to be read
+ * @reg: register address (just offset will do)
+ * @num_bytes: number of bytes to transfer
+ *
+ * Returns result of operation - num_bytes is success else failure.
+ */
+int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
+{
+       int ret;
+       u8 val;
+       int sid;
+       struct twl_client *twl;
+       struct i2c_msg *msg;
+
+       if (unlikely(mod_no > TWL_MODULE_LAST)) {
+               pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+               return -EPERM;
+       }
+       sid = twl_map[mod_no].sid;
+       twl = &twl_modules[sid];
+
+       if (unlikely(!inuse)) {
+               pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
+               return -EPERM;
+       }
+       mutex_lock(&twl->xfer_lock);
+       /* [MSG1] fill the register address data */
+       msg = &twl->xfer_msg[0];
+       msg->addr = twl->address;
+       msg->len = 1;
+       msg->flags = 0; /* Read the register value */
+       val = twl_map[mod_no].base + reg;
+       msg->buf = &val;
+       /* [MSG2] fill the data rx buffer */
+       msg = &twl->xfer_msg[1];
+       msg->addr = twl->address;
+       msg->flags = I2C_M_RD;  /* Read the register value */
+       msg->len = num_bytes;   /* only n bytes */
+       msg->buf = value;
+       ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 2);
+       mutex_unlock(&twl->xfer_lock);
+
+       /* i2cTransfer returns num messages.translate it pls.. */
+       if (ret >= 0)
+               ret = 0;
+       return ret;
+}
+EXPORT_SYMBOL(twl_i2c_read);
+
+/**
+ * twl_i2c_write_u8 - Writes a 8 bit register in TWL
+ * @mod_no: module number
+ * @value: the value to be written 8 bit
+ * @reg: register address (just offset will do)
+ *
+ * Returns result of operation - 0 is success
+ */
+int twl_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
+{
+
+       /* 2 bytes offset 1 contains the data offset 0 is used by i2c_write */
+       u8 temp_buffer[2] = { 0 };
+       /* offset 1 contains the data */
+       temp_buffer[1] = value;
+       return twl_i2c_write(mod_no, temp_buffer, reg, 1);
+}
+EXPORT_SYMBOL(twl_i2c_write_u8);
+
+/**
+ * twl_i2c_read_u8 - Reads a 8 bit register from TWL
+ * @mod_no: module number
+ * @value: the value read 8 bit
+ * @reg: register address (just offset will do)
+ *
+ * Returns result of operation - 0 is success
+ */
+int twl_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
+{
+       return twl_i2c_read(mod_no, value, reg, 1);
+}
+EXPORT_SYMBOL(twl_i2c_read_u8);
+
+/*----------------------------------------------------------------------*/
+
+int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+int twl_exit_irq(void);
+int add_children(struct twl_platform_data *pdata, unsigned long features);
+
+static int twl_remove(struct i2c_client *client)
+{
+       unsigned i;
+       int status;
+
+       status = twl_exit_irq();
+       if (status < 0)
+               return status;
+
+       for (i = 0; i < TWL_NUM_SLAVES; i++) {
+               struct twl_client       *twl = &twl_modules[i];
+
+               if (twl->client && twl->client != client)
+                       i2c_unregister_device(twl->client);
+               twl_modules[i].client = NULL;
+       }
+       inuse = false;
+       return 0;
+}
+
+/* NOTE:  this driver only handles a single twl/tps659x0 chip */
+static int
+twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+       int                             status;
+       unsigned                        i;
+       struct twl_platform_data        *pdata = client->dev.platform_data;
+
+       if (!pdata) {
+               dev_dbg(&client->dev, "no platform data?\n");
+               return -EINVAL;
+       }
+
+       if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+               dev_dbg(&client->dev, "can't talk I2C?\n");
+               return -EIO;
+       }
+
+       if (inuse) {
+               dev_dbg(&client->dev, "driver is already in use\n");
+               return -EBUSY;
+       }
+
+       for (i = 0; i < TWL_NUM_SLAVES; i++) {
+               struct twl_client       *twl = &twl_modules[i];
+
+               twl->address = client->addr + i;
+               if (i == 0)
+                       twl->client = client;
+               else {
+                       twl->client = i2c_new_dummy(client->adapter,
+                                       twl->address);
+                       if (!twl->client) {
+                               dev_err(&twl->client->dev,
+                                       "can't attach client %d\n", i);
+                               status = -ENOMEM;
+                               goto fail;
+                       }
+                       strlcpy(twl->client->name, id->name,
+                                       sizeof(twl->client->name));
+               }
+               mutex_init(&twl->xfer_lock);
+       }
+       inuse = true;
+
+       /* setup clock framework */
+       clocks_init(&client->dev);
+
+       /* load power event scripts */
+       if (twl_has_power() && pdata->power)
+               twl_power_init(pdata->power);
+
+       /* Maybe init the T2 Interrupt subsystem */
+       if (client->irq
+                       && pdata->irq_base
+                       && pdata->irq_end > pdata->irq_base) {
+               status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
+               if (status < 0)
+                       goto fail;
+       }
+
+       status = add_children(pdata, id->driver_data);
+fail:
+       if (status < 0)
+               twl_remove(client);
+       return status;
+}
+static int __init twl_init(void)
+{
+       return i2c_add_driver(&twl_driver);
+}
+subsys_initcall(twl_init);
+
+static void __exit twl_exit(void)
+{
+       i2c_del_driver(&twl_driver);
+}
+module_exit(twl_exit);
Index: linux-omap-2.6/drivers/mfd/twl4030-core.c
===================================================================
--- linux-omap-2.6.orig/drivers/mfd/twl4030-core.c
+++ linux-omap-2.6/drivers/mfd/twl4030-core.c
@@ -241,147 +241,6 @@ extern void twl_power_init(struct twl_po

 /*----------------------------------------------------------------------*/

-/* Exported Functions */
-
-/**
- * twl_i2c_write - Writes a n bit register in TWL
- * @mod_no: module number
- * @value: an array of num_bytes+1 containing data to write
- * @reg: register address (just offset will do)
- * @num_bytes: number of bytes to transfer
- *
- * IMPORTANT: for 'value' parameter: Allocate value num_bytes+1 and
- * valid data starts at Offset 1.
- *
- * Returns the result of operation - 0 is success
- */
-int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
-{
-       int ret;
-       int sid;
-       struct twl_client *twl;
-       struct i2c_msg *msg;
-
-       if (unlikely(mod_no > TWL_MODULE_LAST)) {
-               pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
-               return -EPERM;
-       }
-       sid = twl_map[mod_no].sid;
-       twl = &twl_modules[sid];
-
-       if (unlikely(!inuse)) {
-               pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
-               return -EPERM;
-       }
-       mutex_lock(&twl->xfer_lock);
-       /*
-        * [MSG1]: fill the register address data
-        * fill the data Tx buffer
-        */
-       msg = &twl->xfer_msg[0];
-       msg->addr = twl->address;
-       msg->len = num_bytes + 1;
-       msg->flags = 0;
-       msg->buf = value;
-       /* over write the first byte of buffer with the register address */
-       *value = twl_map[mod_no].base + reg;
-       ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
-       mutex_unlock(&twl->xfer_lock);
-
-       /* i2cTransfer returns num messages.translate it pls.. */
-       if (ret >= 0)
-               ret = 0;
-       return ret;
-}
-EXPORT_SYMBOL(twl_i2c_write);
-
-/**
- * twl_i2c_read - Reads a n bit register in TWL
- * @mod_no: module number
- * @value: an array of num_bytes containing data to be read
- * @reg: register address (just offset will do)
- * @num_bytes: number of bytes to transfer
- *
- * Returns result of operation - num_bytes is success else failure.
- */
-int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
-{
-       int ret;
-       u8 val;
-       int sid;
-       struct twl_client *twl;
-       struct i2c_msg *msg;
-
-       if (unlikely(mod_no > TWL_MODULE_LAST)) {
-               pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
-               return -EPERM;
-       }
-       sid = twl_map[mod_no].sid;
-       twl = &twl_modules[sid];
-
-       if (unlikely(!inuse)) {
-               pr_err("%s: client %d is not initialized\n", DRIVER_NAME, sid);
-               return -EPERM;
-       }
-       mutex_lock(&twl->xfer_lock);
-       /* [MSG1] fill the register address data */
-       msg = &twl->xfer_msg[0];
-       msg->addr = twl->address;
-       msg->len = 1;
-       msg->flags = 0; /* Read the register value */
-       val = twl_map[mod_no].base + reg;
-       msg->buf = &val;
-       /* [MSG2] fill the data rx buffer */
-       msg = &twl->xfer_msg[1];
-       msg->addr = twl->address;
-       msg->flags = I2C_M_RD;  /* Read the register value */
-       msg->len = num_bytes;   /* only n bytes */
-       msg->buf = value;
-       ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 2);
-       mutex_unlock(&twl->xfer_lock);
-
-       /* i2cTransfer returns num messages.translate it pls.. */
-       if (ret >= 0)
-               ret = 0;
-       return ret;
-}
-EXPORT_SYMBOL(twl_i2c_read);
-
-/**
- * twl_i2c_write_u8 - Writes a 8 bit register in TWL
- * @mod_no: module number
- * @value: the value to be written 8 bit
- * @reg: register address (just offset will do)
- *
- * Returns result of operation - 0 is success
- */
-int twl_i2c_write_u8(u8 mod_no, u8 value, u8 reg)
-{
-
-       /* 2 bytes offset 1 contains the data offset 0 is used by i2c_write */
-       u8 temp_buffer[2] = { 0 };
-       /* offset 1 contains the data */
-       temp_buffer[1] = value;
-       return twl_i2c_write(mod_no, temp_buffer, reg, 1);
-}
-EXPORT_SYMBOL(twl_i2c_write_u8);
-
-/**
- * twl_i2c_read_u8 - Reads a 8 bit register from TWL
- * @mod_no: module number
- * @value: the value read 8 bit
- * @reg: register address (just offset will do)
- *
- * Returns result of operation - 0 is success
- */
-int twl_i2c_read_u8(u8 mod_no, u8 *value, u8 reg)
-{
-       return twl_i2c_read(mod_no, value, reg, 1);
-}
-EXPORT_SYMBOL(twl_i2c_read_u8);
-
-/*----------------------------------------------------------------------*/
-
 static struct device *
 add_numbered_child(unsigned chip, const char *name, int num,
                void *pdata, unsigned pdata_len,
@@ -724,98 +583,6 @@ static void __init clocks_init(struct de
                pr_err("%s: clock init err [%d]\n", DRIVER_NAME, e);
 }

-/*----------------------------------------------------------------------*/
-
-int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
-int twl_exit_irq(void);
-
-static int twl_remove(struct i2c_client *client)
-{
-       unsigned i;
-       int status;
-
-       status = twl_exit_irq();
-       if (status < 0)
-               return status;
-
-       for (i = 0; i < TWL_NUM_SLAVES; i++) {
-               struct twl_client       *twl = &twl_modules[i];
-
-               if (twl->client && twl->client != client)
-                       i2c_unregister_device(twl->client);
-               twl_modules[i].client = NULL;
-       }
-       inuse = false;
-       return 0;
-}
-
-/* NOTE:  this driver only handles a single twl/tps659x0 chip */
-static int
-twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
-{
-       int                             status;
-       unsigned                        i;
-       struct twl_platform_data        *pdata = client->dev.platform_data;
-
-       if (!pdata) {
-               dev_dbg(&client->dev, "no platform data?\n");
-               return -EINVAL;
-       }
-
-       if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
-               dev_dbg(&client->dev, "can't talk I2C?\n");
-               return -EIO;
-       }
-
-       if (inuse) {
-               dev_dbg(&client->dev, "driver is already in use\n");
-               return -EBUSY;
-       }
-
-       for (i = 0; i < TWL_NUM_SLAVES; i++) {
-               struct twl_client       *twl = &twl_modules[i];
-
-               twl->address = client->addr + i;
-               if (i == 0)
-                       twl->client = client;
-               else {
-                       twl->client = i2c_new_dummy(client->adapter,
-                                       twl->address);
-                       if (!twl->client) {
-                               dev_err(&twl->client->dev,
-                                       "can't attach client %d\n", i);
-                               status = -ENOMEM;
-                               goto fail;
-                       }
-                       strlcpy(twl->client->name, id->name,
-                                       sizeof(twl->client->name));
-               }
-               mutex_init(&twl->xfer_lock);
-       }
-       inuse = true;
-
-       /* setup clock framework */
-       clocks_init(&client->dev);
-
-       /* load power event scripts */
-       if (twl_has_power() && pdata->power)
-               twl_power_init(pdata->power);
-
-       /* Maybe init the T2 Interrupt subsystem */
-       if (client->irq
-                       && pdata->irq_base
-                       && pdata->irq_end > pdata->irq_base) {
-               status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
-               if (status < 0)
-                       goto fail;
-       }
-
-       status = add_children(pdata, id->driver_data);
-fail:
-       if (status < 0)
-               twl_remove(client);
-       return status;
-}

 static const struct i2c_device_id twl_ids[] = {
        { "twl", TWL_VAUX2 },   /* "Triton 2" */
@@ -835,18 +602,6 @@ static struct i2c_driver twl_driver = {
        .remove         = twl_remove,
 };

-static int __init twl_init(void)
-{
-       return i2c_add_driver(&twl_driver);
-}
-subsys_initcall(twl_init);
-
-static void __exit twl_exit(void)
-{
-       i2c_del_driver(&twl_driver);
-}
-module_exit(twl_exit);
-
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("I2C Core interface for TWL");
+MODULE_DESCRIPTION("I2C Core interface for TWL4030");
 MODULE_LICENSE("GPL");
--
With Regards,
Jagadeesh Bhaskar P

----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
----------------------------

