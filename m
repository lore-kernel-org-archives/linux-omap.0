From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 25/25] eeprom: at24: remove at24_platform_data
Date: Tue, 13 Nov 2018 15:01:33 +0100
Message-ID: <20181113140133.17385-26-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of at24_platform_data. Remove the relevant
header and modify the driver code to not use it anymore.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS                        |   1 -
 drivers/misc/eeprom/at24.c         | 162 +++++++++++++----------------
 include/linux/platform_data/at24.h |  60 -----------
 3 files changed, 75 insertions(+), 148 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..b3ee25e95bd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2456,7 +2456,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/eeprom/at24.txt
 F:	drivers/misc/eeprom/at24.c
-F:	include/linux/platform_data/at24.h
 
 ATA OVER ETHERNET (AOE) DRIVER
 M:	"Ed L. Cashin" <ed.cashin@acm.org>
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 636ed7149793..f189a5307abd 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -22,10 +22,24 @@
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
-#include <linux/platform_data/at24.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio/consumer.h>
 
+/* Address pointer is 16 bit. */
+#define AT24_FLAG_ADDR16	BIT(7)
+/* sysfs-entry will be read-only. */
+#define AT24_FLAG_READONLY	BIT(6)
+/* sysfs-entry will be world-readable. */
+#define AT24_FLAG_IRUGO		BIT(5)
+/* Take always 8 addresses (24c00). */
+#define AT24_FLAG_TAKE8ADDR	BIT(4)
+/* Factory-programmed serial number. */
+#define AT24_FLAG_SERIAL	BIT(3)
+/* Factory-programmed mac address. */
+#define AT24_FLAG_MAC		BIT(2)
+/* Does not auto-rollover reads to the next slave address. */
+#define AT24_FLAG_NO_RDROL	BIT(1)
+
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
  * Differences between different vendor product lines (like Atmel AT24C or
@@ -107,10 +121,6 @@ module_param_named(write_timeout, at24_write_timeout, uint, 0);
 MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
 
 struct at24_chip_data {
-	/*
-	 * these fields mirror their equivalents in
-	 * struct at24_platform_data
-	 */
 	u32 byte_len;
 	u8 flags;
 };
@@ -468,63 +478,11 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-static void at24_properties_to_pdata(struct device *dev,
-				     struct at24_platform_data *chip)
-{
-	int err;
-	u32 val;
-
-	if (device_property_present(dev, "read-only"))
-		chip->flags |= AT24_FLAG_READONLY;
-	if (device_property_present(dev, "no-read-rollover"))
-		chip->flags |= AT24_FLAG_NO_RDROL;
-
-	err = device_property_read_u32(dev, "address-width", &val);
-	if (!err) {
-		switch (val) {
-		case 8:
-			if (chip->flags & AT24_FLAG_ADDR16)
-				dev_warn(dev, "Override address width to be 8, while default is 16\n");
-			chip->flags &= ~AT24_FLAG_ADDR16;
-			break;
-		case 16:
-			chip->flags |= AT24_FLAG_ADDR16;
-			break;
-		default:
-			dev_warn(dev, "Bad \"address-width\" property: %u\n",
-				 val);
-		}
-	}
-
-	err = device_property_read_u32(dev, "size", &val);
-	if (!err)
-		chip->byte_len = val;
-
-	err = device_property_read_u32(dev, "pagesize", &val);
-	if (!err) {
-		chip->page_size = val;
-	} else {
-		/*
-		 * This is slow, but we can't know all eeproms, so we better
-		 * play safe. Specifying custom eeprom-types via platform_data
-		 * is recommended anyhow.
-		 */
-		chip->page_size = 1;
-	}
-}
-
-static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
+static const struct at24_chip_data *at24_get_chip_data(struct device *dev)
 {
 	struct device_node *of_node = dev->of_node;
 	const struct at24_chip_data *cdata;
 	const struct i2c_device_id *id;
-	struct at24_platform_data *pd;
-
-	pd = dev_get_platdata(dev);
-	if (pd) {
-		memcpy(pdata, pd, sizeof(*pdata));
-		return 0;
-	}
 
 	id = i2c_match_id(at24_ids, to_i2c_client(dev));
 
@@ -541,13 +499,9 @@ static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
 		cdata = acpi_device_get_match_data(dev);
 
 	if (!cdata)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
-	pdata->byte_len = cdata->byte_len;
-	pdata->flags = cdata->flags;
-	at24_properties_to_pdata(dev, pdata);
-
-	return 0;
+	return cdata;
 }
 
 static void at24_remove_dummy_clients(struct at24_data *at24)
@@ -616,7 +570,8 @@ static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
-	struct at24_platform_data pdata = { };
+	u32 byte_len, page_size, flags, addrw;
+	const struct at24_chip_data *cdata;
 	struct device *dev = &client->dev;
 	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
@@ -631,35 +586,72 @@ static int at24_probe(struct i2c_client *client)
 	i2c_fn_block = i2c_check_functionality(client->adapter,
 					       I2C_FUNC_SMBUS_WRITE_I2C_BLOCK);
 
-	err = at24_get_pdata(dev, &pdata);
+	cdata = at24_get_chip_data(dev);
+	if (IS_ERR(cdata))
+		return PTR_ERR(cdata);
+
+	err = device_property_read_u32(dev, "pagesize", &page_size);
 	if (err)
-		return err;
+		/*
+		 * This is slow, but we can't know all eeproms, so we better
+		 * play safe. Specifying custom eeprom-types via platform_data
+		 * is recommended anyhow.
+		 */
+		page_size = 1;
+
+	flags = cdata->flags;
+	if (device_property_present(dev, "read-only"))
+		flags |= AT24_FLAG_READONLY;
+	if (device_property_present(dev, "no-read-rollover"))
+		flags |= AT24_FLAG_NO_RDROL;
+
+	err = device_property_read_u32(dev, "address-width", &addrw);
+	if (!err) {
+		switch (addrw) {
+		case 8:
+			if (flags & AT24_FLAG_ADDR16)
+				dev_warn(dev,
+					 "Override address width to be 8, while default is 16\n");
+			flags &= ~AT24_FLAG_ADDR16;
+			break;
+		case 16:
+			flags |= AT24_FLAG_ADDR16;
+			break;
+		default:
+			dev_warn(dev, "Bad \"address-width\" property: %u\n",
+				 addrw);
+		}
+	}
+
+	err = device_property_read_u32(dev, "size", &byte_len);
+	if (err)
+		byte_len = cdata->byte_len;
 
 	if (!i2c_fn_i2c && !i2c_fn_block)
-		pdata.page_size = 1;
+		page_size = 1;
 
-	if (!pdata.page_size) {
+	if (!page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
 
-	if (!is_power_of_2(pdata.page_size))
+	if (!is_power_of_2(page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
-	if (pdata.flags & AT24_FLAG_TAKE8ADDR)
+	if (flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
-		num_addresses =	DIV_ROUND_UP(pdata.byte_len,
-			(pdata.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+		num_addresses =	DIV_ROUND_UP(byte_len,
+			(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
-	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
+	if ((flags & AT24_FLAG_SERIAL) && (flags & AT24_FLAG_MAC)) {
 		dev_err(dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
 		return -EINVAL;
 	}
 
 	regmap_config.val_bits = 8;
-	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.reg_bits = (flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
 	regmap = devm_regmap_init_i2c(client, &regmap_config);
@@ -672,11 +664,11 @@ static int at24_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->byte_len = pdata.byte_len;
-	at24->page_size = pdata.page_size;
-	at24->flags = pdata.flags;
+	at24->byte_len = byte_len;
+	at24->page_size = page_size;
+	at24->flags = flags;
 	at24->num_addresses = num_addresses;
-	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
+	at24->offset_adj = at24_get_offset_adj(flags, byte_len);
 	at24->client[0].client = client;
 	at24->client[0].regmap = regmap;
 
@@ -684,10 +676,10 @@ static int at24_probe(struct i2c_client *client)
 	if (IS_ERR(at24->wp_gpio))
 		return PTR_ERR(at24->wp_gpio);
 
-	writable = !(pdata.flags & AT24_FLAG_READONLY);
+	writable = !(flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
-					pdata.page_size, at24_io_limit);
+					page_size, at24_io_limit);
 		if (!i2c_fn_i2c && at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
 	}
@@ -730,7 +722,7 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.priv = at24;
 	nvmem_config.stride = 1;
 	nvmem_config.word_size = 1;
-	nvmem_config.size = pdata.byte_len;
+	nvmem_config.size = byte_len;
 
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
@@ -739,13 +731,9 @@ static int at24_probe(struct i2c_client *client)
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		 pdata.byte_len, client->name,
+		 byte_len, client->name,
 		 writable ? "writable" : "read-only", at24->write_max);
 
-	/* export data to kernel code */
-	if (pdata.setup)
-		pdata.setup(at24->nvmem, pdata.context);
-
 	return 0;
 
 err_clients:
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
deleted file mode 100644
index 63507ff464ee..000000000000
--- a/include/linux/platform_data/at24.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * at24.h - platform_data for the at24 (generic eeprom) driver
- * (C) Copyright 2008 by Pengutronix
- * (C) Copyright 2012 by Wolfram Sang
- * same license as the driver
- */
-
-#ifndef _LINUX_AT24_H
-#define _LINUX_AT24_H
-
-#include <linux/types.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/bitops.h>
-
-/**
- * struct at24_platform_data - data to set up at24 (generic eeprom) driver
- * @byte_len: size of eeprom in byte
- * @page_size: number of byte which can be written in one go
- * @flags: tunable options, check AT24_FLAG_* defines
- * @setup: an optional callback invoked after eeprom is probed; enables kernel
-	code to access eeprom via nvmem, see example
- * @context: optional parameter passed to setup()
- *
- * If you set up a custom eeprom type, please double-check the parameters.
- * Especially page_size needs extra care, as you risk data loss if your value
- * is bigger than what the chip actually supports!
- *
- * An example in pseudo code for a setup() callback:
- *
- * void get_mac_addr(struct nvmem_device *nvmem, void *context)
- * {
- *	u8 *mac_addr = ethernet_pdata->mac_addr;
- *	off_t offset = context;
- *
- *	// Read MAC addr from EEPROM
- *	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
- *		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
- * }
- *
- * This function pointer and context can now be set up in at24_platform_data.
- */
-
-struct at24_platform_data {
-	u32		byte_len;		/* size (sum of all addr) */
-	u16		page_size;		/* for writes */
-	u8		flags;
-#define AT24_FLAG_ADDR16	BIT(7)	/* address pointer is 16 bit */
-#define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
-#define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
-#define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
-#define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
-#define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
-#define AT24_FLAG_NO_RDROL	BIT(1)	/* does not auto-rollover reads to */
-					/* the next slave address */
-
-	void		(*setup)(struct nvmem_device *nvmem, void *context);
-	void		*context;
-};
-
-#endif /* _LINUX_AT24_H */
-- 
2.19.1
