From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 2/6 V4] OMAP4: Adding the temperature sensor register set
 bit fields
Date: Thu, 1 Sep 2011 08:27:17 +0530
Message-ID: <CAJ6a13bq4C+aCUf8PML+ib6hjpeh7wUNzYhOUqbpi4+gNwAYsQ@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-3-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311801530.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54612 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757444Ab1IAC5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 22:57:19 -0400
Received: by iacb35 with SMTP id b35so1634957iac.8
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 19:57:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108311801530.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Sep 1, 2011 at 5:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> OMAP4460 specific temperature sensor register bit fields are added.
>> Existing OMAP4 entries are renamed to OMAP4430.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: tony@atomide.com
>
> At least one of these bitfields are incorrect. =A0Please double-check=
 them.
>
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
>
> For example, this bitfield is only eight bits wide on 4430.

I checked the 4430 TRM. It is 8 bits and the others are fine.
I will correct this.

>
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
> - Paul
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
