From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 1/6] OMAP4: Adding the temperature sensor register set bit fields
Date: Fri, 23 Sep 2011 11:26:04 +0530
Message-ID: <CAJ6a13ZUd38fezLDrz9JYqkzBEJyRHX=50dvxYNNu7_6d5Q6WA@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
	<1316705361-12175-2-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109222315320.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39569 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959Ab1IWF4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 01:56:07 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so4708878wyg.33
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 22:56:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109222315320.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 23, 2011 at 10:46 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 22 Sep 2011, Keerthy wrote:
>
>> OMAP4460 specific temperature sensor register bit fields are added.
>> Existing OMAP4 entries are renamed to OMAP4430.
>
> This patch ignores the comments posted here:
>
> http://marc.info/?l=3Dlinux-omap&m=3D131483545602617&w=3D2
>
> Please fix.

Sorry Paul. I missed it my bad. I will fix it.

>
>
> - Paul
>
>
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: tony@atomide.com
>> ---
>> =A0.../include/mach/ctrl_module_core_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
 70 ++++++++++++++++----
>> =A01 files changed, 57 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.=
h b/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>> index 2f7ac70..725c1e1 100644
>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>> @@ -256,19 +256,63 @@
>> =A0#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_SHIFT =A0 =A0 0
>> =A0#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(0x1f << 0)
>>
>> -/* TEMP_SENSOR */
>> -#define OMAP4_BGAP_TEMPSOFF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A012
>> -#define OMAP4_BGAP_TEMPSOFF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 12)
>> -#define OMAP4_BGAP_TSHUT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 11
>> -#define OMAP4_BGAP_TSHUT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 11)
>> -#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A010
>> -#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_MASK =A0 =A0 =A0 =A0 (1 << =
10)
>> -#define OMAP4_BGAP_TEMP_SENSOR_SOC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 9
>> -#define OMAP4_BGAP_TEMP_SENSOR_SOC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 9)
>> -#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A08
>> -#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 (1=
 << 8)
>> -#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_SHIFT =A0 =A0 =A0 =A0 =A0 0
>> -#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_MASK =A0 =A0 =A0 =A0 =A0 =A0(0=
xff << 0)
>> +/* TEMP_SENSOR OMAP4430 */
>> +#define OMAP4430_BGAP_TEMPSOFF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 12
>> +#define OMAP4430_BGAP_TEMPSOFF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 12)
>> +#define OMAP4430_BGAP_TSHUT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A011
>> +#define OMAP4430_BGAP_TSHUT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (1 << 11)
>> +#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_SHIFT =A0 =A0 =A0 =A0 =A0=
 =A0 10
>> +#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_MASK =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 10)
>> +#define OMAP4430_BGAP_TEMP_SENSOR_SOC_SHIFT =A0 =A0 =A0 =A0 =A09
>> +#define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 9)
>> +#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_SHIFT =A0 =A0 =A0 =A0 8
>> +#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK =A0 =A0 =A0 =A0 =A0(1 <=
< 8)
>> +#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00
>> +#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK =A0 =A0 =A0 =A0 (0x3ff=
 << 0)
>> +
>> +/* TEMP_SENSOR OMAP4460 */
>> +#define OMAP4460_BGAP_TEMPSOFF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 13
>> +#define OMAP4460_BGAP_TEMPSOFF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 13)
>> +#define OMAP4460_BGAP_TEMP_SENSOR_SOC_SHIFT =A0 =A0 =A0 =A0 =A011
>> +#define OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK =A0 =A0 =A0 =A0 =A0 (1 <=
< 11)
>> +#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_SHIFT =A0 =A0 =A0 =A0 10
>> +#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK =A0 =A0 =A0 =A0 =A0(1 <=
< 10)
>> +#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00
>> +#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK =A0 =A0 =A0 =A0 (0x3ff=
 << 0)
>> +
>> +/* BANDGAP_CTRL */
>> +#define OMAP4460_SINGLE_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 31
>> +#define OMAP4460_SINGLE_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 31)
>> +#define OMAP4460_MASK_HOT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define OMAP4460_MASK_HOT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define OMAP4460_MASK_COLD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0
>> +#define OMAP4460_MASK_COLD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +/* BANDGAP_COUNTER */
>> +#define OMAP4460_COUNTER_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define OMAP4460_COUNTER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0xffffff << 0)
>> +
>> +/* BANDGAP_THRESHOLD */
>> +#define OMAP4460_T_HOT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 16
>> +#define OMAP4460_T_HOT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x3ff << 16)
>> +#define OMAP4460_T_COLD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define OMAP4460_T_COLD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (0x3ff << 0)
>> +
>> +/* TSHUT_THRESHOLD */
>> +#define OMAP4460_TSHUT_HOT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 16
>> +#define OMAP4460_TSHUT_HOT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x3ff << 16)
>> +#define OMAP4460_TSHUT_COLD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00
>> +#define OMAP4460_TSHUT_COLD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (0x3ff << 0)
>> +
>> +/* BANDGAP_STATUS */
>> +#define OMAP4460_CLEAN_STOP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A03
>> +#define OMAP4460_CLEAN_STOP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 3)
>> +#define OMAP4460_BGAP_ALERT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A02
>> +#define OMAP4460_BGAP_ALERT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 2)
>> +#define OMAP4460_HOT_FLAG_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define OMAP4460_HOT_FLAG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define OMAP4460_COLD_FLAG_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0
>> +#define OMAP4460_COLD_FLAG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>>
>> =A0/* DPLL_NWELL_TRIM_0 */
>> =A0#define OMAP4_DPLL_ABE_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A0 29
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
