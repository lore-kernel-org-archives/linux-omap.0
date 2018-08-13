From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data I/O
Date: Tue, 14 Aug 2018 00:34:48 +0200
Message-ID: <20180813223448.21316-8-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Don't readw()/writew() data directly from/to GPIO port which is under
control of gpio-omap driver, use GPIO API instead.

Degrade of performance on Amstrad Delta is significant, can be
recognized as a regression, that's why I'm still submitting this patch
as RFC.

The driver should work with any 8+-bit bidirectional GPIO port, not
only OMAP.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Exceprts fro timestamped boot logs showing performance degrade.
Before the change:
[    5.469426] Creating 6 MTD partitions on "ams-delta-nand":
[    5.480909] 0x000000000000-0x000000380000 : "Kernel"
[    5.502659] 0x000000380000-0x0000003c0000 : "u-boot"
[    5.523055] 0x0000003c0000-0x000000400000 : "u-boot params"
[    5.543612] 0x000000400000-0x000000440000 : "Amstrad LDR"
[    5.564607] 0x000000440000-0x000001f40000 : "File system"
[    5.601760] 0x000001f40000-0x000002000000 : "PBL reserved"
[    5.624369] usbcore: registered new interface driver dm9601
[    5.636233] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.649191] ohci-omap: OHCI OMAP driver
[    5.660713] ohci ohci: OMAP OHCI
[    5.671299] ohci ohci: new USB bus registered, assigned bus number 1
[    5.686862] ohci ohci: irq 54, io mem 0xfffba000
[    5.785897] hub 1-0:1.0: USB hub found
[    5.797856] hub 1-0:1.0: 3 ports detected
[    5.817576] usbcore: registered new interface driver usb-storage
[    5.832551] ams-delta-serio ams-delta-serio: incomplete constraints, dummy supplies not allowed
[    5.858588] ams-delta-serio ams-delta-serio: regulator request failed (-19)
[    5.879312] input: omap-keypad as /devices/platform/omap-keypad/input/input0
[    5.902490] omap_rtc omap_rtc: already running
[    5.922929] omap_rtc omap_rtc: registered as rtc0
[    5.945570] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[    5.976712] usbcore: registered new interface driver btusb
[    6.007348] cx20442-codec cx20442-codec: incomplete constraints, dummy supplies not allowed
[    6.040575] cx20442-codec cx20442-codec: failed to get POR supply (-19)
[    6.060916] cx20442-codec cx20442-codec: ASoC: failed to probe component -517
[    6.083486] ams-delta-audio ams-delta-audio: ASoC: failed to instantiate card -517
[    6.121850] ams-delta-audio ams-delta-audio: snd_soc_register_card failed (-517)
[    6.163047] NET: Registered protocol family 17
[    6.182770] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.203517] Bluetooth: BNEP socket layer initialized
[    6.283017] serial8250 serial8250.1: Linked as a consumer to regulator.1
[    6.306113] usb 1-1: new full-speed USB device number 2 using ohci
[    6.328825] clock: disabling unused clocks to save power
[    6.350426] Skipping reset check for DSP domain clock "dsptim_ck"
[    6.372272] Skipping reset check for DSP domain clock "dspxor_ck"
[    6.393712] Skipping reset check for DSP domain clock "dspper_ck"
[    6.428311] ams-delta-serio ams-delta-serio: Linked as a consumer to regulator.2
[    6.467801] serio serio0: AMS DELTA keyboard adapter
[    6.492511] cx20442-codec cx20442-codec: Linked as a consumer to regulator.1
[    6.527382] ams-delta-audio ams-delta-audio: cx20442-voice <-> omap-mcbsp.1 mapping ok
[    6.577387] input: AMS_DELTA hook_switch as /devices/platform/ams-delta-audio/sound/card0/input1
[    6.627497] input: AT Raw Set 2 keyboard as /devices/platform/ams-delta-serio/serio0/input/input2
[    6.673663] omap_rtc omap_rtc: setting system clock to 2013-02-09 07:22:13 UTC (1360394533)
[    6.715895] modem_nreset: incomplete constraints, leaving on
[    6.738677] ALSA device list:
[    6.758398]   #0: AMS_DELTA
[    7.036234] dm9601 1-1:1.0 eth0: register 'dm9601' at usb-ohci-1, Davicom DM96xx USB 10/100 Ethernet, 00:60:6e:00:00:11
[  133.860599] random: crng init done
[  138.275853] VFS: Mounted root (jffs2 filesystem) on device 31:4.

