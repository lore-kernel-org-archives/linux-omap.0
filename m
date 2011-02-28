From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 5/8] omap3: pm: TWL5030 version checking
Date: Mon, 28 Feb 2011 16:34:34 +0530
Message-ID: <AANLkTimRQqYNaD_8a3ig4k9os--EJOpwx303Zj2fraOF@mail.gmail.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
	<1298723139-1693-6-git-send-email-leslyam@ti.com>
	<AANLkTi=WhX_qcYBcvQB17XSGL7Y1JnAVkjNmQieCyaLR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36453 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753160Ab1B1LEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 06:04:36 -0500
Received: by mail-vx0-f172.google.com with SMTP id 33so2743474vxg.3
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:04:35 -0800 (PST)
In-Reply-To: <AANLkTi=WhX_qcYBcvQB17XSGL7Y1JnAVkjNmQieCyaLR@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Balaji,

On Mon, Feb 28, 2011 at 12:54 PM, Krishnamoorthy, Balaji T
<balajitk@ti.com> wrote:
> On Sat, Feb 26, 2011 at 5:55 PM, Lesly A M <leslyam@ti.com> wrote:
>
> Minor comment you missed version number in subject.
>
> <snip>
>
>> +/**
>> + * twl_get_si_type - api to get TWL Si type.
>> + *
>> + * Api to get the TWL Si type from IDCODE value.
>> + */
>> +int twl_get_si_type(void)
>> +{
>> + =A0 =A0 =A0 return TWL_SIL_TYPE(twl_idcode);
>> +}
>> +EXPORT_SYMBOL(twl_get_si_type);
>> +
>> +/**
>> + * twl_get_si_version - api to get TWL Si version.
>> + *
>> + * Api to get the TWL Si version from IDCODE value.
>> + */
>> +int twl_get_si_version(void)
>> +{
>> + =A0 =A0 =A0 return TWL_SIL_REV(twl_idcode);
>> +}
>> +EXPORT_SYMBOL(twl_get_si_version);
>> +
>> =A0static struct device *
>> =A0add_numbered_child(unsigned chip, const char *name, int num,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pdata, unsigned pdata_len,
>> @@ -1056,6 +1114,12 @@ twl_probe(struct i2c_client *client, const st=
ruct i2c_device_id *id)
>> =A0 =A0 =A0 =A0/* setup clock framework */
>> =A0 =A0 =A0 =A0clocks_init(&client->dev, pdata->clock);
>>
>> + =A0 =A0 =A0 /* read TWL IDCODE Register */
>> + =A0 =A0 =A0 if (twl_read_idcode_register(&twl_idcode)) {
>
> Call this function only in case of Triton

How do I check it ?
using if (twl_id =3D=3D TWL4030_CLASS_ID)

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to read IDCODE =
Register\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>
> Do you really want to fail twl_probe due to error in reading IDCODE ?

Is the twl_probe function expected to continue, if the i2c read/write
on twl itself is failing ?

Regards,
Lesly A M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
