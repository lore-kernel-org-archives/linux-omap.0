From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM: VExpress: Kconfig: avoid arm6 compatible for ARCH_VEXPRESS
Date: Fri, 23 Aug 2013 15:02:24 +0800
Message-ID: <52170900.5070909@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com> <20130822102210.GF25647@n2100.arm.linux.org.uk> <5216BF16.2080006@asianux.com> <5216C389.9050605@asianux.com> <5216D138.6080802@asianux.com> <5216D31B.9050609@asianux.com> <20130823055152.GY7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:7946 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3HWHDb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 03:03:31 -0400
In-Reply-To: <20130823055152.GY7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/23/2013 01:51 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130822 20:20]:
>> The related error:
>>
>>   /tmp/ccOMIprI.s: Assembler messages:
>>   /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mode `isb '
>>   /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mode `isb '
>>   /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mode `dsb '
>>   /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mode `isb '
>>   /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mode `isb '
>>   /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mode `dsb '
>>   make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>>   make: *** [arch/arm/mach-vexpress] Error 2
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/mach-vexpress/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
>> index 3657954..9b176ce 100644
>> --- a/arch/arm/mach-vexpress/Kconfig
>> +++ b/arch/arm/mach-vexpress/Kconfig
>> @@ -1,5 +1,5 @@
>>  config ARCH_VEXPRESS
>> -	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
>> +	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7 && !CPU_V6 && !CPU_V6K
>>  	select ARCH_REQUIRE_GPIOLIB
>>  	select ARM_AMBA
>>  	select ARM_GIC
> 
> We do support v6 and v7 in the same kernel. So instead of limiting
> what to select in Kconfig, just specify the v7 flags in the Makefile
> for the vexpress .c file with the inline assembly. Look for the
> find command I posted earlier in this thread for examples of specifying 
> flags for a single object in a makefile.
>

I guess what your meaning is like the diff below:

--------------------------------diff begin------------------------------

diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 36ea824..4ebfda4 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
-	-I$(srctree)/arch/arm/plat-versatile/include
+	-I$(srctree)/arch/arm/plat-versatile/include -march=armv7-a
 
 obj-y                                  := v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)      += ct-ca9x4.o

--------------------------------diff end--------------------------------

If my above guess is correct, it can pass compiling without related
warnings, but it will be like below (CONFIG_CPU_32v6 is enabled in
allmodconfig):

  "... -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j ...  -march=armv7-a ..."

Is '-march=armv7-a' conflict with '-D__LINUX_ARM_ARCH__=6' ?


The related command is :

  arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -Os -Wno-maybe-uninitialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fstack-protector -mabi=aapcs-linux -mno-thumb-interwork -funwind-
 tables -marm -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=1024 -Wno-unused-but-se
 t-variabl
e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-debug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -march=armv7-a -W     -D"KBUILD_STR(s)=#s" -D"KBUILD_BA

 

Thanks.
-- 
Chen Gang
