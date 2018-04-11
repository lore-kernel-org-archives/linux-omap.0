From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [BUG] Fix drivers/memory O= build
Date: Wed, 11 Apr 2018 16:17:34 -0500
Message-ID: <d290fb17-290a-03ad-9e29-08d43420993c@ti.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
 <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
 <20180406185505.GD10990@n2100.armlinux.org.uk>
 <CAK7LNARbST+-oy-J9B2Q2vSp0nhnn9gqOnT7urZdjQZhSpYB-Q@mail.gmail.com>
 <20180407133817.GE10990@n2100.armlinux.org.uk>
 <ba6087c5-c69e-1adc-9d9d-0ef5b19fb30e@ti.com>
 <CAK7LNASOs9B0qOGfRthh-+Aca_+wJjKmLcXpoFO0OrHvva=YdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK7LNASOs9B0qOGfRthh-+Aca_+wJjKmLcXpoFO0OrHvva=YdA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>, arm-soc@armlinux.org.uk, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,
On 04/10/2018 10:01 AM, Masahiro Yamada wrote:
> 2018-04-10 1:05 GMT+09:00 Dave Gerlach <d-gerlach@ti.com>:
>> Hi,
>> On 04/07/2018 08:38 AM, Russell King - ARM Linux wrote:
>>> On Sat, Apr 07, 2018 at 11:55:22AM +0900, Masahiro Yamada wrote:
>>>> 2018-04-07 3:55 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
>>>>> On Fri, Apr 06, 2018 at 11:45:01AM -0700, Santosh Shilimkar wrote:
>>>>>> On 4/6/2018 9:46 AM, Tony Lindgren wrote:
>>>>>>> * Russell King - ARM Linux <linux@armlinux.org.uk> [180406 03:27]:
>>>>>>>> When building a kernel with split object directories, the following
>>>>>>>> failure occurs:
>>>>>>>>
>>>>>>>> .../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
>>>>>>>> compilation terminated.
>>>>>>>> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
>>>>>>>> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
>>>>>>>> .../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
>>>>>>>> make[1]: *** [arch/arm/mach-omap2] Error 2
>>>>>>>>
>>>>>>>> This prevents any kernel being built that includes decending into
>>>>>>>> arch/arm/mach-omap2 with split object directories.
>>>>>>>>
>>>>>>>> This is a regression.
>>>>>>>
>>>>>>> Dave, I presume you're looking into this already?
>>>>>>>
>>>>>> Fix is already posted by 'Anders Roxell <anders.roxell@linaro.org>'
>>>>>> You are copied on the email Tony.
>>>>>
>>>>> Arnd also has a fix for it as well, which moves emif-asm-offsets.s
>>>>> into include/generated, as that will always exist prior to these
>>>>> rules being invoked.  Arnd's passing it through his randconfig
>>>>> builder before publishing it.
>>>>
>>>>
>>>> I do not like this idea.
>>>>
>>>> Not sure exactly what Arnd is trying to do,
>>>> but the same file should not be touched from multiple points
>>>> in case Kbuild descends into mach-omap2/ and memory/ at the same time.
>>>>
>>>>
>>>> I recommend to put copies in each directory:
>>>>
>>>> arch/arm/mach-omap2/emif-asm-offsets.h
>>>> drivers/memory/ti-emif-asm-offsets.h
>>>>
>>>>
>>>> If you want me to send a patch,
>>>> I will give it a try.
>>>
>>> Or we try and find another way around this.
>>>
>>> The original idea was to start throwing platform specific (iow, stuff in
>>> arch/arm/mach-omap2/) includes into arch/arm/kernel/asm-offsets.c.  I
>>> objected to that, and suggested that the generic infrastructure for doing
>>> the asm-offsets thing should be used to generate an architecture specific
>>> header.
>>>
>>> Then it turns out that files in both arch/arm/mach-omap2 and drivers/memory
>>> need these constants, and TI proposed the existing method.
>>>
>>> Obviously, all the right people reviewed it and approved it, which is why
>>> it's now in mainline, but unfortunately it doesn't actually work, and
>>> breaks my kernel builds!
>>>
>>
>> A solution that I see is to allow pm-asm-offsets to just include the macros that
>> would be defined by emif-asm-offsets in the header generated by pm-asm-offsets.
>> This way there is no need to introduce the arch -> drivers build dependency that
>> is causing our issue, each driver generates its own header with everything it
>> needs included. I'll move the actual macro definitions for emif-asm-offsets.c
>> into a header and then by including them in both emif-asm-offsets and
>> pm-asm-offsets we get all macro definitions in both places with them still being
>> defined only in one location.
>>
>> I've inlined the changes below. I will send a proper split up series if it's
>> considered acceptable.
>>
>> Regards,
>> Dave
>>
>> 8< ----------------------
>> From 7350c7caa773d7235ddb21013bd039a16cb6d156 Mon Sep 17 00:00:00 2001
>> From: Dave Gerlach <d-gerlach@ti.com>
>> Date: Mon, 9 Apr 2018 10:56:59 -0500
>> Subject: [PATCH] RFC: Fix build when using split object directories
>>
>> The sleep33xx and sleep43xx files should not depend on a header file
>> generated in drivers/memory. Remove this dependency and instead generate
>> the macros needed as part of pm-asm-offsets.c to avoid complicating the
>> build.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  arch/arm/mach-omap2/Makefile         |  7 +---
>>  arch/arm/mach-omap2/pm-asm-offsets.c |  3 ++
>>  arch/arm/mach-omap2/sleep33xx.S      |  1 -
>>  arch/arm/mach-omap2/sleep43xx.S      |  1 -
>>  drivers/memory/emif-asm-offsets.c    | 72 +---------------------------------
>>  include/linux/ti-emif-sram.h         | 75 ++++++++++++++++++++++++++++++++++++
>>  6 files changed, 81 insertions(+), 78 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index 4603c30fef73..1257810cdb80 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -243,8 +243,5 @@ arch/arm/mach-omap2/pm-asm-offsets.s:
>> arch/arm/mach-omap2/pm-asm-offsets.c
>>  include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
>>         $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
>>
>> -# For rule to generate ti-emif-asm-offsets.h dependency
>> -include drivers/memory/Makefile.asm-offsets
>> -
>> -arch/arm/mach-omap2/sleep33xx.o: include/generated/ti-pm-asm-offsets.h
>> include/generated/ti-emif-asm-offsets.h
>> -arch/arm/mach-omap2/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
>> include/generated/ti-emif-asm-offsets.h
>> +arch/arm/mach-omap2/sleep33xx.o: include/generated/ti-pm-asm-offsets.h
>> +arch/arm/mach-omap2/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
> 
> 
> Nit:
> You are touching these two lines.
> You can also describe it like this:
> 
> $(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
> 
> 
> 
> I prefer putting the local header, ti-pm-asm-offsets.h,
> into arch/arm/mach-omap2/, but that is a different issue.
> 
> So, I am fine with this.
> 
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> 

Thanks, I have sent a patch with the nit above changed and slightly more info in
the commit message and added the Ack from Tony and Reviewed-by from above.

https://lkml.org/lkml/2018/4/11/1281

Regards,
Dave
