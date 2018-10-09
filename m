From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
Date: Tue, 9 Oct 2018 17:04:14 -0500
Message-ID: <f9dfd775-0679-f82b-b53b-065e9f7be7c7@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
 <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
 <20181009203017.GM5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009203017.GM5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/09/2018 03:30 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181009 20:10]:
>>
>>
>> On 10/09/2018 09:40 AM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>>>> +Examples:
>>>> +	phy_gmii_sel: phy-gmii-sel {
>>>> +		compatible = "ti,am3352-phy-gmii-sel";
>>>> +		syscon-scm = <&scm_conf>;
>>>> +		#phy-cells = <2>;
>>>> +	};
>>>
>>> Now that this driver can live in it's proper place in the
>>
>> right
>>
>>> dts, you may want to consider just using standard reg
>>> property for it instead of the syscon-scm. And also get
>>> rid of the syscon reads and writes.
>>
>> Could you help clarify how to get syscon in this case?
>> syscon_node_to_regmap(dev->parent->of_node)?
> 
> Hmm I don't think you need syscon at all now. You can just
> ioremap the register(s) and use readl/writel and that's it.
> Or use regmap without syscon if you prefer that.

It will overlap with already remapped SCM syscon and i'd like to avoid this.
+ it seems common practice to use syscon for devices/drivers which are
child to SCM node - makes overall system more consistent.

> 
> The ioremap in this case should be hitting cached ranges
> anyways, so no extra overhead there.
> 
>> Also, there are could be more then one gmii_sel registers in SCM in the future,
>> so I hidden offsets in of_match data.
>> As result, "reg" not needed at all now.
> 
> But then you have to patch driver for various SoCs
> instead of just configuring the standard reg property
> in the dts file :)

Problem is that they are not guarantee to be standard between SoC's families 
(number of regs and fields placement), as result it might require to change
driver any way for various SoCs to handle properly new fields placement.

I prefer to fix driver then fight with DT ;) as it's static for SoC family
and need to be changed only once when new SoC family introduced.

-- 
regards,
-grygorii
