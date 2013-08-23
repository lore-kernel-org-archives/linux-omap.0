From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] ARM: VExpress: Makefile: add armv7 flags for inline
 assmembly code compiling
Date: Fri, 23 Aug 2013 16:12:40 +0800
Message-ID: <52171978.7080805@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com>
 <20130822102210.GF25647@n2100.arm.linux.org.uk>
 <5216BF16.2080006@asianux.com> <5216C389.9050605@asianux.com>
 <5216D138.6080802@asianux.com> <5216D31B.9050609@asianux.com>
 <20130823055152.GY7656@atomide.com> <52170900.5070909@asianux.com>
 <52170C15.5010907@asianux.com> <52171720.4050501@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52171720.4050501@asianux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/23/2013 04:02 PM, Chen Gang wrote:
> When vexpress kernel is compiled for v6, it still can support armv7
> instructions (hardware still support), so need let compiler know about
> it for related inline assembly code, or compiling will fail.
> 

Hmm... need change "compiled for v6, it still can" to "compiled for both
v6 and v7, it of cause can".

Thanks.

> The related failure command:
> 
>   arm-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-vexpress/.dcscb.o.d  -nostdinc -isystem /usr/lib/gcc/arm-linux-gnueabi/4.7/include -I/root/linux-next/arch/arm/include -Iarch/arm/include/generated  -Iinclude -I/root/linux-next/arch/arm/include/uapi -Iarch/arm/include/generated/uapi -I/root/linux-next/include/uapi -Iinclude/generated/uapi -include /root/linux-next/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Werror=implicit-int -Werror=strict-prototypes -Os -Wno-maybe-uninitialized -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs -mno-sched-prolog -fstack-protector -mabi=aapcs-linux -mno-thumb-interwork -funwin
 d-tables -marm -D__LINUX_ARM_ARCH__=6 -march=armv6k -mtune=arm1136j-s -msoft-float -Uarm -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=1024 -Wno-unused-but-
 set-varia
bl
> e -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -femit-struct-debug-baseonly -fno-var-tracking -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -I/root/linux-next/arch/arm/mach-vexpress/include -I/root/linux-next/arch/arm/plat-versatile/include -W     -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dcscb)"  -D"KBUILD_MODNAME=KBUILD_STR(dcscb)" -c -o arch/arm/mach-vexpress/.tmp_dcscb.o arch/arm/mach-vexpress/dcscb.c
> 
> The related error:
> 
>   /tmp/ccOMIprI.s: Assembler messages:
>   /tmp/ccOMIprI.s:507: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:513: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:514: Error: selected processor does not support ARM mode `dsb '
>   /tmp/ccOMIprI.s:584: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:590: Error: selected processor does not support ARM mode `isb '
>   /tmp/ccOMIprI.s:591: Error: selected processor does not support ARM mode `dsb '
>   make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>   make: *** [arch/arm/mach-vexpress] Error 2
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-vexpress/Makefile |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 36ea824..f224577 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -10,3 +10,6 @@ obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
>  obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> +
> +CFLAGS_dcscb.o				+=-march=armv7-a
> +CFLAGS_tc2_pm.o				+=-march=armv7-a
> 


-- 
Chen Gang
