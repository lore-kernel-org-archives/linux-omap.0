From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH] pinctrl: single: Remove invalid message
Date: Mon, 18 Dec 2017 08:21:16 +0800
Message-ID: <774cac82-775c-134d-66de-3e8964808259@linaro.org>
References: <20171214165115.27150-1-tony@atomide.com>
 <c51cd2c7-3d36-3dc5-11f8-06c162ca3639@linaro.org>
 <20171217160740.GJ3875@atomide.com>
Reply-To: haojian.zhuang@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171217160740.GJ3875@atomide.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2017/12/18 0:07, Tony Lindgren wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [171217 05:43]:
>> On 2017/12/15 0:51, Tony Lindgren wrote:
>>> Pinctrl single should just show how many pins were found, the physical
>>> address is already in the dev information. So let's remove the wrong
>>> information that claims to show the physical address but really prints
>>> a virtual address that is now hashed.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> ---
>>>    drivers/pinctrl/pinctrl-single.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>>> --- a/drivers/pinctrl/pinctrl-single.c
>>> +++ b/drivers/pinctrl/pinctrl-single.c
>>> @@ -1774,8 +1774,7 @@ static int pcs_probe(struct platform_device *pdev)
>>>    			dev_warn(pcs->dev, "initialized with no interrupts\n");
>>>    	}
>>> -	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
>>> -		 pcs->desc.npins, pcs->base, pcs->size);
>>> +	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
>>>    	return pinctrl_enable(pcs->pctl);
>>>
>> Hi Tony,
>>
>> If there's only one pinctrl region in SoC, it's fine to remove the pa part.
>> But there're always multiple pinctrl regions in Hisilicon SoCs. It causes
>> multiple pinctrl register bases are used. Will it cause debug information
>> harder to read when pa parts are removed?
> 
> I doubt as for years now we've been printing out the va instead of pa
> and so far nobody noticed :) We still get the real device pa with the
> dev_info, size and number of pins.
> 

OK

Regards
Haojian

