From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 03/27] clk: ti: add support for clkctrl aliases
Date: Mon, 6 Nov 2017 09:46:41 +0200
Message-ID: <b8090db5-48e7-07a2-223c-ead8662d36cb@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-4-git-send-email-t-kristo@ti.com>
 <20171103152703.GU11011@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171103152703.GU11011@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 03/11/17 17:27, Stephen Boyd wrote:
> On 10/30, Tero Kristo wrote:
>> +		}
>> +
>> +		if (num_args && clkctrl_nodes_missing)
>> +			continue;
>> +
>> +		node = of_find_node_by_name(NULL, buf);
>> +		if (num_args)
>> +			node = of_find_node_by_name(node, "clk");
>>   		clkspec.np = node;
>> +		clkspec.args_count = num_args;
>> +		for (i = 0; i < num_args; i++) {
>> +			ret = kstrtoint(tags[i], i ? 10 : 16, clkspec.args + i);
> 
> Is this some sort of DT checker?

Not really, it just parses a string of format:

<clkctrl_provider>:<hex-offset>:<bit-offset>.

... so that it can find a matching clock. Needed temporarily for 
omap_hwmod backwards compatibility. This piece can be removed once hwmod 
is gone.

I can add some comment along these lines to the code if you want.

-Tero

> 
>> +			if (ret) {
>> +				pr_warn("Bad tag in %s at %d: %s\n",
>> +					c->node_name, i, tags[i]);
>> +				return;
>> +			}
>> +		}
>>   		clk = of_clk_get_from_provider(&clkspec);
>>   
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
