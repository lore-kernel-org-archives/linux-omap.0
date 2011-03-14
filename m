From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
Date: Mon, 14 Mar 2011 20:34:39 +0100
Message-ID: <4D7E6DCF.1060703@openelec.tv>
References: <87k4g6eakw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail04.solnet.ch ([212.101.4.138]:56894 "EHLO mail04.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab1CNTem (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 15:34:42 -0400
In-Reply-To: <87k4g6eakw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Am 11.03.2011 01:59, schrieb Kevin Hilman:
> Dave Martin (5):
>        ARM: omap4: Provide do_wfi() for Thumb-2
>        ARM: omap4: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
>        ARM: omap3: Remove hand-encoded SMC instructions

"ARM: omap3: Remove hand-encoded SMC instructions" fails for me with:

/home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/toolchain/bin/arm-openelec-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-omap2/.sleep34xx.o.d  -nostdinc -isystem /home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/toolchain/lib/gcc/arm-openelec-linux-gnueabi/4.5.2/include -I/home/stephan/projects/openelec/build.OpenELEC-panda.arm-devel/linux-2.6.38-rc8/arch/arm/include -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -mthumb -Wa,-mimplicit-it=always -Wa,-mno-warn-deprecated -Wa,-mthumb -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2     -Wa,-march=armv7-a   -c -o arch/arm/mach-o
 map2/sleep34xx.o arch/arm/mach-omap2/sleep34xx.S
arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
arch/arm/mach-omap2/sleep34xx.S:149: Error: selected processor does not support ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:416: Error: selected processor does not support ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:427: Error: selected processor does not support ARM mode `smc #1'
arch/arm/mach-omap2/sleep34xx.S:452: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/sleep34xx.S:458: Error: selected processor does not support ARM mode `smc #0'
arch/arm/mach-omap2/sleep34xx.S:463: Error: selected processor does not support ARM mode `smc #0'
make[2]: *** [arch/arm/mach-omap2/sleep34xx.o] Error 1
make[1]: *** [arch/arm/mach-omap2] Error 2


replacing in arch/arm/mach-omap2/Makefile:

AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-a

to:

AFLAGS_sleep24xx.o                      :=-Wa,-march=armv6
AFLAGS_sleep34xx.o                      :=-Wa,-march=armv7-a$(plus_sec)

helps compiling (see also: https://patchwork.kernel.org/patch/369681/)

thanks

Stephan




