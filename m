From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
Date: Tue, 30 Jul 2013 18:29:30 +0530
Message-ID: <51F7B8B2.90006@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-4-git-send-email-rnayak@ti.com> <51F7B100.2020600@ti.com> <51F7B3E0.9020005@ti.com> <51F7B483.8060908@ti.com> <51F7B62C.9010407@ti.com> <51F7B850.5090803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab3G3M77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 08:59:59 -0400
In-Reply-To: <51F7B850.5090803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com

On Tuesday 30 July 2013 06:27 PM, Nishanth Menon wrote:
> On 07/30/2013 07:48 AM, Rajendra Nayak wrote:
>> On Tuesday 30 July 2013 06:11 PM, Nishanth Menon wrote:
>>> On 07/30/2013 07:38 AM, Rajendra Nayak wrote:
>>>> On Tuesday 30 July 2013 05:56 PM, Nishanth Menon wrote:
>>>>> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>>>>>> From: R Sricharan <r.sricharan@ti.com>
>>>>> [...]
>>>>>>     # Clock framework
>>>>>>     obj-$(CONFIG_ARCH_OMAP2)        += $(clock-common) clock2xxx.o
>>>>>> @@ -181,6 +187,8 @@ obj-$(CONFIG_SOC_AM33XX)        += $(clock-common) dpll3xxx.o
>>>>>>     obj-$(CONFIG_SOC_AM33XX)        += cclock33xx_data.o
>>>>>>     obj-$(CONFIG_SOC_OMAP5)            += $(clock-common)
>>>>>>     obj-$(CONFIG_SOC_OMAP5)            += dpll3xxx.o dpll44xx.o
>>>>>> +obj-$(CONFIG_SOC_DRA7XX)        += $(clock-common)
>>>>>> +obj-$(CONFIG_SOC_DRA7XX)        += dpll3xxx.o dpll44xx.o
>>>>>>
>>>>>
>>>>> are these in sync with DRA7 support being introduced for clock data in [1]?
>>>>
>>>> I don't want to have a dependency on those patches since I am not sure of them
>>>> making it into 3.12.
>>>
>>> Then we have to undo these changes again in clock data support. the chip wont bootup anyways without clock data information, so why not try and keep the changes that Tero is doing independent of these changes?
>>
>> I still have something with clock data information which boots which I am maintaining out of tree till the clock movement to DT is sorted out.
>> Maybe what you are suggesting is quite trivial and I am unable to understand. Are you suggesting we do no compile $(clock-common) and the
>> dpll files for DRA7? Is that what you are worried we might have to revert?
> 
> yes - lets just drop that change. that allows what ever alignment we have for clock data/driver to handle it appropriately. IMHO, could also keeps your series independent from Tero's series.

I can drop those. no issues.

> 
>>>
>>>>
>>>>>
>>>>>
>>>>> [1] http://marc.info/?l=linux-omap&m=137456411706971&w=2
>>>>>
>>>>
>>>
>>>
>>
> 
> 

