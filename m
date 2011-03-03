From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH v8 4/7] omap3: pm: TWL5030 version checking
Date: Thu, 3 Mar 2011 17:30:09 +0530
Message-ID: <AANLkTik6t7MzHiKzoGv0B5PGug1pt2Oas2C5mtCeLLm3@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:57550 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753150Ab1CCMAP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 07:00:15 -0500
Received: by mail-vw0-f43.google.com with SMTP id 18so1031995vws.2
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 04:00:12 -0800 (PST)
In-Reply-To: <1299072653-13414-5-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 2, 2011 at 7:00 PM, Lesly A M <leslyam@ti.com> wrote:
<snip>

> =A0static struct device *
> =A0add_numbered_child(unsigned chip, const char *name, int num,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pdata, unsigned pdata_len,
> @@ -1056,6 +1114,9 @@ twl_probe(struct i2c_client *client, const stru=
ct i2c_device_id *id)
> =A0 =A0 =A0 =A0/* setup clock framework */
> =A0 =A0 =A0 =A0clocks_init(&client->dev, pdata->clock);
>
> + =A0 =A0 =A0 /* read TWL IDCODE Register */
> + =A0 =A0 =A0 twl_read_idcode_register();
> +

you missed check for TRITON again
BTW can you make twl_read_idcode_register static
if you are not exporting ?

@@ -1109,14 +1109,12 @@
 	} else {
 		twl_id =3D TWL4030_CLASS_ID;
 		twl_map =3D &twl4030_map[0];
+		twl_read_idcode_register();
 	}

 	/* setup clock framework */
 	clocks_init(&client->dev, pdata->clock);

-	/* read TWL IDCODE Register */
-	twl_read_idcode_register();
-
 	/* load power event scripts */
 	if (twl_has_power() && pdata->power)
 		twl4030_power_init(pdata->power);

> =A0 =A0 =A0 =A0/* load power event scripts */
> =A0 =A0 =A0 =A0if (twl_has_power() && pdata->power)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_power_init(pdata->power);
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index f4bd475..d3cc2ac 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -150,7 +150,12 @@
> =A0#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 3)
> =A0#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
1 << 2)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