After the change:
[    6.261107] Creating 6 MTD partitions on "ams-delta-nand":
[    6.272046] 0x000000000000-0x000000380000 : "Kernel"
[    6.294436] 0x000000380000-0x0000003c0000 : "u-boot"
[    6.314454] 0x0000003c0000-0x000000400000 : "u-boot params"
[    6.335353] 0x000000400000-0x000000440000 : "Amstrad LDR"
[    6.356669] 0x000000440000-0x000001f40000 : "File system"
[    6.393713] 0x000001f40000-0x000002000000 : "PBL reserved"
[    6.416771] usbcore: registered new interface driver dm9601
[    6.428631] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.441533] ohci-omap: OHCI OMAP driver
[    6.452758] ohci ohci: OMAP OHCI
[    6.463300] ohci ohci: new USB bus registered, assigned bus number 1
[    6.478817] ohci ohci: irq 54, io mem 0xfffba000
[    6.580520] hub 1-0:1.0: USB hub found
[    6.592424] hub 1-0:1.0: 3 ports detected
[    6.612363] usbcore: registered new interface driver usb-storage
[    6.627358] ams-delta-serio ams-delta-serio: incomplete constraints, dummy supplies not allowed
[    6.653296] ams-delta-serio ams-delta-serio: regulator request failed (-19)
[    6.674219] input: omap-keypad as /devices/platform/omap-keypad/input/input0
[    6.697910] omap_rtc omap_rtc: already running
[    6.718376] omap_rtc omap_rtc: registered as rtc0
[    6.740942] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[    6.772085] usbcore: registered new interface driver btusb
[    6.803187] cx20442-codec cx20442-codec: incomplete constraints, dummy supplies not allowed
[    6.836386] cx20442-codec cx20442-codec: failed to get POR supply (-19)
[    6.856730] cx20442-codec cx20442-codec: ASoC: failed to probe component -517
[    6.879234] ams-delta-audio ams-delta-audio: ASoC: failed to instantiate card -517
[    6.917325] ams-delta-audio ams-delta-audio: snd_soc_register_card failed (-517)
[    6.958519] NET: Registered protocol family 17
[    6.978224] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.998989] Bluetooth: BNEP socket layer initialized
[    7.077593] serial8250 serial8250.1: Linked as a consumer to regulator.1
[    7.100678] usb 1-1: new full-speed USB device number 2 using ohci
[    7.123429] clock: disabling unused clocks to save power
[    7.145074] Skipping reset check for DSP domain clock "dsptim_ck"
[    7.166983] Skipping reset check for DSP domain clock "dspxor_ck"
[    7.188434] Skipping reset check for DSP domain clock "dspper_ck"
[    7.223321] ams-delta-serio ams-delta-serio: Linked as a consumer to regulator.2
[    7.262882] serio serio0: AMS DELTA keyboard adapter
[    7.287656] cx20442-codec cx20442-codec: Linked as a consumer to regulator.1
[    7.322824] ams-delta-audio ams-delta-audio: cx20442-voice <-> omap-mcbsp.1 mapping ok
[    7.373165] input: AMS_DELTA hook_switch as /devices/platform/ams-delta-audio/sound/card0/input1
[    7.423520] input: AT Raw Set 2 keyboard as /devices/platform/ams-delta-serio/serio0/input/input2
[    7.469578] omap_rtc omap_rtc: setting system clock to 2013-02-09 07:34:10 UTC (1360395250)
[    7.511830] modem_nreset: incomplete constraints, leaving on
[    7.534812] ALSA device list:
[    7.554541]   #0: AMS_DELTA
[    7.971899] dm9601 1-1:1.0 eth0: register 'dm9601' at usb-ohci-1, Davicom DM96xx USB 10/100 Ethernet, 00:60:6e:00:00:11
[  133.935226] random: crng init done
[  320.764645] VFS: Mounted root (jffs2 filesystem) on device 31:4.

I think most of the overhead is in iterations performed both inside and
 outside get/set array functions:
- building a mask for get_multiple() and transfering results to value array
 in gpiod_get_array_value_complex(), then again from the array by a caller, 
