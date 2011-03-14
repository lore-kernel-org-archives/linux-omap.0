From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
Date: Mon, 14 Mar 2011 20:51:28 +0100
Message-ID: <4D7E71C0.4010808@openelec.tv>
References: <87k4g6eakw.fsf@ti.com> <4D7E6DCF.1060703@openelec.tv> <20110314193848.GI7258@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060006030104060701080605"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail01.solnet.ch ([212.101.4.135]:58811 "EHLO mail01.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab1CNTvb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 15:51:31 -0400
In-Reply-To: <20110314193848.GI7258@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is a multi-part message in MIME format.
--------------060006030104060701080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 14.03.2011 20:38, schrieb Tony Lindgren:
> * Stephan Raue<mailinglists@openelec.tv>  [110314 12:32]:
>> Hi,
>>
>> Am 11.03.2011 01:59, schrieb Kevin Hilman:
>>> Dave Martin (5):
>>>        ARM: omap4: Provide do_wfi() for Thumb-2
>>>        ARM: omap4: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
>>>        ARM: omap3: Remove hand-encoded SMC instructions
>> "ARM: omap3: Remove hand-encoded SMC instructions" fails for me with:
>>
>> /home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/toolchain/bin/arm-openelec-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-omap2/.sleep34xx.o.d  -nostdinc -isystem /home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/toolchain/lib/gcc/arm-openelec-linux-gnueabi/4.5.2/include -I/home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/linux-2.6.38-rc8/arch/arm/include -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -mthumb -Wa,-mimplicit-it=always -Wa,-mno-warn-deprecated -Wa,-mthumb -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2     -Wa,-march=armv7-a   -c -o arch/arm/mac
 h-omap2/sleep34xx.o arch/arm/mach-omap2/sleep34xx.S
>> arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
>> arch/arm/mach-omap2/sleep34xx.S:149: Error: selected processor does not support ARM mode `smc #1'
>> arch/arm/mach-omap2/sleep34xx.S:416: Error: selected processor does not support ARM mode `smc #1'
>> arch/arm/mach-omap2/sleep34xx.S:427: Error: selected processor does not support ARM mode `smc #1'
>> arch/arm/mach-omap2/sleep34xx.S:452: Error: selected processor does not support ARM mode `smc #0'
>> arch/arm/mach-omap2/sleep34xx.S:458: Error: selected processor does not support ARM mode `smc #0'
>> arch/arm/mach-omap2/sleep34xx.S:463: Error: selected processor does not support ARM mode `smc #0'
>> make[2]: *** [arch/arm/mach-omap2/sleep34xx.o] Error 1
>> make[1]: *** [arch/arm/mach-omap2] Error 2
>>
>>
>> replacing in arch/arm/mach-omap2/Makefile:
>>
>> AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
>> AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-a
>>
>> to:
>>
>> AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
>> AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-a$(plus_sec)
>>
>> helps compiling (see also: https://patchwork.kernel.org/patch/369681/)
> Care to post a patch for this and mention your compiler version too?
>
> Tony
patch attached.

i am using http://gitorious.org/linux-omap-dss2/linux with gcc-4.5.2, 
binutils-2.21

thanks

Stephan

--------------060006030104060701080605
Content-Type: text/x-patch;
 name="linux-2.6.38-rc8-321-linux_omap_dss2_fix_SMC_instructions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="linux-2.6.38-rc8-321-linux_omap_dss2_fix_SMC_instructions.pa";
 filename*1="tch"

diff -Naur linux-2.6.38-rc8/arch/arm/mach-omap2/Makefile linux-2.6.38-rc8.patch/arch/arm/mach-omap2/Makefile
--- linux-2.6.38-rc8/arch/arm/mach-omap2/Makefile	2011-03-14 20:38:21.039926899 +0100
+++ linux-2.6.38-rc8.patch/arch/arm/mach-omap2/Makefile	2011-03-14 20:39:01.679108209 +0100
@@ -68,7 +68,7 @@
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
+AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG

--------------060006030104060701080605--
