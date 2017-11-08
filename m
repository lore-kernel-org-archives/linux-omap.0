From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] rtc: omap: Support scratch registers
Date: Wed, 8 Nov 2017 13:36:15 +0530
Message-ID: <898f67e7-5d65-9067-f40d-0d80462324d5@ti.com>
References: <20171031162731.27019-1-alexandre.belloni@free-electrons.com>
 <600fd106-9f79-0f5a-a2fd-e6b067785c17@ti.com>
 <4741d4c7-d6f7-ecdb-1eed-1293175f38d9@ti.com>
 <9a383f74-e049-885b-4705-93968f4c75d4@ti.com>
 <20171108062738.cml7qaek324rvc4e@piout.net>
 <775d3cfc-95ca-1dff-d146-64efbdd71e1f@ti.com>
 <20171108071612.65wrw7mhoip55lia@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108071612.65wrw7mhoip55lia@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, Linux OMAP List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 November 2017 12:46 PM, Alexandre Belloni wrote:
> On 08/11/2017 at 12:38:05 +0530, Keerthy wrote:
>>
>>
>> On Wednesday 08 November 2017 11:57 AM, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 08/11/2017 at 11:30:45 +0530, Keerthy wrote:
>>>>>>> +static int omap_rtc_scratch_read(void *priv, unsigned int offset, void *_val,
>>>>>>> +				 size_t bytes)
>>>>>>> +{
>>>>>>> +	struct omap_rtc	*rtc = priv;
>>>>>>> +	u32 *val = _val;
>>>>>>> +	int i;
>>>>>>> +
>>>>>>> +	for (i = 0; i < bytes / 4; i++)
>>>>>>> +		val[i] = rtc_readl(rtc,
>>>>>>> +				   OMAP_RTC_SCRATCH0_REG + offset + (i * 4));
>>>>
>>>> Can the offset be the Scratch register number instead of bytes offset?
>>>> More intuitive to me.
>>>>
>>>> So that one can request using offset as 0, 1, 2 instead of 0, 4, 8?
>>>>
>>>
>>> Well, the offset is coming from the nvmem core, itself getting it from
>>> the Linux file API (and it is in bytes). However, you have the guarantee
>>> that it will be aligned on a word, see:
>>> http://elixir.free-electrons.com/linux/latest/source/drivers/nvmem/core.c#L88
>>
>> Okay Alexandre. Thanks for clarifying. Looks good to me.
>> I have tested on AM437X-GP-EVM.
>>
> 
> If needed, you can define nvmem cells (and I guess that is what you
> want):
> http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/nvmem/nvmem.txt

With this patch we cannot still use nvmem_device_write and
nvmem_device_read as the nvmem_device is still not registered.

How can a driver write to scratch pad registers? Should we be calling
nvmem_register in the probe?

> 
> 