- building a value array by the caller, the building a mask and tranferiing
 values from array to bitmap for .set_multiple() in
 gpiod_set_array_value_comples().

Thanks,
Janusz

 drivers/mtd/nand/raw/ams-delta.c | 126 ++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 59fc417e8fa9..8bedcd7c7928 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -24,13 +24,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_device.h>
 
-#include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/hardware.h>
-
 /*
  * MTD structure for E3 (Delta)
  */
@@ -44,7 +41,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_nwe;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
-	void __iomem		*io_base;
+	struct gpio_descs	*data_gpiods;
 	bool			data_in;
 };
 
@@ -73,52 +70,79 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
+static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = &priv->nand_chip;
-
-	writew(byte, this->IO_ADDR_W);
-
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static void ams_delta_write_byte(struct ams_delta_nand *priv, u_char byte)
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	void __iomem *io_base = priv->io_base;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = byte;
+	int i, value_array[data_gpiods->ndescs];
 
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		value_array[i] = test_bit(i, &bits);
+
+	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
+
+	ams_delta_write_commit(priv);
+}
+
+static void ams_delta_write_byte(struct ams_delta_nand *priv, u_char byte)
+{
 	if (priv->data_in) {
-		writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+		struct gpio_descs *data_gpiods = priv->data_gpiods;
+		unsigned long bits = byte;
+		int i;
+
+		for (i = 0; i < data_gpiods->ndescs; i++)
+			gpiod_direction_output_raw(data_gpiods->desc[i],
+						   test_bit(i, &bits));
 		priv->data_in = false;
-	}
 
-	ams_delta_write_next_byte(priv, byte);
+		ams_delta_write_commit(priv);
+	} else {
+		ams_delta_write_next_byte(priv, byte);
+	}
 }
 
 static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = &priv->nand_chip;
-	u_char res;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = 0;
+	int i, value_array[data_gpiods->ndescs];
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 
-	res = readw(this->IO_ADDR_R);
+	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
 
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	return res;
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		if (value_array[i])
+			__set_bit(i, &bits);
+
+	return bits;
 }
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
 
 	if (!priv->data_in) {
-		writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+		struct gpio_descs *data_gpiods = priv->data_gpiods;
+		int i;
+
+		for (i = 0; i < data_gpiods->ndescs; i++)
+			gpiod_direction_input(data_gpiods->desc[i]);
+
 		priv->data_in = true;
 	}
 
@@ -193,14 +217,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	void __iomem *io_base;
-	struct gpio_descs *data_gpiods;
 	int err = 0;
 
-	if (!res)
-		return -ENXIO;
-
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -213,25 +231,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
 
-	/*
-	 * Don't try to request the memory region from here,
-	 * it should have been already requested from the
-	 * gpio-omap driver and requesting it again would fail.
-	 */
-
-	io_base = ioremap(res->start, resource_size(res));
-	if (io_base == NULL) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -EIO;
-		goto out_free;
-	}
-
-	priv->io_base = io_base;
 	nand_set_controller_data(this, priv);
 
-	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
-	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
@@ -241,7 +242,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_rdy)) {
 		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	if (priv->gpiod_rdy)
@@ -259,67 +260,61 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nce)) {
 		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nre)) {
 		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nwe)) {
 		err = PTR_ERR(priv->gpiod_nwe);
 		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_ale)) {
 		err = PTR_ERR(priv->gpiod_ale);
 		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_cle)) {
 		err = PTR_ERR(priv->gpiod_cle);
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 	/* Request array of data pins, initialize them as input */
-	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
-	if (IS_ERR(data_gpiods)) {
-		err = PTR_ERR(data_gpiods);
+	priv->data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(priv->data_gpiods)) {
+		err = PTR_ERR(priv->data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
-		goto out_mtd;
+		return err;
 	}
 	priv->data_in = true;
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-		goto out_mtd;
+		return err;
 
 	/* Register the partitions */
 	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
 
-	goto out;
-
- out_mtd:
-	iounmap(io_base);
-out_free:
- out:
-	return err;
+	return 0;
 }
 
 /*
@@ -329,13 +324,10 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
-	void __iomem *io_base = priv->io_base;
 
-	/* Release resources, unregister device */
+	/* Unregister device */
 	nand_release(mtd);
 
-	iounmap(io_base);
-
 	return 0;
 }
 
-- 
2.16.4
