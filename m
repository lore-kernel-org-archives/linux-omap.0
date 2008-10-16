From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [patch FYI] twl4030 dumps revision info
Date: Fri, 17 Oct 2008 04:57:44 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702396893F7@dbde02.ent.ti.com>
References: <200810152123.42459.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56906 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbYJPX15 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 19:27:57 -0400
In-Reply-To: <200810152123.42459.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Dave

>Sent: Wednesday, October 15, 2008 11:24 PM
>To: linux-omap@vger.kernel.org
>Subject: [patch FYI] twl4030 dumps revision info
>
>This is a diagnostic patch, dumping the IDCODE of the
>TWL4030/TWL5030/... family chips.
>
>Not for merging, at least for now.  Later this may be
>useful to make sure the reduced-functionality catalog
>parts (TPS series) don't go registering components that
>don't exist, like the battery charger.
>
>The main curiousity we've uncovered is that TWL5030 ES1.0
>mis-identifies itself as TWL4030 ES1.0 ... unclear just now
>whether that's also true of ES1.1 and later parts.

As per TRM, 
the idcode for TWL5030 should be: 0x0009802F

is it not what you are observing? Or was it the , bug !!

>
>- Dave
>
>---
> drivers/mfd/twl4030-core.c |   62 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
>--- a/drivers/mfd/twl4030-core.c
>+++ b/drivers/mfd/twl4030-core.c
>@@ -748,6 +748,66 @@ static int twl4030_remove(struct i2c_cli
> 	return 0;
> }
>
>+struct es_desc {
>+	u8	nibble;
>+	char	name[4];
>+};
>+
>+static const struct es_desc twl4030_es[] = {
>+	{ 0, "1.0", },
>+	{ 1, "2.x", },
>+	{ 4, "3.0", },
>+	{ 5, "3.1", },
>+	{ },
>+};
>+static const struct es_desc twl5030_es[] = {
>+	{ 0, "1.0", },
>+	{ 1, "1.1", },
>+	{ },
>+};
>+
>+static u32 twl_id(struct device *dev)
>+{
>+	const u32 mask = ((1 << 16) - 1) << 12;
>+	union { u8 bytes[4]; u32 word; } idcode;
>+	int status;
>+	u8 nibble;
>+	char *chip;
>+	const struct es_desc *desc;
>+
>+	status = twl4030_i2c_read(TWL4030_MODULE_INTBR,
>+			idcode.bytes, 0, 4);
>+	if (status < 0)
>+		return 0;
>+
>+	idcode.word = le32_to_cpu(idcode.word),
>+	nibble = idcode.word >> 28;
>+
>+	/* NOTE:  TWL5030 / TPS65930 ES1.0 mis-identifies as TWL4030 */
>+
>+	if ((idcode.word & mask) == (0x0009002F & mask)) {
>+		chip = "TWL4030";
>+		desc = twl4030_es;
>+	} else if ((idcode.word & mask) == (0x0009802F & mask)) {
>+		chip = "TWL5030";
>+		desc = twl5030_es;
>+	} else {
>+		chip = "unrecognized";
>+		desc = NULL;
>+	}
>+
>+	while (desc && desc->name[0]) {
>+		if (desc->nibble == nibble) {
>+			dev_info(dev, "%s ES %s; idcode %08x\n",
>+					chip, desc->name, idcode.word);
>+			return idcode.word;
>+		}
>+		desc++;
>+	}
>+	dev_info(dev, "%s; idcode %08x\n", chip, idcode.word);
>+	return idcode.word;
>+}
>+
> /* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
> static int
> twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
>@@ -795,6 +855,8 @@ twl4030_probe(struct i2c_client *client,
>
> 	if(0)dumpit();
>
>+	twl_id(&client->dev);
>+
> 	/* setup clock framework */
> 	clocks_init();
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

