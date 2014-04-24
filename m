From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: clk-7xx: Correct ABE DPLL configuration
Date: Thu, 24 Apr 2014 18:03:59 +0300
Message-ID: <535927DF.90404@ti.com>
References: <1396446525-20302-1-git-send-email-peter.ujfalusi@ti.com> <533C1AC2.1000307@ti.com> <533CFFB3.9070201@ti.com> <5358D534.2070205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5358D534.2070205@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/24/2014 12:11 PM, Peter Ujfalusi wrote:
> Mike, Tero,
>
> On 04/03/2014 09:29 AM, Peter Ujfalusi wrote:
>> On 04/02/2014 05:12 PM, Tero Kristo wrote:
>>> On 04/02/2014 04:48 PM, Peter Ujfalusi wrote:
>>>> ABE DPLL frequency need to be lowered from 361267200
>>>> to 180633600 to facilitate the ATL requironments.
>>>> The dpll_abe_m2x2_ck clock need to be set to double
>>>> of ABE DPLL rate in order to have correct clocks
>>>> for audio.
>>>
>>> Do you have some sort of TRM reference for this?
>>
>> The ATL's max divider is 32.
>> For audio purpose the clock coming out from the ATL instance should =
be
>> 128 * fs. It is only possible to have 44.1KHz sampling rate with ABE=
 DPLL set
>> to 361267200 or 180633600. Which means:
>> The atl generated clock should be 128 * 44100 =3D 5644800
>>  From ABE_DPLL 361267200 we would need to have 64 as divider (ATL ca=
n't do this).
>>  From the suggested ABE_DPLL of 180633600 we can use ATL divider of =
32, which
>> is the maximum it can do.
>>
>> So the reason for the change is to have ATLPCLK clock which can be u=
sed for
>> audio in the future, the 361267200 is just too high.
>
> Tero: can I have your ack for this patch or do you have further conce=
rns?

Yea looks good to me, except for the fact that there is some work on=20
getting default rate/parent support through DT. I would like a comment=20
from Mike about the estimate when this can get in, and whether we shoul=
d=20
merge intermediate solutions still like this.

Anyway, you can consider this patch acked by me, I'll let Mike to decid=
e=20
what to do with it though.

-Tero

> Mike: do you want me to resend this patch?
>
> Thanks,
> P=E9ter
>
>>
>>>
>>> -Tero
>>>
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>>    drivers/clk/ti/clk-7xx.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>>>> index f7e40734c819..19a55bf407dd 100644
>>>> --- a/drivers/clk/ti/clk-7xx.c
>>>> +++ b/drivers/clk/ti/clk-7xx.c
>>>> @@ -16,7 +16,7 @@
>>>>    #include <linux/clkdev.h>
>>>>    #include <linux/clk/ti.h>
>>>>
>>>> -#define DRA7_DPLL_ABE_DEFFREQ                361267200
>>>> +#define DRA7_DPLL_ABE_DEFFREQ                180633600
>>>>    #define DRA7_DPLL_GMAC_DEFFREQ                1000000000
>>>>
>>>>
>>>> @@ -322,6 +322,11 @@ int __init dra7xx_dt_clk_init(void)
>>>>        if (rc)
>>>>            pr_err("%s: failed to configure ABE DPLL!\n", __func__)=
;
>>>>
>>>> +    dpll_ck =3D clk_get_sys(NULL, "dpll_abe_m2x2_ck");
>>>> +    rc =3D clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ * 2);
>>>> +    if (rc)
>>>> +        pr_err("%s: failed to configure ABE DPLL m2x2!\n", __func=
__);
>>>> +
>>>>        dpll_ck =3D clk_get_sys(NULL, "dpll_gmac_ck");
>>>>        rc =3D clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
>>>>        if (rc)
>>>>
>>>
>>
>>
>
