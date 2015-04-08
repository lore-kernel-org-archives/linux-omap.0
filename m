From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: dra7: Implement Workaround
 for Errata i814 - Bandgap Temperature read Dtemp can be corrupted
Date: Wed, 8 Apr 2015 09:54:39 +0530
Message-ID: <5524AD87.7040406@ti.com>
References: <1427445901-8461-1-git-send-email-j-keerthy@ti.com> <55234CE4.5070901@ti.com> <20150407200516.GD4203@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41984 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbDHEYq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Apr 2015 00:24:46 -0400
In-Reply-To: <20150407200516.GD4203@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com

Hi Eduardo,

Thanks for the review comments.

On Wednesday 08 April 2015 01:35 AM, Eduardo Valentin wrote:
> Hello K,
>
> On Tue, Apr 07, 2015 at 08:50:04AM +0530, Keerthy wrote:
>> Hi Eduardo,
>>
>> On Friday 27 March 2015 02:15 PM, Keerthy wrote:
>>> Bandgap Temperature read Dtemp can be corrupted
>>>
>>> DESCRIPTION
>>>          Read accesses to registers listed below can be corrupted d=
ue to incorrect resynchronization between
>>>          clock domains.
>>>
>>>          Read access to registers below can be corrupted :
>>>                  =E2=80=A2 CTRL_CORE_DTEMP_MPU/GPU/CORE/DSPEVE/IVA_=
n (n =3D 0 to 4)
>>>          =E2=80=A2 CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEVE/IVA_n
>>>
>>> WORKAROUND
>>>          Multiple reads to CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEV=
E/IVA[9:0]:
>>>          BGAP_DTEMPMPU/GPU/CORE/DSPEVE/IVA is needed to discard fal=
se value and read right value:
>>>                  1. Perform two successive reads to BGAP_DTEMP bit =
field.
>>>                          (a) If read1 returns Val1 and read2 return=
s Val1, then right value is Val1.
>>>                          (b) If read1 returns Val1, read 2 returns =
Val2, a third read is needed.
>>>                  2. Perform third read
>>>                          (a) If read3 returns Val2 then right value=
 is Val2.
>>>                          (b) If read3 returns Val3, then right valu=
e is Val3.
>
> The third read description (b) is misleading/confusing. Does it mean
> third read value is always correct or do we need to compare against v=
al1
> and val2? if val3 !=3D val2 && val3 !=3D val1, which one is correct? =
none?

That is all is given in the errata description. Seems to assume third=20
one is right value always.

>
>>>
>>
>
> Thanks for the detailed errata description.
>
>> A gentle ping on this.
>>
>
> Sorry for the late answer. (minor) Comment below:
>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>
>>> Read all the temperatures from the 5 sensors and saw that
>>> they were sane with time.
>>>
>>> Ran cpuloadgen and saw that temperatures rising on all the sensors
>>> and cooled down as soon as the load was reduced.
>>>
>>>   .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
>>>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 37 +++++++++=
++++++++++++-
>>>   drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 +++
>>>   3 files changed, 42 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b=
/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> index a492927..58b5c66 100644
>>> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> @@ -420,7 +420,8 @@ const struct ti_bandgap_data dra752_data =3D {
>>>   			TI_BANDGAP_FEATURE_FREEZE_BIT |
>>>   			TI_BANDGAP_FEATURE_TALERT |
>>>   			TI_BANDGAP_FEATURE_COUNTER_DELAY |
>>> -			TI_BANDGAP_FEATURE_HISTORY_BUFFER,
>>> +			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
>>> +			TI_BANDGAP_FEATURE_ERRATA_814,
>>>   	.fclock_name =3D "l3instr_ts_gclk_div",
>>>   	.div_ck_name =3D "l3instr_ts_gclk_div",
>>>   	.conv_table =3D dra752_adc_to_temp,
>>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/=
thermal/ti-soc-thermal/ti-bandgap.c
>>> index 74c0e34..baf822e 100644
>>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
>>> @@ -119,6 +119,37 @@ exit:
>>>   }
>>>
>>>   /**
>>> + * ti_dra7_bandgap_read_temp() - helper function to read dra7 sens=
or temperature
>>> + * @bgp: pointer to ti_bandgap structure
>>> + * @reg: desired register (offset) to be read
>>> + *
>>> + * Function to read dra7 bandgap sensor temperature. This is done =
separately
>>> + * so as to workaround the errata "Bandgap Temperature read Dtemp =
can be
>>> + * corrupted" - Errata ID: i814".
>>> + * Read accesses to registers listed below can be corrupted due to=
 incorrect
>>> + * resynchronization between clock domains.
>>> + * Read access to registers below can be corrupted :
>>> + * CTRL_CORE_DTEMP_MPU/GPU/CORE/DSPEVE/IVA_n (n =3D 0 to 4)
>>> + * CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEVE/IVA_n
>>> + *
>>> + * Return: the register value.
>>> + */
>>> +static u32 ti_dra7_bandgap_read_temp(struct ti_bandgap *bgp,  u32 =
reg)
>
> Are you sure this bug affects only DRA7? I would prefer you name this
> not specific to soc version. Maybe bind it to the errata:

