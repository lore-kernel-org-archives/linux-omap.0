From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
 and dra7-evm board
Date: Tue, 30 Jul 2013 07:46:21 -0500
Message-ID: <51F7B59D.5080607@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-9-git-send-email-rnayak@ti.com> <51F7B1E0.4060800@ti.com> <51F7B477.9010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40653 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3G3Mqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 08:46:46 -0400
In-Reply-To: <51F7B477.9010701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com

On 07/30/2013 07:41 AM, Rajendra Nayak wrote:
> On Tuesday 30 July 2013 06:00 PM, Nishanth Menon wrote:
>> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>>> From: R Sricharan <r.sricharan@ti.com>
[...]
>>> +        mcspi4: spi@480ba000 {
>>> +            compatible = "ti,omap4-mcspi";
>>> +            reg = <0x480ba000 0x200>;
>>> +            interrupts = <0 48 0x4>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            ti,hwmods = "mcspi4";
>>> +            ti,spi-num-cs = <1>;
>>> +            dmas = <&sdma 70>, <&sdma 71>;
>>> +            dma-names = "tx0", "rx0";
>>> +        };
>>> +    };
>>> +};
>>>
>> ref: [1], we discussed that we should now be able to introduce all instances of h/w blocks into the dra7.dts. Further, considering [2]
>
> hmm, thats a long discussion on crossbar driver that [1] points to. Do you want to summarize what you mean by 'introduce all instances of h/w blocks'

I recommend reading the last few emails on the thread about how we could 
do this with pinctrl. unfortunately, this patch is not informative 
enough to indicate that not all instances of the potential IP blocks are 
listed here.

>
>> would you not want to follow "status = disabled" for all modules by default and enable required modules in board file, so that we dont have to respin this yet again?
>
> Well, I was just following the convention of whats already followed on existing OMAPs. See [3] for some views on these.

DRA7 case, I would not think it makes sense due to the number of product 
variants being done, not all will use the same set. Further, rationale 
for DRA7 and my suggestion for Grant's option (1) is mainly because the 
product variants will require more dtsis rather than board files using 
the product variants use just the necessary modules from a common dtsi. 
Makes support of variants like OMAP57xx etc trivial and constrainted to 
board file usage, rather than spinning off new dtsis.

>
>>
>>
>> [1] http://marc.info/?t=137416599400001&r=1&w=2
>> [2] http://marc.info/?l=linux-omap&m=137510358229479&w=2
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086297.html
>


-- 
Regards,
Nishanth Menon
