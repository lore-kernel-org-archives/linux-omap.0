From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
Date: Fri, 23 Aug 2013 10:06:01 +0800
Message-ID: <5216C389.9050605@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com> <20130822102210.GF25647@n2100.arm.linux.org.uk> <5216BF16.2080006@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:9465 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3HWCHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 22:07:02 -0400
In-Reply-To: <5216BF16.2080006@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/23/2013 09:47 AM, Chen Gang wrote:
> On 08/22/2013 06:22 PM, Russell King - ARM Linux wrote:
>> On Thu, Aug 22, 2013 at 12:45:24AM -0700, Tony Lindgren wrote:
>>> * Chen Gang <gang.chen@asianux.com> [130821 01:53]:
>>>> Hello Maintainers:
>>>>
>>>> When build arm with allmodconfig under ubuntu i386 with arm-linux-
>>>> gnueabi-gcc 4.7, as 2.22, it report the errors.
>>>>
>>>> Please help check, thanks (the related config file in attachment).
>>>
>>> It seems that some make flags may need to be specified separately
>>> in some makefiles. See the following for some examples:
>>>
>>> $ find arch/arm -name Makefile | xargs grep -i flags
>>>
>>> I'm getting different errors though, I'm getting:
>>>
>>> arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch
>>>
>>> As probably my compiler does not support the cortex-a9 switch,
>>> I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.
>>
>> The use of -mcpu with -march is not a good idea anyway - you either use
>> -mcpu= or you use -march and -mtune.
>>
>> -mcpu= sets the CPU type, which specifies the instruction architecture
>> (iow, which instructions can be used) and instruction scheduling behaviour.
>>
>> -march= sets the architecture only.  -mtune= sets the instruction
>> scheduling behaviour only.
>>
>> So, that -mcpu= should probably be -mtune=, but if that fails due to
>> unrecognised instructions, the -march= parameter is wrong.
>>
> 
> Hmm... firstly, the root cause is really "the -march= parameter is
> wrong": the correct value is "armv7-a", not "armv6k".
> 
> But in my case:
> 
>   the correct command is "the use of -mcpu with -march ...", and not need "-mcpu= should probably be -mtune=, ..."

Oh, sorry, "-mcpu=cortex-a8" is added by myself manually during
analyzing, it will pass compiling whether have it or not (but suggest
not set it just like you have said).

>   the incorrect command is "or you use -march and -mtune.", and also "-march= sets the architecture only. -mtun= ..."
> 
> 
> Please reference the related command below:
> 
> Correct command (for vexpress_defconfig, can succeed compiling):
> 
>   arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -O2 -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=
 1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/roo
 t/linux-n
ex
> t/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -mcpu=cortex-a8    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/dcscb.o arch/arm/mach-vexpress/dcscb.c
> 
> 
> Incorrect command (for allmodconfig which I originally sent with failure):
> 
>   arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -Os -Wno-maybe-uninitialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fstack-protector -mabi=aapcs-linux -mno-thumb-interwork -funwin
 d-tables -marm -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=1024 -Wno-unused-but-
 set-varia
bl
> e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-debug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -W     -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/.tmp_dcscb.o arch/arm/mach-vexpress/dcscb.c
> 
> 
> 
> 
>> Even so, if gcc 4.3.5 doesn't support cortex-a9 as a CPU type, and we
>> want to support that gcc version, the setting of -mtune needs to be
>> conditionalised.  As it is only a scheduling hint, it's probably fine
>> for it to end up being omitted.
>>
>>
> 
> It sounds a good idea.
> 
> Hello Tony:
> 
>   What about your idea for it ?
> 
> 
> Thanks.
> 


-- 
Chen Gang
