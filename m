From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [patch FYI] twl4030 dumps revision info
Date: Fri, 17 Oct 2008 04:49:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702396893F6@dbde02.ent.ti.com>
References: <200810152123.42459.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYJPXUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 19:20:09 -0400
In-Reply-To: <200810152123.42459.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>Sent: Wednesday, October 15, 2008 11:24 PM
>To: linux-omap@vger.kernel.org
>Subject: [patch FYI] twl4030 dumps revision info
>
>
>---
> drivers/mfd/twl4030-core.c |   62 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
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

End of line should be ;
	Hope you are not using , operator :-) 

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

