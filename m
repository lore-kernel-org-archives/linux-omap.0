From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: fix dual-registration of uart4_ick
Date: Mon, 5 Oct 2015 15:35:29 +0300
Message-ID: <56126E91.5070201@ti.com>
References: <1443019714-12926-1-git-send-email-ben.dooks@codethink.co.uk>
 <20150923173040.GI23801@atomide.com> <5604DED0.5050403@ti.com>
 <560A8DB0.6020109@codethink.co.uk> <20151005101755.GS23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151005101755.GS23801@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@lists.codethink.co.uk, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/05/2015 01:17 PM, Tony Lindgren wrote:
> * Ben Dooks <ben.dooks@codethink.co.uk> [150929 06:14]:
>> On 25/09/15 06:42, Tero Kristo wrote:
>>> On 09/23/2015 08:30 PM, Tony Lindgren wrote:
>>>> * Ben Dooks <ben.dooks@codethink.co.uk> [150923 07:53]:
>>>>> On the OMAP AM3517 platform the uart4_ick gets registered
>>>>> twice, causing any power managment to /dev/ttyO3 to fail
>>>>> when trying to wake the device up.
>>>>>
>>>>> This solves the following oops:
>>>>>
>>>>> [] Unhandled fault: external abort on non-linefetch (0x1028) at
>>>>> 0xfa09e008
>>>>> [] PC is at serial_omap_pm+0x48/0x15c
>>>>> [] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c
>>>>
>>>> No uart4 on 34xx/35xx, that got introduced with 36xx so:
>>>>
>>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>>
>>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> ---
>>>>>    drivers/clk/ti/clk-3xxx.c | 1 -
>>>>>    1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
>>>>> index 5e12f32..2e7ef1f 100644
>>>>> --- a/drivers/clk/ti/clk-3xxx.c
>>>>> +++ b/drivers/clk/ti/clk-3xxx.c
>>>>> @@ -374,7 +374,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
>>>>>        DT_CLK(NULL, "gpio2_ick", "gpio2_ick"),
>>>>>        DT_CLK(NULL, "wdt3_ick", "wdt3_ick"),
>>>>>        DT_CLK(NULL, "uart3_ick", "uart3_ick"),
>>>>> -    DT_CLK(NULL, "uart4_ick", "uart4_ick"),
>>>>>        DT_CLK(NULL, "gpt9_ick", "gpt9_ick"),
>>>>>        DT_CLK(NULL, "gpt8_ick", "gpt8_ick"),
>>>>>        DT_CLK(NULL, "gpt7_ick", "gpt7_ick"),
>>>
>>> NAK.
>>>
>>> This patch is actually only partially correct, it removes the uart4_ick
>>> alias for omap36xx also. It should be added back to the omap36xx clks
>>> array. Care to post a v2?
>>
>> Thankyou for the feedback. I'll update, but do not have a device to test.
>
> Hmm but isn't that entry already there for 36xx? So this just removes
> a duplicate for 36xx.. Tero, can you please check again, maybe I'm
> confused.

uart4_ick wasn't there, we only had uart4_fck listed for omap36xx.

-Tero

>
> Regars,
>
> Tony
>