AFAIK it is impacting DRA7 not sure of OMAP5 and OMAP4. Okay I can name=
=20
it on the errata number. Yeah makes sense too. If other versions tend t=
o=20
have this then we can just add this errata feature to them also.

>
> +static u32 ti_i814_bandgap_read_temp(struct ti_bandgap *bgp,  u32 re=
g)
>
>>> +{
>>> +	u32 val1, val2;
>>> +
>>> +	val1 =3D ti_bandgap_readl(bgp, reg);
>>> +	val2 =3D ti_bandgap_readl(bgp, reg);
>>> +
>>> +/* If both times we read the same value then that is right */
>
> Please, indent the comments too.

Okay.

>
>>> +	if (val1 =3D=3D val2)
>>> +		return val1;
>>> +
>>> +/* if val1 and val2 are different read it third time */
>
> ditto.

Okay

>
>>> +	return ti_bandgap_readl(bgp, reg);
>
> Actually, if I understood the errata description correctly, you need =
to:
> 1. read a third time (val3)
> 2. compare val3 against val2, and return val2 if they are same
>
> If they are different, the errata is not clear. Can you please clarif=
y?

2. Perform third read
(a) If read3 returns Val2 then right value is Val2.
(b) If read3 returns Val3, then right value is Val3.

Which means errata assumes third value is the good value no matter what=
=2E

>
>>> +}
>>> +
>>> +/**
>>>    * ti_bandgap_read_temp() - helper function to read sensor temper=
ature
>>>    * @bgp: pointer to ti_bandgap structure
>>>    * @id: bandgap sensor id
>>> @@ -148,7 +179,11 @@ static u32 ti_bandgap_read_temp(struct ti_band=
gap *bgp, int id)
>>>   	}
>>>
>>>   	/* read temperature */
>>> -	temp =3D ti_bandgap_readl(bgp, reg);
>>> +	if (TI_BANDGAP_HAS(bgp, ERRATA_814))
>>> +		temp =3D ti_dra7_bandgap_read_temp(bgp, reg);
>>> +	else
>>> +		temp =3D ti_bandgap_readl(bgp, reg);
>>> +
>>>   	temp &=3D tsr->bgap_dtemp_mask;
>>>
>>>   	if (TI_BANDGAP_HAS(bgp, FREEZE_BIT))
>>> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/=
thermal/ti-soc-thermal/ti-bandgap.h
>>> index b3adf72..b2da3fc 100644
>>> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
>>> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
>>> @@ -318,6 +318,9 @@ struct ti_temp_sensor {
>>>    * TI_BANDGAP_FEATURE_HISTORY_BUFFER - used when the bandgap devi=
ce features
>>>    *	a history buffer of temperatures.
>>>    *
>>> + * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the ban=
dgap device
>>> + *	has Errata 814
>>> + *
>>>    * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is c=
apable of a
>>>    *      specific feature (above) or not. Return non-zero, if yes.
>>>    */
>>> @@ -331,6 +334,7 @@ struct ti_temp_sensor {
>>>   #define TI_BANDGAP_FEATURE_FREEZE_BIT		BIT(7)
>>>   #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
>>>   #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
>>> +#define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
>>>   #define TI_BANDGAP_HAS(b, f)			\
>>>   			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
>>>
>>>

-Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
