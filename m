From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 11:14:36 +0530
Message-ID: <AANLkTinAORWkciE04L3QSfXJ0Peb3xKLK=8Sq=tY4L-h@mail.gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<bf1e2a72d8f16365df684cd5add00eee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53091 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733Ab1BPFoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 00:44:39 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so1264314bwz.38
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 21:44:37 -0800 (PST)
In-Reply-To: <bf1e2a72d8f16365df684cd5add00eee@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Nishanth Menon <nm@ti.com>, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Feb 15, 2011 at 10:00 PM, Vishwanath Sripathy
<vishwanath.bs@ti.com> wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm=
-
>> kernel-bounces@lists.infradead.org] On Behalf Of Jarkko Nikula
>> Sent: Tuesday, February 15, 2011 8:47 PM
>> To: Shweta Gulati
>> Cc: Nishanth Menon; Thara Gopinath; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex =
on
>> TWL
>>
>> On Tue, 15 Feb 2011 13:28:58 +0530
>> Shweta Gulati <shweta.gulati@ti.com> wrote:
>>
>> > This patch is based on LO PM Branch and Smartreflex has been
>> > tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
>> > OMAP2430 SDP.
>> >
>> I saw this was working on N900 (kind of special instrumentation
>> setup) after enabling /sys/kernel/debug/voltage/[vdd_core |
>> vdd_mpu]/smartreflex/autocomp. Few comments below.
>>
>> > @@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
>> > =A0 =A0 =A0 =A0 =A0 =A0 omap3_core_volt_info.vp_vddmax =3D
>> OMAP3630_VP2_VLIMITTO_VDDMAX;
>> > =A0 =A0 }
>> ...
>> > + =A0 if (!twl_sr_enable_autoinit)
>> > + =A0 =A0 =A0 =A0 =A0 omap3_twl_set_sr_bit(true);
>> ...
>> > +int __init omap3_twl_set_sr_bit(bool enable)
>> > +{
>> > + =A0 u8 temp;
>> > + =A0 int ret;
>> > + =A0 if (twl_sr_enable_autoinit)
>> > + =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unexpected multiple calls\n"=
, __func__);
>> > +
>> > + =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 TWL4030_DCDC_GLOBAL_CFG);
>> > + =A0 if (ret)
>> > + =A0 =A0 =A0 =A0 =A0 goto err;
>> > +
>> > + =A0 if (enable)
>> > + =A0 =A0 =A0 =A0 =A0 temp |=3D SMARTREFLEX_ENABLE;
>> > + =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 temp &=3D ~SMARTREFLEX_ENABLE;
>> > +
>> > + =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_DCDC=
_GLOBAL_CFG);
>>
>> Would it make more sense to set only the flag here and do the regist=
er
>> writes when omap3_twl_init is executing? Then it's not so strict whe=
n
>> the board code calls this function.
> What if board code calls this function after twl_init is executed? Th=
en
> you will not clear the bit right?
> Intention of this function is to make sure the bit is set/cleared whe=
n it
> is called.
ompa3_twl_init is called from 'omap2_common_pm_late_init' which is
late_initcall.
So it would be called after board specific initializations are
completed in 'init' process.
> vishwa
>>
>> > + =A0 if (!ret) {
>> > + =A0 =A0 =A0 =A0 =A0 twl_sr_enable_autoinit =3D true;
>> > + =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> Should this be twl_sr_enable_autoinit =3D enable (if going to do
>> register write here)?
>>
>> --
>> Jarkko
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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
