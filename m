From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Wed, 5 Dec 2012 13:11:14 -0600
Message-ID: <50BF9C52.8010202@ti.com>
References: <1354204892-22762-5-git-send-email-zonque@gmail.com> <50B7BE9C.6040506@ti.com> <50B7C677.7090504@ti.com> <50B7C8BE.7050002@gmail.com> <50B7CCB1.6000506@ti.com> <50BF4670.8070602@gmail.com> <20121205171950.GF21682@atomide.com> <50BF83CA.5050007@gmail.com> <20121205174114.GH21682@atomide.com> <50BF9047.6000904@ti.com> <20121205183315.GI21682@atomide.com> <50BF952F.9080406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2LETLr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 14:11:47 -0500
In-Reply-To: <50BF952F.9080406@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, avinashphilip@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 12/05/2012 12:40 PM, Daniel Mack wrote:
> On 05.12.2012 19:33, Tony Lindgren wrote:
>> * Jon Hunter <jon-hunter@ti.com> [121205 10:22]:
>>>
>>> On 12/05/2012 11:41 AM, Tony Lindgren wrote:
>>>> * Daniel Mack <zonque@gmail.com> [121205 09:29]:
>>>>> On 05.12.2012 18:19, Tony Lindgren wrote:
>>>>>>
>>>>>> The plat/cpu.h file will disappear after the merge window, which means
>>>>>> omap2+ related drivers cannot use cpu_is_omap macros.
>>>>>>
>>>>>> For legacy booting systems, this flag should be just passed in the
>>>>>> platform_data from the platform init code. Then device tree can
>>>>>> deal with it based on the compatible flag.
>>>>>>
>>>>>
>>>>> Ok, thanks for explaining.
>>>>>
>>>>> Does that mean this patch series should be postponed until after the
>>>>> merge window and then build upon that change or should we merge the
>>>>> patch in question here as is and then care for the cleanups after the
>>>>> window?
>>>>
>>>> Well to me it seems that you only have cpu_is_omap usage in
>>>> arch/arm/mach-omap2/gpmc-nand.c, which will be OK. Only the code
>>>> under drivers/* needs to be fixed for that. So your patches may
>>>> be OK, but..
>>>
>>> The real problem here is that drivers/mtd/nand/omap2.c is including
>>> plat/gpmc.h and calling a function in arch/arm/mach-omap/gpmc-nand.c. So
>>> although Daniel's patches are not introducing any new problems for
>>> single zImage, they do highlight a problem that we have with the omap2
>>> nand driver that needs to be addressed for single zImage.
>>>
>>> So either we fix this now or after merging Daniel's changes. Either is
>>> fine with me.
>>
>> Ah I see. Yes it would be good to fix that issue first to avoid
>> adding any new blockers for multiplatform build.
> 
> Already fixed by Afzal here:
> 
> https://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=2ef9f3dd
> 
> ... which is also in linux-next.

Great! So we can drop this change.

Cheers
Jon
