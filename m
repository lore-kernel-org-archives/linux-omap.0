From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
Date: Tue, 1 Feb 2011 11:11:01 +0530
Message-ID: <AANLkTi=N4-LH07oCxJB2A0L3U7AEtdWsACFT6bmy+P=8@mail.gmail.com>
References: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com>
	<FCCFB4CDC6E5564B9182F639FC356087035FB31201@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59633 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859Ab1BAFlH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 00:41:07 -0500
Received: by pxi2 with SMTP id 2so1564745pxi.26
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 21:41:06 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035FB31201@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Abhilash,
On Mon, Jan 31, 2011 at 7:19 PM, Koyamangalath, Abhilash
<abhilash.kv@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Gulati, Shweta
>> Sent: Monday, January 24, 2011 11:07 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Gopinath, Thara; Gulati, Shweta
>> Subject: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on T=
WL.
>>
>> From: Thara Gopinath <thara@ti.com>
>>
>> The smartreflex bit on twl4030 needs to be enabled by default irresp=
ective
>> of whether smartreflex module is enabled on the OMAP side or not.
>> This is because without this bit enabled the voltage scaling through
>> vp forceupdate does not function properly on OMAP3.API added
>> 'omap3_twl_set_sr_bit' with parameter to set/clear SR bit. It is cle=
ared
>> for platforms where voltage is not scaled using vpforceupdate
>> or vc_bypass Method. In those cases 'omap3_twl_set_sr_bit' is called
>> from board file, to make sure this bit is not overwritten in
>> 'omap3_twl_init', a flag 'twl_sr_enable'
>> is added.
>>
>> This patch is based on LO PM Branch and Smartreflex has been
>> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
>> OMAP2430 SDP.
> The function twl4030_vsel_to_uv (where you have added a call to omap3=
_twl_set_sr_bit) method is getting invoked only from vp_volt_debug_get
> (which is for debugfs) and omap_vp_get_curr_volt (which no one seems =
to be calling). Due to this I was not able to get cpufreq to work.
> (I finally got it working by calling omap3_twl_set_sr_bit from omap3_=
twl_init instead).
> It looks like I'm missing something, maybe an intermediate patch? (I'=
d applied your patch manually on 2.6.37).
>
> -Abhilash
The function 'omap3_twl_set_sr_bit' is called from omap3_twl_init
only, while manually applying the patch u saw the function defined
above omap3_twl_init in patch.
>
>
>>
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_twl.c | =A0 62
>> ++++++++++++++++++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 | =A0 =A01 +
>> =A02 files changed, 63 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-
>> omap2/omap_twl.c
>> index 00e1d2b..871a349 100644
>> --- a/arch/arm/mach-omap2/omap_twl.c
>> +++ b/arch/arm/mach-omap2/omap_twl.c
>> @@ -59,8 +59,15 @@
>>
>> =A0static bool is_offset_valid;
>> =A0static u8 smps_offset;
>> +/*
>> + * Flag to ensure Smartreflex bit in TWL
>> + * being cleared in board file is not overwritten.
>> + */
>> +static bool twl_sr_enable =3D true;
>>
>> +#define TWL4030_DCDC_GLOBAL_CFG =A0 =A0 =A0 =A00x06
>> =A0#define REG_SMPS_OFFSET =A0 =A0 =A0 =A0 0xE0
>> +#define SMARTREFLEX_ENABLE =A0 =A0 BIT(3)
>>
>> =A0static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>> =A0{
>> @@ -269,6 +276,16 @@ int __init omap3_twl_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core_volt_info.vp_vddmax =3D OMAP3=
630_VP2_VLIMITTO_VDDMAX;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* The smartreflex bit on twl4030 needs to be enabled by
>> + =A0 =A0 =A0* default irrespective of whether smartreflex module is
>> + =A0 =A0 =A0* enabled on the OMAP side or not. This is because with=
out
>> + =A0 =A0 =A0* this bit enabled the voltage scaling through
>> + =A0 =A0 =A0* vp forceupdate does not function properly on OMAP3.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (twl_sr_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_twl_set_sr_bit(1);
>> +
>> =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("mpu");
>> =A0 =A0 =A0 omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info)=
;
>>
>> @@ -277,3 +294,48 @@ int __init omap3_twl_init(void)
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> +
>> +/**
>> + * omap3_twl_set_sr_bit() - API to Set/Clear SR bit on TWL
>> + * @flag: Flag to Set/Clear SR bit
>> + *
>> + * If flag is non zero, enables Smartreflex bit on TWL 4030
>> + * to make sure voltage scaling through Vp forceupdate works.
>> + * Else, the smartreflex bit on twl4030 is
>> + * cleared as there are platforms which use
>> + * OMAP3 and T2 but use Synchronized Scaling Hardware
>> + * Strategy (ENABLE_VMODE=3D1) and Direct Strategy Software
>> + * Scaling Mode (ENABLE_VMODE=3D0), for setting the voltages,
>> + * in those scenarios this bit is to be cleared.
>> + * API returns 0 on sucess, =A0error is returned
>> + * if I2C read/write fails.
>> + */
>> +
>> +int omap3_twl_set_sr_bit(u8 flag)
>> +{
>> + =A0 =A0 u8 temp;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_DC=
DC_GLOBAL_CFG);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 if (flag) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D SMARTREFLEX_ENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl_sr_enable =3D true;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~SMARTREFLEX_ENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl_sr_enable =3D false;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_DCDC_GLOBAL_CFG);
>> + =A0 =A0 if (ret) {
>> +err:
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unable to Read/Write to TWL403=
0 through I2C bus "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\n", __fu=
nc__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 704766b..c98be66 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -127,6 +127,7 @@ static inline void
>> omap_enable_smartreflex_on_init(void) {}
>> =A0#ifdef CONFIG_TWL4030_CORE
>> =A0extern int omap3_twl_init(void);
>> =A0extern int omap4_twl_init(void);
>> +extern int omap3_twl_set_sr_bit(u8 flag);
>> =A0#else
>> =A0static inline int omap3_twl_init(void)
>> =A0{
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
