From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Mon, 14 Feb 2011 14:24:56 -0800
Message-ID: <87y65iz22v.fsf@ti.com>
References: <1296798454-23755-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTin6my7MgZHSUx44EYmaAG8nrmjNsrQ-26H0vtUk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54899 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197Ab1BNWZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 17:25:05 -0500
Received: by mail-gy0-f173.google.com with SMTP id 5so2633440gye.18
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 14:25:02 -0800 (PST)
In-Reply-To: <AANLkTin6my7MgZHSUx44EYmaAG8nrmjNsrQ-26H0vtUk@mail.gmail.com>
	(Nishanth Menon's message of "Sat, 12 Feb 2011 16:10:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Sanjeev Premi <premi@ti.com>

"Menon, Nishanth" <nm@ti.com> writes:

> On Fri, Feb 4, 2011 at 11:17, Shweta Gulati <shweta.gulati@ti.com> wr=
ote:
>> From: Thara Gopinath <thara@ti.com>
>>
> Gentle ping - folks after 8 days no comments, does this rev address
> all previous comments? if so, it might be good to get some acks ;)

Gentle reminder.  Patchwork[1] keeps a queue of patches pending
review/merge etc.  If it's in patchwork it will get reviewed, most
likely in the order it was received.

There are lots of going on recently, so we have a good sized queue in
patchwork.

Kevin

[1] https://patchwork.kernel.org/project/linux-omap/list/

>> Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
>> Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
>> default expects that OMAP's I2C_SR is plugged in to TWL's I2C
>> and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not con=
nected,
>> the board files are expected to call omap3_twl_set_sr_bit(false) to
>> ensure that I2C_SR path is not set for voltage control and prevent
>> the default behavior of omap3_twl_init.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Thara Gopinath <thara@ti.com>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>>
>> This patch is based on LO PM Branch and Smartreflex has been
>> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
>> OMAP2430 SDP.
>>
>> =C2=A0arch/arm/mach-omap2/omap_twl.c | =C2=A0 61 +++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0arch/arm/mach-omap2/pm.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01=
 +
>> =C2=A02 files changed, 62 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/om=
ap_twl.c
>> index 00e1d2b..87e07da 100644
>> --- a/arch/arm/mach-omap2/omap_twl.c
>> +++ b/arch/arm/mach-omap2/omap_twl.c
>> @@ -59,8 +59,15 @@
>>
>> =C2=A0static bool is_offset_valid;
>> =C2=A0static u8 smps_offset;
>> +/*
>> + * Flag to ensure Smartreflex bit in TWL
>> + * being cleared in board file is not overwritten.
>> + */
>> +static bool __initdata twl_sr_enable_autoinit;
>>
>> +#define TWL4030_DCDC_GLOBAL_CFG =C2=A0 =C2=A0 =C2=A0 =C2=A00x06
>> =C2=A0#define REG_SMPS_OFFSET =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xE0
>> +#define SMARTREFLEX_ENABLE =C2=A0 =C2=A0 BIT(3)
>>
>> =C2=A0static unsigned long twl4030_vsel_to_uv(const u8 vsel)
>> =C2=A0{
>> @@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_core_vo=
lt_info.vp_vddmax =3D OMAP3630_VP2_VLIMITTO_VDDMAX;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* The smartreflex bit on twl4030 specif=
ies if the setting of voltage
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* is done over the I2C_SR path. Since t=
his setting is independent of
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the actual usage of smartreflex AVS m=
odule, we enable TWL SR bit
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* by default irrespective of whether sm=
artreflex AVS module is enabled
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* on the OMAP side or not. This is beca=
use without this bit enabled,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* the voltage scaling through vp forceu=
pdate/bypass mechanism of
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* voltage scaling will not function on =
TWL over I2C_SR.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 if (!twl_sr_enable_autoinit)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3_twl_set_sr_=
bit(true);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0voltdm =3D omap_voltage_domain_lookup("mp=
u");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_voltage_register_pmic(voltdm, &omap3=
_mpu_volt_info);
>>
>> @@ -277,3 +296,45 @@ int __init omap3_twl_init(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>> +
>> +/**
>> + * omap3_twl_set_sr_bit() - Set/Clear SR bit on TWL
>> + * @enable: enable SR mode in twl or not
>> + *
>> + * If 'enable' is true, enables Smartreflex bit on TWL 4030 to make=
 sure
>> + * voltage scaling through OMAP SR works. Else, the smartreflex bit
>> + * on twl4030 is cleared as there are platforms which use OMAP3 and=
 T2 but
>> + * use Synchronized Scaling Hardware Strategy (ENABLE_VMODE=3D1) an=
d Direct
>> + * Strategy Software Scaling Mode (ENABLE_VMODE=3D0), for setting t=
he voltages,
>> + * in those scenarios this bit is to be cleared (enable =3D false).
>> + *
>> + * Returns 0 on sucess, error is returned if I2C read/write fails.
>> + */
>> +int __init omap3_twl_set_sr_bit(bool enable)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 u8 temp;
>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 =C2=A0 if (twl_sr_enable_autoinit)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("%s: u=
nexpected multiple calls\n", __func__);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_PM_REC=
EIVER, &temp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL4=
030_DCDC_GLOBAL_CFG);
>> + =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (enable)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp |=3D SMARTRE=
=46LEX_ENABLE;
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp &=3D ~SMARTR=
EFLEX_ENABLE;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_PM_RE=
CEIVER, temp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL4=
030_DCDC_GLOBAL_CFG);
>> + =C2=A0 =C2=A0 =C2=A0 if (!ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 twl_sr_enable_aut=
oinit =3D true;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +err:
>> + =C2=A0 =C2=A0 =C2=A0 pr_err("%s: Error access to TWL4030 (%d)\n", =
__func__, ret);
>> + =C2=A0 =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 39580e6..797bfd1 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -127,6 +127,7 @@ static inline void omap_enable_smartreflex_on_in=
it(void) {}
>> =C2=A0#ifdef CONFIG_TWL4030_CORE
>> =C2=A0extern int omap3_twl_init(void);
>> =C2=A0extern int omap4_twl_init(void);
>> +extern int omap3_twl_set_sr_bit(bool enable);
>> =C2=A0#else
>> =C2=A0static inline int omap3_twl_init(void)
>> =C2=A0{
>> --
>> 1.7.0.4
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
