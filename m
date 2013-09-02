From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP4+: Move SRAM data to DT
Date: Mon, 2 Sep 2013 22:33:33 +0530
Message-ID: <5224C4E5.7020002@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com> <1377775391-13103-3-git-send-email-rnayak@ti.com> <521F4BE9.60004@ti.com> <521F4D41.4010303@ti.com> <521F519E.9040204@ti.com> <521F51F6.90405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59274 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826Ab3IBRED (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Sep 2013 13:04:03 -0400
In-Reply-To: <521F51F6.90405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, paul@pwsan.com

On 8/29/2013 7:21 PM, Santosh Shilimkar wrote:
> On Thursday 29 August 2013 09:50 AM, Rajendra Nayak wrote:
>> On Thursday 29 August 2013 07:01 PM, Santosh Shilimkar wrote:
>>> On Thursday 29 August 2013 09:26 AM, Sekhar Nori wrote:
>>>> On 8/29/2013 4:53 PM, Rajendra Nayak wrote:
>>>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>>>> index 22d9f2b..1ba6a77 100644
>>>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>>>> @@ -126,6 +126,11 @@
>>>>>  			pinctrl-single,function-mask = <0x7fff>;
>>>>>  		};
>>>>>  
>>>>> +		ocmcram: ocmcram@40304000 {
>>>>
>>>> This can now be changed to 0x40300000 now that you have moved to
>>>> gen_pool_alloc()?
>>>>
>>> NO.
>>> It won't work on secure devices since first 16 KB is occupied for
>>> default configuration. Its not worth trouble also to handle
>>> secure/non-secure considering the use of SRAM which is actually just
>>> limited to errata. 40304000 will work for both devices.
>>
>> Right. Sekhar, you might have confused because of the existing buggy code
>> in sram.c and sram.h which did this (and is removed in this series)
>>
>> from sram.c
>> -----------
>>  #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
>>  #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
>> -#ifdef CONFIG_OMAP4_ERRATA_I688
>> -#define OMAP4_SRAM_PUB_PA	OMAP4_SRAM_PA
>> -#else
>> -#define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>> -#endif
>> -#define OMAP5_SRAM_PA		0x40300000
>>  
>> from sram.h
>> -----------
>>  #define OMAP2_SRAM_PA		0x40200000
>>  #define OMAP3_SRAM_PA           0x40200000
>> -#ifdef CONFIG_OMAP4_ERRATA_I688
>> -#define OMAP4_SRAM_PA		0x40304000
>> -#define OMAP4_SRAM_VA		0xfe404000
>> -#else
>> -#define OMAP4_SRAM_PA		0x40300000
>> -#endif
>>
>> I am not sure where the checks for CONFIG_OMAP4_ERRATA_I688
>> came in from, but these are done, like Santosh said, to handle
>> secure and non-secure sram across GP and HS devices and in
>> no way related to handling errata I688.
>>
> The check was to ensure that with errata enabled, we don't care
> about first 16 KB ;-)

Hi Rajendra, thanks for the explanation. Other devices like AM437x which
have HS variants might need such adjustment too. It will be nice to
check that.

Thanks,
Sekhar
