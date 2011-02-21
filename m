From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 09/12] omap3: pm: TWL5030 version checking
Date: Mon, 21 Feb 2011 17:57:09 +0530
Message-ID: <AANLkTikqOX257nrM_z71YpZWdghqdwhKc0FdtUpS5+hA@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-10-git-send-email-leslyam@ti.com>
	<AANLkTimXt94tWuvUe+bJScciewvv=wZZ1cBUM7Dib5qn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55955 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550Ab1BUM1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 07:27:11 -0500
Received: by mail-vw0-f50.google.com with SMTP id 11so908204vws.9
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 04:27:10 -0800 (PST)
In-Reply-To: <AANLkTimXt94tWuvUe+bJScciewvv=wZZ1cBUM7Dib5qn@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Feb 21, 2011 at 5:44 PM, Krishnamoorthy, Balaji T
<balajitk@ti.com> wrote:
> On Fri, Feb 18, 2011 at 10:38 PM, Lesly A M <leslyam@ti.com> wrote:
>
> <snip>
>
>> +int twl5030_get_si_ver(u32 *value)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 static u32 twl_idcode;
>> +
>> + =A0 =A0 =A0 if (twl_idcode =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_read_idcode_register(&twl_=
idcode);
>
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to check Si ver=
sion\n");
> this if block should be under if (twl_idcode =3D=3D 0)
Ok

>> +
>> + =A0 =A0 =A0 if (TWL_SIL_TYPE(twl_idcode) =3D=3D TWL_SIL_5030)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *value =3D TWL_SIL_REV(twl_idcode);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(twl5030_get_si_ver);
>> +
>> =A0static struct device *
>> =A0add_numbered_child(unsigned chip, const char *name, int num,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pdata, unsigned pdata_len,
>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>> index f4bd475..5d3f2bf 100644
>> --- a/include/linux/i2c/twl.h
>> +++ b/include/linux/i2c/twl.h
>> @@ -150,7 +150,15 @@
>> =A0#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
x1 << 3)
>> =A0#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
x1 << 2)
>>
>> +#define R_UNLOCK_TEST_REG =A0 =A0 =A00x12
>> +#define TWL_EEPROM_R_UNLOCK =A0 =A00x49
>>
>> +#define TWL_SIL_TYPE(rev) =A0 =A0 =A0((rev) & 0x00FFFFFF)
>> +#define TWL_SIL_REV(rev) =A0 =A0 =A0 ((rev) >> 24)
>> +#define TWL_SIL_5030 =A0 =A0 =A0 =A0 =A0 0x09002F
>
> Is it 0x9802F or 0x09002F for TWL5030 ?

TWL5030 until ES 1.1 si the value read from the IDCODE register =A0was
showing 0x09002F (But in TRM it is 0x9802F)

Regards,
Lesly A M

>> +#define TWL5030_REV_1_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
>> +#define TWL5030_REV_1_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
>> +#define TWL5030_REV_1_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
>>
>> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4030
>> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x6030
>> @@ -180,6 +188,8 @@ int twl_i2c_read_u8(u8 mod_no, u8 *val, u8 reg);
>> =A0int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_byte=
s);
>> =A0int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes=
);
>>
>> +int twl5030_get_si_ver(u32 *value);
>> +
>> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>>
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
