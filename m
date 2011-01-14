From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
Date: Fri, 14 Jan 2011 23:58:40 +0000
Message-ID: <20110114235840.GE22505@n2100.arm.linux.org.uk>
References: <20110107161230.GR1198@n2100.arm.linux.org.uk> <20110110185209.GC4957@atomide.com> <20110111231611.GX4957@atomide.com> <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com> <20110113091546.GA24429@n2100.arm.linux.org.uk> <20110113155152.GG4957@atomide.com> <20110113164957.GA28040@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141216040.28621@utopia.booyaka.com> <20110114212027.GD22505@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101141551140.28621@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47927 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1ANX7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 18:59:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101141551140.28621@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

On Fri, Jan 14, 2011 at 04:10:29PM -0700, Paul Walmsley wrote:
> I wonder if, in a similar vein, you would consider adding a CONFIG_CPU_V6 
> plus CONFIG_CPU_V7 config, such as omap2plus_defconfig, into your 
> compile-testing regimen, if one is not already present?
> 
> That would help catch compile problems like the recent CONFIG_SWP_EMULATE 
> one[1].

Such as these?

../build/msm/.config:CONFIG_CPU_V6=y
../build/omap2/.config:CONFIG_CPU_V6=y
../build/omap3/.config:CONFIG_CPU_V7=y
../build/omap3/.config:# CONFIG_SWP_EMULATE is not set
../build/omap4/.config:CONFIG_CPU_V7=y
../build/omap4/.config:# CONFIG_SWP_EMULATE is not set
../build/realview/.config:CONFIG_CPU_V6=y
../build/realview/.config:CONFIG_CPU_V7=y
../build/realview/.config:CONFIG_SWP_EMULATE=y
../build/vexpress/.config:CONFIG_CPU_V7=y
../build/vexpress/.config:CONFIG_SWP_EMULATE=y

So, I already have configs for V7 only+SWP_EMULATE=y, V7 only+SWP_EMULATE=n,
V6 only, V6+V7+SWP_EMULATE=y but not V6+V7+SWP_EMULATE=n

It doesn't appear for me because my toolchain new enough to be broken.

What has been merged into the toolchain (gcc emitting a .armv7 at the
beginning of its assembler output) was a pretty stupid idea as it's
going to break _everything_ out there which has been carefully crafted
to compile for ARMv6 but selectively use ARMv7 instructions.

I am very much of the opinion that this new "feature" needs to be removed
from the toolchain, and it should do as previous versions of the toolchain
does - where the gcc frontend passes the correct architecture flags to
the assembler.

This "feature" will have broken a lot more than just the SWP emulate code
in the kernel - anything which tries to build a kernel crossing several
CPU architectures will hit this failure.

This is what I get from building the realview configuration listed above:

$ emake O=../build/realview/ arch/arm/kernel/
  Using /home/rmk/git/linux-2.6-rmk as source for kernel
  GEN     /home/rmk/git/build/realview/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/rmk/git/linux-2.6-rmk/scripts/checksyscalls.sh
  CC      arch/arm/kernel/elf.o
  AS      arch/arm/kernel/entry-armv.o
  AS      arch/arm/kernel/entry-common.o
  CC      arch/arm/kernel/irq.o
  CC      arch/arm/kernel/process.o
  CC      arch/arm/kernel/ptrace.o
  CC      arch/arm/kernel/return_address.o
  CC      arch/arm/kernel/setup.o
  CC      arch/arm/kernel/signal.o
  CC      arch/arm/kernel/sys_arm.o
  CC      arch/arm/kernel/stacktrace.o
  CC      arch/arm/kernel/time.o
  CC      arch/arm/kernel/traps.o
  CC      arch/arm/kernel/compat.o
  CC      arch/arm/kernel/leds.o
  CC      arch/arm/kernel/armksyms.o
  CC      arch/arm/kernel/module.o
  CC      arch/arm/kernel/sched_clock.o
  CC      arch/arm/kernel/smp.o
  CC      arch/arm/kernel/smp_tlb.o
  CC      arch/arm/kernel/smp_scu.o
  CC      arch/arm/kernel/smp_twd.o
  CC      arch/arm/kernel/sys_oabi-compat.o
  CC      arch/arm/kernel/swp_emulate.o
  CC      arch/arm/kernel/hw_breakpoint.o
  CC      arch/arm/kernel/pmu.o
  CC      arch/arm/kernel/perf_event.o
  CC      arch/arm/kernel/io.o
  AS      arch/arm/kernel/debug.o
  LD      arch/arm/kernel/built-in.o
  AS      arch/arm/kernel/head.o
  CC      arch/arm/kernel/init_task.o
  LDS     arch/arm/kernel/vmlinux.lds

So, as you can see, it builds perfectly fine for me.  GCC 4.3.5,
binutils 2.19.1.  The command used to build swp_emulate.o was:

  arm-linux-gcc -Wp,-MD,arch/arm/kernel/.swp_emulate.o.d  -nostdinc
 -isystem /usr/local/aeabi/lib/gcc/arm-linux/4.3.5/include
 -I/home/rmk/git/linux-2.6-rmk/arch/arm/include -Iinclude 
 -I/home/rmk/git/linux-2.6-rmk/include -include include/generated/autoconf.h 
 -I/home/rmk/git/linux-2.6-rmk/arch/arm/kernel -Iarch/arm/kernel
 -D__KERNEL__ -mlittle-endian  
 -I/home/rmk/git/linux-2.6-rmk/arch/arm/mach-realview/include  
 -I/home/rmk/git/linux-2.6-rmk/arch/arm/plat-versatile/include
 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
 -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
 -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm
 -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux
 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s
 -msoft-float -Uarm -fno-stack-protector -fno-omit-frame-pointer
 -fno-optimize-sibling-calls -Wdeclaration-after-statement -Wno-pointer-sign
 -fno-strict-overflow -Wa,-march=armv7-a   
 -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(swp_emulate)" 
 -D"KBUILD_MODNAME=KBUILD_STR(swp_emulate)"
 -c -o arch/arm/kernel/swp_emulate.o
 /home/rmk/git/linux-2.6-rmk/arch/arm/kernel/swp_emulate.c

So, the reason I don't see it is because I don't build the omap2plus_defconfig
build, as:

# ARMv6k
config CPU_32v6K
        bool "Support ARM V6K processor extensions" if !SMP
        depends on CPU_V6 || CPU_V7
        default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)

OMAP2 prevents the selection of armv6k support.  This is probably a very
bad idea if you want to run the resulting kernel on SMP hardware as it
removes a barrier in the spinlock code and disables the SMP-safe bitops.

The original patch which started turning this off was from the MX3 stuff,
but without explaination.

However, OMAP extended this to disabling the select statement for CPU_32v6K
even if CPU_V7 is set:

 config CPU_V7
        bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB |-       select CPU_32v6K
+       select CPU_32v6K if !ARCH_OMAP2

Arguably, SMP _requires_ CPU_32v6K to be enabled for a safe kernel, and this
patch should not have been merged.
