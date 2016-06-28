From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v3 03/10] input: tps65218-pwrbutton: Add
 platform_device_id table
Date: Tue, 28 Jun 2016 13:13:52 +0530
Message-ID: <57722AB8.8020208@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
 <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
 <20160628064948.GB6720@dell> <57721F71.5010700@ti.com>
 <20160628074110.GH6720@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160628074110.GH6720@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 28 June 2016 01:11 PM, Lee Jones wrote:
> On Tue, 28 Jun 2016, Keerthy wrote:
>
>>
>>
>> On Tuesday 28 June 2016 12:19 PM, Lee Jones wrote:
>>> On Tue, 28 Jun 2016, Keerthy wrote:
>>>
>>>> platform_device_id table is needed for adding the tps65218-pwrbutton
>>>> module to the mfd_cell array.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>   drivers/input/misc/tps65218-pwrbutton.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
>>>> index 2bba8de..a0cb7d2 100644
>>>> --- a/drivers/input/misc/tps65218-pwrbutton.c
>>>> +++ b/drivers/input/misc/tps65218-pwrbutton.c
>>>> @@ -113,12 +113,19 @@ static const struct of_device_id of_tps65218_pwr_match[] = {
>>>>   };
>>>>   MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
>>>>
>>>> +static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
>>>> +	{ "tps65218-pwrbutton", },
>>>> +	{ /* sentinel */ }
>>>> +}
>>>
>>> Missing ';'.  Did you build test this?
>>
>> Oops sorry for the mess. Yes i built and booted. While reviewing and just
>> before sending i have accidentally deleted. I will send a v4 in a bit. I
>> will send v4 of this patch.
>>
>> I just checked now. It somehow compiles silently even with the ';' missing!
>> I will send a v4.
>
> Are you sure this driver is enable in the CONFIG?

Yes! I think the MACRO Below covers up for the missing ';' and hence 
went unnoticed :-/

>
>>>> +MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
>>>> +
>>>>   static struct platform_driver tps65218_pwron_driver = {
>>>>   	.probe	= tps65218_pwron_probe,
>>>>   	.driver	= {
>>>>   		.name	= "tps65218_pwrbutton",
>>>>   		.of_match_table = of_tps65218_pwr_match,
>>>>   	},
>>>> +	.id_table = tps65218_pwrbtn_id_table,
>>>>   };
>>>>   module_platform_driver(tps65218_pwron_driver);
>>>>
>>>
>
