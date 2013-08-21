From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add new bindings for OMAP
Date: Wed, 21 Aug 2013 15:12:18 +0200
Message-ID: <5214BCB2.5020302@baylibre.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com> <1376983966-16490-3-git-send-email-rnayak@ti.com> <20130821074514.GU7656@atomide.com> <52147E95.5000606@ti.com> <20130821085330.GH7656@atomide.com> <521486E1.6030009@ti.com> <20130821122327.GI7656@atomide.com> <5214B50D.3050703@ti.com> <20130821125146.GJ7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130821125146.GJ7656@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 21/08/2013 14:51, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130821 05:46]:
>> On Wednesday 21 August 2013 05:53 PM, Tony Lindgren wrote:
>>> * Rajendra Nayak <rnayak@ti.com> [130821 02:29]:
>>>> On Wednesday 21 August 2013 02:23 PM, Tony Lindgren wrote:
>>>>>
>>>>> Or you could also have various bus specific bindings for the ocp
>>>>> with lists of phandles?
>>>>>
>>>>> ocp {
>>>>> 	reg = <...>;
>>>>> 	interrupts = <...>;
>>>>> 	ti,reset-on-init = <&module1, &module2>;
>>>>> 	...
>>>>> };
>>>>>
>>>>> Or something similar.
>>>>
>>>> The only problem I see with this is that some of these modules could be
>>>> board specific ones and need to be part of the board dts files, like
>>>> some boards which have PMIC power switch hooked up to some gpio etc.
>>>> So there could be some SoC specific modules (like emif/gpmc on OMAPs)
>>>> and some which depend on how the boards are designed.
>>>
>>> You can still override the ocp entry in the board specific .dts file.
>>> Would probably be a lot easier than to override each module separately
>>> in the board specific .dts file.
>>
>> So, If I understand this right we would have the dt entries
>> something like,
>>
>> omap4.dtsi
>> ------
>> ocp {
>> 	reg = <...>;
>> 	interrupts = <...>;
>> 	ti,no-reset-on-init = <&emif1, &emif2, &gpmc>;
>> 	...
>> };
>>
>> omap4-panda-es.dts
>> ------
>> ocp {
>> 	ti,no-reset-on-init = <&emif1, &emif2, &gpmc, &gpio4>;
>> 	...
>> };
>>
>> Is it that, or you suggesting we can _append_ the soc list of
>> modules with board specific modules, which I am not sure if its
>> possible.
>
> Yes I think the board specific entry just overrides the .dtsi
> entry.

That's the issue of using a single attribute with a list. You cannot add 
or remove an entry. That's why I think it is better to stick to a per 
device attribute.

Moreover, in term of SW, this is managed at device level today. I'm not 
convince it will make sense to move that to the OCP level for the moment.

Even if we consider that in the future an omap-ocp bus driver will 
handle most of the PM/reset glue managed today by hwmod, it will still 
be a per device attribute. The bus driver, being the parent of the 
device, will anyway be able to retrieve the information at device level 
if needed.

Regards,
Benoit


