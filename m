From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Fri, 23 Mar 2012 16:39:21 +0100
Message-ID: <4F6C9929.6030704@ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com> <4F6C445A.3040103@ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317A6A83@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34626 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab2CWPj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 11:39:26 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317A6A83@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Balbi, Felipe" <balbi@ti.com>

+ Felipe

On 3/23/2012 11:20 AM, Mohammed, Afzal wrote:
> Hi Benoit,
>
> On Fri, Mar 23, 2012 at 15:07:30, Cousson, Benoit wrote:
>>> Final destination aimed for this driver is MFD.
>>
>> Why? Are you sure this is appropriate? This is not really a
>> multifunction device but rather a bus device that can manage multiple
>> kind of devices.
>
>
> Agree, this not an MFD, but can we call this a bus?, as there is
> nothing like GPMC protocol. We considered it logically as MFD&
> proceeded and there was a similar attempt for davinci EMIF [1,2].

But EMIF does not have anything to do in MFD either :-)

What was the feedback for this series?

We discussed that at Linaro connect, but it looks like MFD is becoming 
the place for miscellaneous drivers that we do not know where to put.

Maybe we should introduce a driver/memory/ directory for memory 
controller. At least for EMIF.
In the case of GMPC, it is slightly different because it can handle 
NOR/NAND memory but as well behave like an ISA bus controller for 
Ethernet ISA chip.
But since it can control several devices thanks the chipselects lines it 
has, it behaves like a multi-protocol bus controller.
But in anycase, it does not look like an MFD for my point of view. For 
me a MFD is like a small soc, it does contain several completely 
unrelated block (Power, Audio, GPIO...), but does share some memory 
space / IRQ lines.

Is this the only controller doing that kind of stuff in the kernel so far?

>>>    arch/arm/mach-omap2/gpmc.c             | 1083 +++++++++++++++++++-------------
>>
>> You should probably find the proper location first, move the code and
>> convert to driver.
>> I will let Tony comment but this is the strategy today for all this
>> pseudo driver that should not be in OMAP arch directory anymore.
>
> Please let me know whether you have any suggestions on where GPMC driver
> should live.
>
>>> +		printk(KERN_DEBUG "GPMC CS%d: %-10s* %3d ns, %3d ticks>= %d\n",
>>
>> Nit, but since you are cleaning extensively this code, you should use
>> pr_ macros instead or even dev_ macros since you do have a real driver
>> now with real devices now.
>
> Sure, this was overlooked
>
>>> +struct gpmc_cs_config {
>>> +	u32 config1;
>>> +	u32 config2;
>>> +	u32 config3;
>>> +	u32 config4;
>>> +	u32 config5;
>>> +	u32 config6;
>>> +	u32 config7;
>>> +	int is_valid;
>>> +};
>>
>> OK, so this code was just moved and not removed. Becasue of these big
>> code move, the patch is not super readable. We cannot really see what
>> part is new and what was changed.
>>
>> Maybe you should try to split that in sevarl patches or minized the move.
>
> Yes, I was really in two minds before the coding started. Lot of code in
> this patch has been moved from one place to other, this was done to put
> codes that handle similar things together, so that trees can be made
> visible easily in the forest. And once the patch is applied, as similar
> sections are together, it may be easy to make further changes
>
> If an initial patch just to rearrange the code to have similar section
> together&  then new changes in a another patch, would that be fine?

Well, if this is just comestic, I will even do that after the driver 
conversion. Because if you do that before you will move some piece of 
code that you might completely delete later. So you should fix the code 
first and then potentially, move some part if that will improve the 
readability.

>
>> +static int __init gpmc_clk_init(void)
>>> +{
>>> +	char *ck = NULL;
>>> +
>>> +	if (cpu_is_omap24xx())
>>> +		ck = "core_l3_ck";
>>> +	else if (cpu_is_omap34xx())
>>> +		ck = "gpmc_fck";
>>> +	else if (cpu_is_omap44xx())
>>> +		ck = "gpmc_ck";
>>
>> Please don't do that anymore. The CLKDEV array is done to create alias
>> and avoid this kind of hacks. Moreover you should rely on hwmod for
>> device creation and thus main clock alias will already be populated for
>> free.
>
> There are not added, they are existing code, result of rearranging the
> code. These sections were given not given much importance as these won't
> go into driver. But noted the point you are making.

The issue is that the cpu_is_XXX should not be accessed from outside 
mach-omap2 directory, so you should get rid of that before trying to 
move the gpmc in the XXX location.

Regards,
Benoit
