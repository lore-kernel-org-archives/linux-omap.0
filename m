From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 09/12] omap3: pm: TWL5030 version checking
Date: Mon, 21 Feb 2011 15:56:34 +0530
Message-ID: <AANLkTinWqtgRP5y6sMrGLbSxQ-s4BnycrvBOcUeJBB3J@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-10-git-send-email-leslyam@ti.com>
	<AANLkTimuiYp1k2vMMnD-a=oqh==fkJdqsckTovguwqSO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56677 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755118Ab1BUK0f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 05:26:35 -0500
Received: by mail-vx0-f181.google.com with SMTP id 39so959699vxb.40
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 02:26:34 -0800 (PST)
In-Reply-To: <AANLkTimuiYp1k2vMMnD-a=oqh==fkJdqsckTovguwqSO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi David,

On Sat, Feb 19, 2011 at 5:21 AM, David Cohen <dacohen@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 18, 2011 at 7:08 PM, Lesly A M <leslyam@ti.com> wrote:
>> Added api to get the TWL5030 Si version from the IDCODE register.
>> It is used for enabling the workaround for TWL errata 27.
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0drivers/mfd/twl-core.c =A0| =A0 50 ++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/i2c/twl.h | =A0 10 +++++++++
>> =A02 files changed, 60 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
>> index a35fa7d..211c2cc 100644
>> --- a/drivers/mfd/twl-core.c
>> +++ b/drivers/mfd/twl-core.c
>> @@ -487,6 +487,56 @@ EXPORT_SYMBOL(twl_i2c_read_u8);
>>
>> =A0/*---------------------------------------------------------------=
-------*/
>>
>> +/**
>> + * twl_read_idcode_register - api to read the IDCODE register.
>> + * @value: returns 32 bit IDCODE register value.
>> + *
>> + * Unlocks the IDCODE register and read the 32 bit value.
>> + */
>> +int twl_read_idcode_register(u32 *value)
>> +{
>> + =A0 =A0 =A0 int err =3D 0;
>
> No need to initialize 'ret'.
Ok

>> +
>> + =A0 =A0 =A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, TWL_EEP=
ROM_R_UNLOCK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 R_UNLOCK_TEST_REG);
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to unlock IDCOD=
E registers\n");
>> +
>> + =A0 =A0 =A0 err =3D twl_i2c_read(TWL4030_MODULE_INTBR, (u8 *)(valu=
e),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0, 4);
>
> Variable 'err' is being overwritten here.
>
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030: unable to read IDCODE=
-%d\n", err);
>> +
>> + =A0 =A0 =A0 err =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, 0x0, R_=
UNLOCK_TEST_REG);
>
> Here again.
>
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to relock IDCOD=
E registers\n");
>> +
>> + =A0 =A0 =A0 return err;
>
> And then you're returning 'err'. Unless you care only about the last
> 'err' assignment, something is wrong here, isn't it? :)

Ok, I will use a label and goto that label if there is some err on any
i2c_read/write

>
>> +}
>> +
>> +/**
>> + * twl5030_get_si_ver - api to get TWL5030 Si version.
>> + * @value: returns Si version from IDCODE.
>> + *
>> + * Api to get the TWL5030 Si version from IDCODE value.
>> + */
>> +int twl5030_get_si_ver(u32 *value)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>
> No need to initialize 'ret'.
Ok

>> + =A0 =A0 =A0 static u32 twl_idcode;
>> +
>> + =A0 =A0 =A0 if (twl_idcode =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_read_idcode_register(&twl_=
idcode);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("TWL4030 Unable to check Si ver=
sion\n");
>
> Shouldn't you return error here?
Yes,

>> +
>> + =A0 =A0 =A0 if (TWL_SIL_TYPE(twl_idcode) =3D=3D TWL_SIL_5030)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *value =3D TWL_SIL_REV(twl_idcode);
>
> Otherwise, what happens here if twl_read_idcode_register() fails?
>
>> +
>> + =A0 =A0 =A0 return ret;
>
> return 0 if the code reaches this point.
Ok. I will do the changes

Regards,
Lesly A M

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
