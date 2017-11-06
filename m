From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 05/27] clk: ti: clkctrl: add support for retrying failed
 init
Date: Mon, 6 Nov 2017 09:42:25 +0200
Message-ID: <cba75a28-c057-6338-ff84-4a1378932f0e@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-6-git-send-email-t-kristo@ti.com>
 <20171103170420.GW11011@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171103170420.GW11011@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 03/11/17 19:04, Stephen Boyd wrote:
> On 10/30, Tero Kristo wrote:
>> @@ -508,7 +515,11 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>>   		reg_data++;
>>   	}
>>   
>> -	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
>> +	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
>> +	if (ret == -EPROBE_DEFER)
>> +		ti_clk_retry_init(node, (void *)provider,
> 
> You need the cast? The type of ti_clk_retry_init's second
> parameter should probably be a void pointer instead.

The compiler burps out a warning if there is no cast. I'll change the 
parameter type though, becomes slightly larger patch but that would be 
cleaner.

-Tero

> 
>> +				  (ti_of_clk_init_cb_t)_clkctrl_add_provider);
>> +

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
