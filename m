From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 1/3] OMAP4: Revise MPU Voltage rail values.
Date: Thu, 3 Mar 2011 19:31:49 +0530
Message-ID: <AANLkTinf1C3OMka2kr4V8e=DqTatz=qrFMMdgMHtTO-u@mail.gmail.com>
References: <1297837046-8831-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTikOpNk_6r0xGe=2EAduFxw_7JzjpYcvtR4STQX_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57452 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758380Ab1CCOBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 09:01:55 -0500
Received: by mail-bw0-f50.google.com with SMTP id 2so1497783bwz.23
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 06:01:51 -0800 (PST)
In-Reply-To: <AANLkTikOpNk_6r0xGe=2EAduFxw_7JzjpYcvtR4STQX_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

hi,

On Wed, Mar 2, 2011 at 1:02 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Wed, Feb 16, 2011 at 11:47, Shweta Gulati <shweta.gulati@ti.com> w=
rote:
>>
>> MPU voltage rail values are updated according to
>> latest OMAP4430 Data Manual Operating Condition Addendum.
>
> looks like the latest is evolving :(. I just checked against 0.3 of
> the data manual operating conditions:
Version I will add in V2.
> This patch does the following:
> MPU:
> #define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 1025000
> #define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01200000
> #define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 =A01313000
> #define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 =A01375000
> Verified - ok
>
> IVA currently:
> #define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 930000
> #define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01100000
> #define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 =A01260000
> Should be:
> #define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 1013000
> #define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01188000
> #define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 =A01300000
>
> Core currently - matches with the values in DM 0.3.
> #define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0930000
> #define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1100000
>
> Should we just have one patch to update both mpu and iva voltages?
IVA OPP Table is not there, I have submitted Patch which adds IVA OPP T=
able and
also updates Voltage Rail values.
> Regards,
> Nishanth Menon
>
>
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A08 ++++----
>> =A01 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pl=
at-omap/include/plat/voltage.h
>> index 5bd204e..4d9bab1 100644
>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> @@ -46,10 +46,10 @@
>> =A0#define OMAP3630_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 100000=
0
>> =A0#define OMAP3630_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0120000=
0
>>
>> -#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0930000
>> -#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1100000
>> -#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1260000
>> -#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1350000
>> +#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0102500=
0
>> +#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
>> +#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
>> +#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
>>
>> =A0#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A09300=
00
>> =A0#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 110000=
0
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
